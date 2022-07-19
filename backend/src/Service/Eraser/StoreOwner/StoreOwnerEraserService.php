<?php

namespace App\Service\Eraser\StoreOwner;

use App\AutoMapping;
use App\Constant\Admin\Subscription\AdminStoreSubscriptionConstant;
use App\Constant\Eraser\EraserResultConstant;
use App\Constant\Notification\NotificationTokenConstant;
use App\Entity\UserEntity;
use App\Request\Admin\StoreOwner\DeleteStoreOwnerAccountAndProfileByAdminRequest;
use App\Response\Eraser\DeleteStoreOwnerAccountAndProfileByAdminResponse;
use App\Service\Eraser\Subscription\StoreSubscriptionEraserService;
use App\Service\Notification\NotificationFirebaseService;
use App\Service\Order\OrderService;
use App\Service\ResetPassword\ResetPasswordOrderService;
use App\Service\StoreOwner\StoreOwnerProfileService;
use App\Service\StoreOwnerBranch\StoreOwnerBranchService;
use App\Service\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersService;
use App\Service\StoreOwnerPayment\StoreOwnerPaymentService;
use App\Service\StoreOwnerPaymentFromCompany\StoreOwnerPaymentFromCompanyService;
use App\Service\User\UserService;
use App\Service\Verification\VerificationService;

class StoreOwnerEraserService
{
    private AutoMapping $autoMapping;
    private OrderService $orderService;
    private UserService $userService;
    private VerificationService $verificationService;
    private StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService;
    private StoreOwnerPaymentService $storeOwnerPaymentService;
    private StoreOwnerPaymentFromCompanyService $storeOwnerPaymentFromCompanyService;
    private NotificationFirebaseService $notificationFirebaseService;
    private StoreSubscriptionEraserService $storeSubscriptionEraserService;
    private StoreOwnerBranchService $storeOwnerBranchService;
    private StoreOwnerProfileService $storeOwnerProfileService;
    private ResetPasswordOrderService $resetPasswordOrderService;

    public function __construct(AutoMapping $autoMapping, OrderService $orderService, UserService $userService, VerificationService $verificationService, StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService,
                                StoreOwnerPaymentService $storeOwnerPaymentService, StoreOwnerPaymentFromCompanyService $storeOwnerPaymentFromCompanyService,
                                NotificationFirebaseService $notificationFirebaseService, StoreSubscriptionEraserService $storeSubscriptionEraserService, StoreOwnerBranchService $storeOwnerBranchService,
                                StoreOwnerProfileService $storeOwnerProfileService, ResetPasswordOrderService $resetPasswordOrderService)
    {
        $this->autoMapping = $autoMapping;
        $this->orderService = $orderService;
        $this->userService = $userService;
        $this->verificationService = $verificationService;
        $this->storeOwnerDuesFromCashOrdersService = $storeOwnerDuesFromCashOrdersService;
        $this->storeOwnerPaymentService = $storeOwnerPaymentService;
        $this->storeOwnerPaymentFromCompanyService = $storeOwnerPaymentFromCompanyService;
        $this->notificationFirebaseService = $notificationFirebaseService;
        $this->storeSubscriptionEraserService = $storeSubscriptionEraserService;
        $this->storeOwnerBranchService = $storeOwnerBranchService;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
        $this->resetPasswordOrderService = $resetPasswordOrderService;
    }

    public function deleteStoreOwnerAccountAndProfileByAdmin(DeleteStoreOwnerAccountAndProfileByAdminRequest $request): int|DeleteStoreOwnerAccountAndProfileByAdminResponse|null
    {
        // check store dues from cash orders
        $storeDuesFromCashOrders = $this->storeOwnerDuesFromCashOrdersService->getStoreOwnerDuesFromCashOrdersByStoreOwnerId($request->getStoreOwnerId());

        if (! empty($storeDuesFromCashOrders)) {
            return EraserResultConstant::CAN_NOT_DELETE_STORE_HAS_DUES_FROM_CASH_ORDERS;
        }

        // check if there is payment of the store
        $storePayment = $this->storeOwnerPaymentService->getPaymentsByStoreOwnerId($request->getStoreOwnerId());

        if (! empty($storePayment)) {
            return EraserResultConstant::CAN_NOT_DELETE_STORE_HAS_PAYMENTS;
        }

        // check if there is payment from company to store
        $storePaymentFromCompany = $this->storeOwnerPaymentFromCompanyService->getPaymentsFromCompanyByStoreOwnerId($request->getStoreOwnerId());

        if (! empty($storePaymentFromCompany)) {
            return EraserResultConstant::CAN_NOT_DELETE_STORE_HAS_PAYMENTS_FROM_COMPANY;
        }

        // check if store has orders
        $orders = $this->orderService->checkIfStoreHasOrdersByStoreOwnerId($request->getStoreOwnerId());

        if ($orders === EraserResultConstant::STORE_HAS_ORDERS) {
            return EraserResultConstant::STORE_HAS_ORDERS;
        }

        // delete firebase notification token
        $this->notificationFirebaseService->deleteTokenByUserAndAppType($request->getStoreOwnerId(), NotificationTokenConstant::APP_TYPE_STORE);

        // delete subscription/s
        $deletingResult = $this->storeSubscriptionEraserService->deleteStoreOwnerSubscription($request->getStoreOwnerId());

        if ($deletingResult === AdminStoreSubscriptionConstant::STORE_SUBSCRIPTION_HAS_PAYMENTS) {
            return EraserResultConstant::CAN_NOT_DELETE_STORE_HAS_PAYMENTS;
        }

        // delete store branched
        $this->storeOwnerBranchService->deleteAllStoreBranchesByStoreOwnerId($request->getStoreOwnerId());

        // delete store profile
        $this->storeOwnerProfileService->deleteStoreOwnerProfileByStoreOwnerId($request->getStoreOwnerId());

        // delete verification code
        $this->verificationService->deleteAllVerificationCodesByIdOfUser($request->getStoreOwnerId());

        // delete reset password requests
        $this->resetPasswordOrderService->deleteAllResetPasswordOrdersByUserId($request->getStoreOwnerId());

        // delete user record
        $userResult = $this->userService->deleteUserById($request->getStoreOwnerId());

        return $this->autoMapping->map(UserEntity::class, DeleteStoreOwnerAccountAndProfileByAdminResponse::class, $userResult);
    }
}
