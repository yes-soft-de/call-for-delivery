<?php

namespace App\Service\Eraser;

use App\AutoMapping;
use App\Constant\Eraser\EraserResultConstant;
use App\Constant\Notification\NotificationTokenConstant;
use App\Entity\UserEntity;
use App\Request\Eraser\DeleteCaptainAccountAndProfileBySuperAdminRequest;
use App\Response\Eraser\DeleteCaptainAccountAndProfileBySuperAdminResponse;
use App\Service\Captain\CaptainService;
use App\Service\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashService;
use App\Service\CaptainFinancialSystem\CaptainFinancialDuesService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemDetailService;
use App\Service\CaptainPayment\CaptainPaymentService;
use App\Service\CaptainPayment\CaptainPaymentToCompanyService;
use App\Service\ChatRoom\OrderChatRoomService;
use App\Service\Image\ImageService;
use App\Service\Notification\NotificationFirebaseService;
use App\Service\Order\OrderService;
use App\Service\User\UserService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class CaptainEraserService
{
    private AutoMapping $autoMapping;
    private ParameterBagInterface $param;
    private OrderService $orderService;
    private CaptainAmountFromOrderCashService $captainAmountFromOrderCashService;
    private CaptainFinancialDuesService $captainFinancialDuesService;
    private CaptainPaymentService $captainPaymentService;
    private CaptainPaymentToCompanyService $captainPaymentToCompanyService;
    private CaptainFinancialSystemDetailService $captainFinancialSystemDetailService;
    private ImageService $imageService;
    private NotificationFirebaseService $notificationFirebaseService;
    private OrderChatRoomService $orderChatRoomService;
    private CaptainService $captainService;
    private UserService $userService;

    public function __construct(AutoMapping $autoMapping, ParameterBagInterface $param, OrderService $orderService, CaptainAmountFromOrderCashService $captainAmountFromOrderCashService,
                                CaptainFinancialDuesService $captainFinancialDuesService, CaptainPaymentService $captainPaymentService, CaptainPaymentToCompanyService $captainPaymentToCompanyService,
                                CaptainFinancialSystemDetailService $captainFinancialSystemDetailService, ImageService $imageService, NotificationFirebaseService $notificationFirebaseService,
                                OrderChatRoomService $orderChatRoomService, CaptainService $captainService, UserService $userService)
    {
        $this->autoMapping = $autoMapping;
        $this->param = $param;
        $this->orderService = $orderService;
        $this->captainAmountFromOrderCashService = $captainAmountFromOrderCashService;
        $this->captainFinancialDuesService = $captainFinancialDuesService;
        $this->captainPaymentService = $captainPaymentService;
        $this->captainPaymentToCompanyService = $captainPaymentToCompanyService;
        $this->captainFinancialSystemDetailService = $captainFinancialSystemDetailService;
        $this->imageService = $imageService;
        $this->notificationFirebaseService = $notificationFirebaseService;
        $this->orderChatRoomService = $orderChatRoomService;
        $this->captainService = $captainService;
        $this->userService = $userService;
    }

    public function deleteCaptainAccountAndProfileBySuperAdmin(DeleteCaptainAccountAndProfileBySuperAdminRequest $request): string|DeleteCaptainAccountAndProfileBySuperAdminResponse
    {
        // first check the password
        if ($request->getPassword() !== $this->param->get('deletion_user_password')) {
            return EraserResultConstant::DELETION_USER_PASSWORD_INCORRECT;
        }

        // password is correct, check if there are cash orders payments for the captain
        $cashOrdersPayments = $this->captainAmountFromOrderCashService->getCashOrdersPaymentsByCaptainId($request->getId());

        if (! empty($cashOrdersPayments)) {
            return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_CASH_ORDER_PAYMENTS;
        }

        // check if there are financial dues for the captain
        $financialDues = $this->captainFinancialDuesService->getFinancialDuesByCaptainId($request->getId());

        if (! empty($financialDues)) {
            return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_FINANCIAL_DUES;
        }

        // check if there are payments for the captain
        $payments = $this->captainPaymentService->getPaymentsByCaptainId($request->getId());

        if (! empty($payments)) {
            return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_PAYMENTS;
        }

        // check if there are payments to the company for the captain
        $paymentsToCompany = $this->captainPaymentToCompanyService->getPaymentToCompanyByCaptainId($request->getId());

        if (! empty($paymentsToCompany)) {
            return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_PAYMENTS_TO_COMPANY;
        }

        // check if there is no orders
        $orders = $this->orderService->getOrdersByCaptainId($request->getId());

        if (! empty($orders)) {
            return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_ORDERS;
        }

        // Now we can start deleting the account and related info
        // delete financial system that the captain subscribed with
        $this->captainFinancialSystemDetailService->deleteCaptainFinancialSystemDetailsByCaptainId($request->getId());

        // delete all captain profile images
        $this->imageService->deleteCaptainProfileImagesByCaptainId($request->getId());

        // delete notification firebase token
        $this->notificationFirebaseService->deleteTokenByUserAndAppType($request->getId(), NotificationTokenConstant::APP_TYPE_CAPTAIN);

        // delete order chat rooms
        $this->orderChatRoomService->deleteOrderChatRoomEntitiesByCaptainId($request->getId());

        // delete captain profile
        $this->captainService->deleteCaptainProfileByCaptainId($request->getId());

        // finally, delete captain user record
        $userResult = $this->userService->deleteUserById($request->getId());

        return $this->autoMapping->map(UserEntity::class, DeleteCaptainAccountAndProfileBySuperAdminResponse::class, $userResult);
    }
}
