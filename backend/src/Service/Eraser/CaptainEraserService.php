<?php

namespace App\Service\Eraser;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueResultConstant;
use App\Constant\Eraser\EraserResultConstant;
use App\Constant\Notification\NotificationTokenConstant;
use App\Entity\ChatRoomEntity;
use App\Entity\UserEntity;
use App\Request\Admin\Captain\DeleteCaptainAccountAndProfileByAdminRequest;
use App\Request\Eraser\DeleteCaptainAccountAndProfileBySuperAdminRequest;
use App\Response\Admin\Captain\DeleteCaptainAccountAndProfileByAdminResponse;
use App\Response\Eraser\DeleteCaptainAccountAndProfileBySuperAdminResponse;
use App\Security\IsGranted\CanDeleteCaptainAccountAndProfileByAdminService;
use App\Service\Captain\CaptainService;
use App\Service\CaptainFinancialSystem\CaptainFinancialDuesService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemDetailService;
use App\Service\ChatRoom\ChatRoomService;
use App\Service\ChatRoom\OrderChatRoomService;
use App\Service\Image\ImageService;
use App\Service\Notification\NotificationFirebaseService;
use App\Service\OrderLog\OrderLogService;
use App\Service\OrderTimeLine\OrderTimeLineService;
use App\Service\ResetPassword\ResetPasswordOrderService;
use App\Service\User\UserService;
use App\Service\Verification\VerificationService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class CaptainEraserService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private ParameterBagInterface $param,
        private CaptainFinancialSystemDetailService $captainFinancialSystemDetailService,
        private ImageService $imageService,
        private NotificationFirebaseService $notificationFirebaseService,
        private OrderChatRoomService $orderChatRoomService,
        private CaptainService $captainService,
        private UserService $userService,
        private VerificationService $verificationService,
        private ResetPasswordOrderService $resetPasswordOrderService,
        private EntityManagerInterface $entityManager,
        private CanDeleteCaptainAccountAndProfileByAdminService $canDeleteCaptainAccountAndProfileByAdminService,
        private CaptainFinancialDuesService $captainFinancialDuesService,
        private ChatRoomService $chatRoomService,
        private OrderTimeLineService $orderTimeLineService,
        private OrderLogService $orderLogService
    )
    {
    }

    public function deleteCaptainAccountAndProfileBySuperAdmin(DeleteCaptainAccountAndProfileBySuperAdminRequest $request): string|DeleteCaptainAccountAndProfileBySuperAdminResponse
    {
        // first check the password
        if ($request->getPassword() !== $this->param->get('deletion_user_password')) {
            return EraserResultConstant::DELETION_USER_PASSWORD_INCORRECT;
        }

        // password is correct, check if there are cash orders payments for the captain
        $canDeleteCaptainResult = $this->canDeleteCaptainAccountAndProfileByAdminService->checkIfCaptainAccountAndProfileCanBeDeletedByCaptainId($request->getId());

        if ($canDeleteCaptainResult !== EraserResultConstant::CAPTAIN_ACCOUNT_AND_PROFILE_CAN_BE_DELETED) {
            if ($canDeleteCaptainResult !== CaptainFinancialDueResultConstant::CAPTAIN_FINANCIAL_DUE_HAVE_ZERO_VALUE_CONST) {
                return $canDeleteCaptainResult;
            }
        }

        // Now we can start deleting the account and related info
        // Delete captain financial dues (as long as it have zero value)
        $this->deleteAllCaptainFinancialDuesByCaptainId($request->getId());

        // Update order time line record/s related to the captain by setting captain profile field to NULL value,
        // in order to be able to delete captain profile
        $this->updateOrderTimelineCaptainProfileToNullByCaptainUserId($request->getId());

        // Update order log record/s related to the captain by setting captain profile field to NULL value,
        // in order to be able to delete captain profile
        $this->updateOrderLogCaptainProfileToNullByCaptainUserId($request->getId());

        // delete financial system that the captain subscribed with
        $this->captainFinancialSystemDetailService->deleteCaptainFinancialSystemDetailsByCaptainId($request->getId());

        // delete all captain profile images
        $this->imageService->deleteCaptainProfileImagesByCaptainId($request->getId());

        // delete notification firebase token
        $this->notificationFirebaseService->deleteTokenByUserAndAppType($request->getId(), NotificationTokenConstant::APP_TYPE_CAPTAIN);

        // delete order chat rooms
        $this->orderChatRoomService->deleteOrderChatRoomEntitiesByCaptainId($request->getId());

        // delete chat room
        $this->deleteChatRoomByUserId($request->getId());

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
            // First, we have to check if we can delete the captain
            $canDeleteCaptainResult = $this->canDeleteCaptainAccountAndProfileByAdminService->checkIfCaptainAccountAndProfileCanBeDeletedByCaptainId($request->getCaptainId());

            if ($canDeleteCaptainResult !== EraserResultConstant::CAPTAIN_ACCOUNT_AND_PROFILE_CAN_BE_DELETED) {
                if ($canDeleteCaptainResult !== CaptainFinancialDueResultConstant::CAPTAIN_FINANCIAL_DUE_HAVE_ZERO_VALUE_CONST) {
                    return $canDeleteCaptainResult;
                }
            }

            ///// Now we can start deleting the account and related info
            // Delete captain financial dues (as long as it have zero value)
            $this->deleteAllCaptainFinancialDuesByCaptainId($request->getCaptainId());

            // Update order time line record/s related to the captain by setting captain profile field to NULL value,
            // in order to be able to delete captain profile
            $this->updateOrderTimelineCaptainProfileToNullByCaptainUserId($request->getCaptainId());

            // Update order log record/s related to the captain by setting captain profile field to NULL value,
            // in order to be able to delete captain profile
            $this->updateOrderLogCaptainProfileToNullByCaptainUserId($request->getCaptainId());

            // delete financial system that the captain subscribed with
            $this->captainFinancialSystemDetailService->deleteCaptainFinancialSystemDetailsByCaptainId($request->getCaptainId());

            // delete all captain profile images
            $this->imageService->deleteCaptainProfileImagesByCaptainId($request->getCaptainId());

            // delete notification firebase token
            $this->notificationFirebaseService->deleteTokenByUserAndAppType($request->getCaptainId(), NotificationTokenConstant::APP_TYPE_CAPTAIN);

            // delete order chat rooms
            $this->orderChatRoomService->deleteOrderChatRoomEntitiesByCaptainId($request->getCaptainId());

            // delete chat room
            $this->deleteChatRoomByUserId($request->getCaptainId());

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

    public function deleteAllCaptainFinancialDuesByCaptainId(int $captainId): array
    {
        return $this->captainFinancialDuesService->deleteAllCaptainFinancialDuesByCaptainId($captainId);
    }

    public function deleteChatRoomByUserId(int $userId): ChatRoomEntity|int
    {
        return $this->chatRoomService->deleteChatRoomByUserId($userId);
    }

    /**
     * Update captainProfile field to null for each order timeline record related to specific captain
     */
    public function updateOrderTimelineCaptainProfileToNullByCaptainUserId(int $captainUserId): array|int
    {
        return $this->orderTimeLineService->updateOrderTimelineCaptainProfileToNullByCaptainUserId($captainUserId);
    }

    /**
     * Update captainProfile field to null for each order log record related to specific captain
     */
    public function updateOrderLogCaptainProfileToNullByCaptainUserId(int $captainUserId): array|int
    {
        return $this->orderLogService->updateOrderLogCaptainProfileToNullByCaptainUserId($captainUserId);
    }
}
