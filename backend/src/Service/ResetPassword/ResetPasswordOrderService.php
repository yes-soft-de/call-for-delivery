<?php


namespace App\Service\ResetPassword;

use App\AutoMapping;
use App\Constant\AppFeature\AppFeatureNameConstant;
use App\Constant\MalathSMS\MessageUsedAsConstant;
use App\Constant\ResetPassword\ResetPasswordResultConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\ResetPasswordOrderEntity;
use App\Entity\UserEntity;
use App\Manager\ResetPassword\ResetPasswordOrderManager;
use App\Request\ResetPassword\ResetPasswordOrderCreateRequest;
use App\Request\ResetPassword\VerifyResetPasswordCodeRequest;
use App\Request\User\UserPasswordUpdateByLoggedInUserRequest;
use App\Request\User\UserPasswordUpdateRequest;
use App\Response\Admin\ResetPassword\ResetPasswordOrderGetForSuperAdminResponse;
use App\Response\ResetPassword\ResetPasswordOrderGetResponse;
use App\Response\User\UserRegisterResponse;
use App\Service\AppFeature\AppFeatureService;
use App\Service\SMS\SMSMessageService;
use App\Service\User\UserService;

class ResetPasswordOrderService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private ResetPasswordOrderManager $resetPasswordOrderManager,
        private UserService $userService,
        private SMSMessageService $SMSMessageService,
        private AppFeatureService $appFeatureService
    )
    {
    }

    public function createResetPasswordOrder(ResetPasswordOrderCreateRequest $request): ResetPasswordOrderGetResponse
    {
        $response = [];

        // First, check if user exist
        $user = $this->userService->getUserByUserIdAndRole($request->getUserId(), $request->getRole());

        if ($user) {
            // while user exists, then make a new reset password order
            $resetPasswordOrder = $this->resetPasswordOrderManager->createResetPasswordOrder($request, $user);

            if ($resetPasswordOrder) {
                // send sms message with verification code if sending sms feature is activated
                if ($this->getAppFeatureStatusByAppFeatureName(AppFeatureNameConstant::APP_FEATURE_SMS_NAME)) {
                    // send code in SMS message
                    $this->SMSMessageService->sendSMSMessage($resetPasswordOrder->getUser()->getUserId(), $resetPasswordOrder->getCode(),
                        MessageUsedAsConstant::RESET_PASSWORD_MESSAGE);
                }

                return $this->autoMapping->map(ResetPasswordOrderEntity::class, ResetPasswordOrderGetResponse::class,
                    $resetPasswordOrder);
            }

        } else {
            $response['status'] = UserReturnResultConstant::USER_NOT_FOUND_RESULT;

            return $this->autoMapping->map('array', ResetPasswordOrderGetResponse::class, $response);
        }
    }

    public function verifyResetPasswordCode(VerifyResetPasswordCodeRequest $request): ResetPasswordOrderGetResponse
    {
        $response = [];

        $resetPasswordOrder = $this->resetPasswordOrderManager->getResetPasswordOrderByActiveCode($request->getCode());

        if ($resetPasswordOrder) {
            // while there is active code, check if its duration time is valid
            $interval = date_diff(new \DateTime('now') , $resetPasswordOrder->getCreatedAt());

            $different_days = $interval->format('%d');

            if ($different_days == 0) {
                $different_hours = $interval->format('%h');

                if ($different_hours <= 1) {
                    $response['status'] = ResetPasswordResultConstant::VALID_RESET_PASSWORD_CODE;

                    $this->updateResetPasswordOrderStatus($resetPasswordOrder, false);

                } else {
                    $response['status'] = ResetPasswordResultConstant::INVALID_RESET_PASSWORD_CODE;
                }

            } else {
                $response['status'] = ResetPasswordResultConstant::INVALID_RESET_PASSWORD_CODE;
            }

        } else {
            $response['status'] = ResetPasswordResultConstant::NO_RESET_PASSWORD_CODE_IS_EXIST;
        }

        return $this->autoMapping->map('array', ResetPasswordOrderGetResponse::class, $response);
    }

    public function updateResetPasswordOrderStatus(ResetPasswordOrderEntity $resetPasswordOrderEntity, bool $status): ResetPasswordOrderEntity
    {
        return $this->resetPasswordOrderManager->updateResetPasswordOrderStatus($resetPasswordOrderEntity, $status);
    }

    public function updateUserPassword(UserPasswordUpdateRequest $request): UserRegisterResponse|string
    {
        return $this->userService->updateUserPassword($request);
    }

    public function getAllResetPasswordOrdersBySuperAdmin(): array
    {
        $response = [];

        $resetPasswordOrders = $this->resetPasswordOrderManager->getAllResetPasswordOrdersBySuperAdmin();

        foreach ($resetPasswordOrders as $key=>$value) {
            $response[$key] = $this->autoMapping->map(ResetPasswordOrderEntity::class, ResetPasswordOrderGetForSuperAdminResponse::class, $value);

            $response[$key]->user = $this->getSpecificUserFields($value->getUser());
        }

        return $response;
    }

    public function getSpecificUserFields(UserEntity $userEntity): array
    {
        $response = [];

        $response['id'] = $userEntity->getId();
        $response['userId'] = $userEntity->getUserId();
        $response['roles'] = $userEntity->getRoles();

        return $response;
    }

    public function deleteAllResetPasswordOrdersByUserId(int $userId): array
    {
        return $this->resetPasswordOrderManager->deleteAllResetPasswordOrdersByUserId($userId);
    }

    public function updateUserPasswordByLoggedInUser(UserPasswordUpdateByLoggedInUserRequest $request): UserRegisterResponse|string
    {
        return $this->userService->updateUserPasswordByLoggedInUser($request);
    }

    /**
     * Get the status of sending SMS feature, activated or not
     */
    public function getAppFeatureStatusByAppFeatureName(string $featureName): ?bool
    {
        return $this->appFeatureService->getAppFeatureStatusByAppFeatureName($featureName);
    }
}
