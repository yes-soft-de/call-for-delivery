<?php

namespace App\Service\Verification;

use App\AutoMapping;
use App\Constant\MalathSMS\MessageUsedAsConstant;
use App\Constant\AppFeature\AppFeatureNameConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Constant\Verification\UserVerificationStatusConstant;
use App\Constant\Verification\VerificationCodeResultConstant;
use App\Entity\VerificationEntity;
use App\Manager\Verification\VerificationManager;
use App\Request\User\UserVerificationStatusGetRequest;
use App\Request\User\UserVerificationStatusUpdateRequest;
use App\Request\Verification\VerificationCodeResendRequest;
use App\Request\Verification\VerificationCreateRequest;
use App\Request\Verification\VerifyCodeRequest;
use App\Response\User\UserVerificationStatusGetResponse;
use App\Response\Verification\CodeVerificationResponse;
use App\Response\Verification\VerificationCodeGetResponse;
use App\Response\Verification\VerificationCreateResponse;
use App\Service\AppFeature\AppFeatureService;
use App\Service\SMS\SMSMessageService;
use App\Service\User\UserService;

class VerificationService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private VerificationManager $verificationManager,
        private UserService $userService,
        private SMSMessageService $SMSMessageService,
        private AppFeatureService $appFeatureService
    )

    {
    }

    public function createVerificationCode(VerificationCreateRequest $request): ?VerificationCreateResponse
    {
        $verificationEntity = $this->verificationManager->createVerificationCode($request);

        $response = $this->autoMapping->map(VerificationEntity::class, VerificationCreateResponse::class, $verificationEntity);

        if ($verificationEntity) {
            // send sms message with verification code if sending sms feature is activated
            if ($this->getAppFeatureStatusByAppFeatureName(AppFeatureNameConstant::APP_FEATURE_SMS_NAME)) {
                $result = $this->SMSMessageService->sendSMSMessage($request->getUser()->getUserId(), $verificationEntity->getCode(),
                    MessageUsedAsConstant::USER_VERIFICATION_MESSAGE);

                $response->smsMessageStatus = $result;
            }
        }

        return $response;
    }

    public function checkVerificationCode(VerifyCodeRequest $request): string
    {
        $result = $this->verificationManager->checkVerificationCode($request);

        if($result === VerificationCodeResultConstant::ACTIVATED_RESULT)
        {
            // update the verification status of the user
            $this->updateVerificationStatusOfUser($request, UserVerificationStatusConstant::VERIFIED_STATUS);
        }

        return $result;
    }

    public function updateVerificationStatusOfUser(VerifyCodeRequest $request, int $verificationStatus)
    {
        $userVerificationUpdateRequest = $this->autoMapping->map(VerifyCodeRequest::class, UserVerificationStatusUpdateRequest::class, $request);

        $userVerificationUpdateRequest->setVerificationStatus($verificationStatus);

        $this->userService->updateUserVerificationStatus($userVerificationUpdateRequest);
    }

    public function getUserVerificationStatusByUserId(UserVerificationStatusGetRequest $request): ?UserVerificationStatusGetResponse
    {
        $result = $this->userService->getUserVerificationStatusByUserId($request->getUserId());

        if ($result !== null) {
           if ($result['verificationStatus'] === 0) {
               // send SMS message with verification code
               $this->initializeVerificationCodeResendRequestAndResendingNewCode($request->getUserId());
           }
        }

        return $this->autoMapping->map('array', UserVerificationStatusGetResponse::class, $result);
    }

    public function createVerificationCodeForUserByUserId(string $userId): null|string|VerificationCreateResponse
    {
        // get user entity by userId
        $userEntity = $this->userService->getUseEntityByUserId($userId);

        if (! $userEntity) {
            return UserReturnResultConstant::USER_NOT_FOUND_RESULT;
        }

        // initialize new verification code create request
        $verificationCodeCreateRequest = new VerificationCreateRequest();

        $verificationCodeCreateRequest->setUser($userEntity);

        // create new code
        return $this->createVerificationCode($verificationCodeCreateRequest);
    }

    public function reSendNewVerificationCode(VerificationCodeResendRequest $request): CodeVerificationResponse
    {
        $response = [];

        // First, check if the user which ask for new code is not verified yet.
        $verificationStatus = $this->userService->getUserVerificationStatusByUserId($request->getUserId());

        if ($verificationStatus) {
            if (! $verificationStatus['verificationStatus']) {
                // User is not verified yet, so we can send new code
                // But firstly, delete previous sent codes for the same user
                $this->verificationManager->deleteAllVerificationCodesByUserId($request->getUserId());

                // Finally, insert new code for the user
                $verificationCodeResult = $this->createVerificationCodeForUserByUserId($request->getUserId());

                if ($verificationCodeResult) {
                    if ($verificationCodeResult === UserReturnResultConstant::USER_NOT_FOUND_RESULT) {
                        $response['resultMessage'] = UserReturnResultConstant::USER_NOT_FOUND_RESULT;

                    } else {
                        $response['resultMessage'] = VerificationCodeResultConstant::NEW_CODE_WAS_CREATED;
                    }

                } else {
                    $response['resultMessage'] = VerificationCodeResultConstant::VERIFICATION_CODE_WAS_NOT_CREATED_SUCCESSFULLY;
                }

            } else {
                $response['resultMessage'] = VerificationCodeResultConstant::USER_ALREADY_VERIFIED;
            }

        } else {
            $response['resultMessage'] = UserReturnResultConstant::USER_NOT_FOUND_RESULT;
        }

        return $this->autoMapping->map('array', CodeVerificationResponse::class, $response);
    }

    public function getAllVerificationCodeByUserId($userID): array
    {
        $response = [];

        $verificationCodes = $this->verificationManager->getAllVerificationCodeByUserId($userID);

        foreach ($verificationCodes as $key=>$value) {
            $response[$key] = $this->autoMapping->map(VerificationEntity::class, VerificationCodeGetResponse::class, $value);

            $response[$key]->userId = $value->getUser()->getUserId();
            $response[$key]->verificationStatus = $value->getUser()->getVerificationStatus();
            $response[$key]->roles = $value->getUser()->getRoles();
        }

        return $response;
    }

    public function initializeVerificationCodeResendRequestAndResendingNewCode(string $userId)
    {
        $verificationCodeResendRequest = new VerificationCodeResendRequest();

        $verificationCodeResendRequest->setUserId($userId);

        $this->reSendNewVerificationCode($verificationCodeResendRequest);
    }

    public function deleteAllVerificationCodesByIdOfUser(int $userId): array
    {
        return $this->verificationManager->deleteAllVerificationCodesByIdOfUser($userId);
    }

    /**
     * Get the status of sending SMS feature, activated or not
     */
    public function getAppFeatureStatusByAppFeatureName(string $featureName): ?bool
    {
        return $this->appFeatureService->getAppFeatureStatusByAppFeatureName($featureName);
    }
}
