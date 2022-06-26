<?php


namespace App\Service\ResetPassword;

use App\AutoMapping;
use App\Constant\MalathSMS\MessageUsedAsConstant;
use App\Constant\ResetPassword\ResetPasswordResultConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\ResetPasswordOrderEntity;
use App\Entity\UserEntity;
use App\Manager\ResetPassword\ResetPasswordOrderManager;
use App\Request\ResetPassword\ResetPasswordOrderCreateRequest;
use App\Request\ResetPassword\VerifyResetPasswordCodeRequest;
use App\Request\User\UserPasswordUpdateRequest;
use App\Response\Admin\ResetPassword\ResetPasswordOrderGetForSuperAdminResponse;
use App\Response\ResetPassword\ResetPasswordOrderGetResponse;
use App\Response\User\UserRegisterResponse;
use App\Service\MalathSMS\SMSMessageService;
use App\Service\User\UserService;

class ResetPasswordOrderService
{
    private AutoMapping $autoMapping;
    private ResetPasswordOrderManager $resetPasswordOrderManager;
    private UserService $userService;
    private SMSMessageService $SMSMessageService;

    public function __construct(AutoMapping $autoMapping, ResetPasswordOrderManager $resetPasswordOrderManager, UserService $userService, SMSMessageService $SMSMessageService)
    {
        $this->autoMapping = $autoMapping;
        $this->resetPasswordOrderManager = $resetPasswordOrderManager;
        $this->userService = $userService;
        $this->SMSMessageService = $SMSMessageService;
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
                // send code in SMS message
                $this->SMSMessageService->sendSMSMessage($resetPasswordOrder->getUser()->getUserId(), $resetPasswordOrder->getCode(), MessageUsedAsConstant::RESET_PASSWORD_MESSAGE);

                return $this->autoMapping->map(ResetPasswordOrderEntity::class, ResetPasswordOrderGetResponse::class, $resetPasswordOrder);
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
}
