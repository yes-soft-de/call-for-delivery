<?php

namespace App\Service\Eraser\StoreOwner;

use App\AutoMapping;
use App\Constant\Admin\Subscription\AdminStoreSubscriptionConstant;
use App\Constant\Eraser\EraserResultConstant;
use App\Constant\Notification\NotificationTokenConstant;
use App\Entity\UserEntity;
use App\Request\Admin\StoreOwner\DeleteStoreOwnerAccountAndProfileByAdminRequest;
use App\Response\Eraser\DeleteStoreOwnerAccountAndProfileByAdminResponse;
use App\Security\IsGranted\DeleteStoreOwnerAccountAndProfileGrantService;
use App\Service\Eraser\Subscription\StoreSubscriptionEraserService;
use App\Service\Notification\NotificationFirebaseService;
use App\Service\ResetPassword\ResetPasswordOrderService;
use App\Service\StoreOwner\StoreOwnerProfileService;
use App\Service\StoreOwnerBranch\StoreOwnerBranchService;
use App\Service\User\UserService;
use App\Service\Verification\VerificationService;
use Doctrine\ORM\EntityManagerInterface;

class StoreOwnerEraserService
{
    private AutoMapping $autoMapping;
    private UserService $userService;
    private VerificationService $verificationService;
    private NotificationFirebaseService $notificationFirebaseService;
    private StoreSubscriptionEraserService $storeSubscriptionEraserService;
    private StoreOwnerBranchService $storeOwnerBranchService;
    private StoreOwnerProfileService $storeOwnerProfileService;
    private ResetPasswordOrderService $resetPasswordOrderService;
    private DeleteStoreOwnerAccountAndProfileGrantService $deleteStoreOwnerAccountAndProfileGrantService;
    private EntityManagerInterface $entityManager;

    public function __construct(AutoMapping $autoMapping, UserService $userService, VerificationService $verificationService, NotificationFirebaseService $notificationFirebaseService,
                                StoreSubscriptionEraserService $storeSubscriptionEraserService, StoreOwnerBranchService $storeOwnerBranchService,
                                StoreOwnerProfileService $storeOwnerProfileService, ResetPasswordOrderService $resetPasswordOrderService, EntityManagerInterface $entityManager,
                                DeleteStoreOwnerAccountAndProfileGrantService $deleteStoreOwnerAccountAndProfileGrantService)
    {
        $this->autoMapping = $autoMapping;
        $this->userService = $userService;
        $this->verificationService = $verificationService;
        $this->notificationFirebaseService = $notificationFirebaseService;
        $this->storeSubscriptionEraserService = $storeSubscriptionEraserService;
        $this->storeOwnerBranchService = $storeOwnerBranchService;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
        $this->resetPasswordOrderService = $resetPasswordOrderService;
        $this->deleteStoreOwnerAccountAndProfileGrantService = $deleteStoreOwnerAccountAndProfileGrantService;
        $this->entityManager = $entityManager;
    }

    public function deleteStoreOwnerAccountAndProfileByAdmin(DeleteStoreOwnerAccountAndProfileByAdminRequest $request): int|DeleteStoreOwnerAccountAndProfileByAdminResponse|null
    {
        try {
            $this->entityManager->getConnection()->beginTransaction();

            // First, check if we can delete the store owner account and profile
            $grantResult = $this->deleteStoreOwnerAccountAndProfileGrantService->checkIfStoreOwnerAccountAndProfileCanBeDeletedByStoreOwnerId($request->getStoreOwnerId());

            if ($grantResult !== EraserResultConstant::STORE_OWNER_ACCOUNT_AND_PROFILE_CAN_BE_DELETED) {
                return $grantResult;
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

            $this->entityManager->getConnection()->commit();

            return $this->autoMapping->map(UserEntity::class, DeleteStoreOwnerAccountAndProfileByAdminResponse::class, $userResult);

        } catch (\Exception $exception) {
            $this->entityManager->getConnection()->rollBack();

            throw $exception;
        }
    }
}
