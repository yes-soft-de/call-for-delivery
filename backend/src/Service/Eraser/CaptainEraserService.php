<?php

namespace App\Service\Eraser;

use App\AutoMapping;
use App\Constant\Eraser\EraserResultConstant;
use App\Constant\Notification\NotificationTokenConstant;
use App\Entity\UserEntity;
use App\Request\Admin\Captain\DeleteCaptainAccountAndProfileByAdminRequest;
use App\Request\Eraser\DeleteCaptainAccountAndProfileBySuperAdminRequest;
use App\Response\Admin\Captain\DeleteCaptainAccountAndProfileByAdminResponse;
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
use App\Service\ResetPassword\ResetPasswordOrderService;
use App\Service\User\UserService;
use App\Service\Verification\VerificationService;
use Doctrine\ORM\EntityManagerInterface;
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
    private VerificationService $verificationService;
    private ResetPasswordOrderService $resetPasswordOrderService;
    private EntityManagerInterface $entityManager;

    public function __construct(AutoMapping $autoMapping, ParameterBagInterface $param, OrderService $orderService, CaptainAmountFromOrderCashService $captainAmountFromOrderCashService,
                                CaptainFinancialDuesService $captainFinancialDuesService, CaptainPaymentService $captainPaymentService, CaptainPaymentToCompanyService $captainPaymentToCompanyService,
                                CaptainFinancialSystemDetailService $captainFinancialSystemDetailService, ImageService $imageService, NotificationFirebaseService $notificationFirebaseService,
                                OrderChatRoomService $orderChatRoomService, CaptainService $captainService, UserService $userService, VerificationService $verificationService,
                                ResetPasswordOrderService $resetPasswordOrderService, EntityManagerInterface $entityManager)
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
        $this->verificationService = $verificationService;
        $this->resetPasswordOrderService = $resetPasswordOrderService;
        $this->entityManager = $entityManager;
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

        // delete related verification records
        $this->verificationService->deleteAllVerificationCodesByIdOfUser($request->getId());

        // delete reset password requests
        $this->resetPasswordOrderService->deleteAllResetPasswordOrdersByUserId($request->getId());

        // finally, delete captain user record
        $userResult = $this->userService->deleteUserById($request->getId());

        return $this->autoMapping->map(UserEntity::class, DeleteCaptainAccountAndProfileBySuperAdminResponse::class, $userResult);
    }

    public function deleteCaptainAccountAndProfileByAdmin(DeleteCaptainAccountAndProfileByAdminRequest $request): string|DeleteCaptainAccountAndProfileByAdminResponse
    {
        $this->entityManager->getConnection()->beginTransaction();

        try {
            // Check if there are cash orders payments for the captain
            $cashOrdersPayments = $this->captainAmountFromOrderCashService->getCashOrdersPaymentsByCaptainId($request->getCaptainId());

            if (!empty($cashOrdersPayments)) {
                return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_CASH_ORDER_PAYMENTS;
            }

            // check if there are financial dues for the captain
            $financialDues = $this->captainFinancialDuesService->getFinancialDuesByCaptainId($request->getCaptainId());

            if (!empty($financialDues)) {
                return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_FINANCIAL_DUES;
            }

            // check if there are payments for the captain
            $payments = $this->captainPaymentService->getPaymentsByCaptainId($request->getCaptainId());

            if (!empty($payments)) {
                return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_PAYMENTS;
            }

            // check if there are payments to the company for the captain
            $paymentsToCompany = $this->captainPaymentToCompanyService->getPaymentToCompanyByCaptainId($request->getCaptainId());

            if (!empty($paymentsToCompany)) {
                return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_PAYMENTS_TO_COMPANY;
            }

            // check if there is no orders
            $orders = $this->orderService->getOrdersByCaptainId($request->getCaptainId());

            if (!empty($orders)) {
                return EraserResultConstant::CAN_NOT_DELETE_USER_HAS_ORDERS;
            }

            // Now we can start deleting the account and related info
            // delete financial system that the captain subscribed with
            $this->captainFinancialSystemDetailService->deleteCaptainFinancialSystemDetailsByCaptainId($request->getCaptainId());

            // delete all captain profile images
            $this->imageService->deleteCaptainProfileImagesByCaptainId($request->getCaptainId());

            // delete notification firebase token
            $this->notificationFirebaseService->deleteTokenByUserAndAppType($request->getCaptainId(), NotificationTokenConstant::APP_TYPE_CAPTAIN);

            // delete order chat rooms
            $this->orderChatRoomService->deleteOrderChatRoomEntitiesByCaptainId($request->getCaptainId());

            // delete captain profile
            $this->captainService->deleteCaptainProfileByCaptainId($request->getCaptainId());

            // delete related verification records
            $this->verificationService->deleteAllVerificationCodesByIdOfUser($request->getCaptainId());

            // delete reset password requests
            $this->resetPasswordOrderService->deleteAllResetPasswordOrdersByUserId($request->getCaptainId());

            $captainProfile = $this->captainService->getCaptainProfileByUserId($request->getCaptainId());

            if ($captainProfile === null) {
                // finally, delete captain user record as long as his/her profile was deleted
                $userResult = $this->userService->deleteUserById($request->getCaptainId());
            }

            $this->entityManager->getConnection()->commit();

            return $this->autoMapping->map(UserEntity::class, DeleteCaptainAccountAndProfileByAdminResponse::class, $userResult);

        } catch (\Exception $e) {
            $this->entityManager->getConnection()->rollBack();
            throw $e;
        }
    }
}
