<?php

namespace App\Service\Verification;

use App\AutoMapping;
use App\Constant\AppFeature\AppFeatureNameConstant;
use App\Constant\Verification\UserVerificationStatusConstant;
use App\Constant\Verification\VerificationCodeResultConstant;
use App\Entity\VerificationEntity;
use App\Manager\Verification\VerificationManager;
use App\Request\User\UserVerificationStatusUpdateRequest;
use App\Request\Verification\VerificationCreateRequest;
use App\Request\Verification\VerifyCodeRequest;
use App\Response\Verification\CodeVerificationResponse;
use App\Response\Verification\VerificationCreateResponse;
use App\Service\AppFeature\AppFeatureService;
use App\Service\MalathSMS\MalathSMSService;
use App\Service\User\UserService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class VerificationService
{
    private AutoMapping $autoMapping;
    private ParameterBagInterface $params;
    private VerificationManager $verificationManager;
    private MalathSMSService $malathSMSService;
    private UserService $userService;
    private AppFeatureService $appFeatureService;

    public function __construct(AutoMapping $autoMapping, VerificationManager $verificationManager, MalathSMSService $malathSMSService, ParameterBagInterface $params,
                                UserService $userService, AppFeatureService $appFeatureService)
    {
        $this->autoMapping = $autoMapping;
        $this->params = $params;
        $this->verificationManager = $verificationManager;
        $this->malathSMSService = $malathSMSService;
        $this->userService = $userService;
        $this->appFeatureService = $appFeatureService;
    }

    public function createVerificationCode(VerificationCreateRequest $request): ?VerificationCreateResponse
    {
        $verificationEntity = $this->verificationManager->createVerificationCode($request);

        $response = $this->autoMapping->map(VerificationEntity::class, VerificationCreateResponse::class, $verificationEntity);

        if ($verificationEntity) {
            // send sms message with verification code if sending sms feature is activated
            if ($this->appFeatureService->getAppFeatureStatusByAppFeatureName(AppFeatureNameConstant::APP_FEATURE_SMS_NAME)) {
//                $result = $this->sendSMSMessage($request->getUser()->getUserId(), $verificationEntity->getCode());
//                $response->smsMessageStatus = $result;
            }
        }

        return $response;
    }

    public function sendSMSMessage(string $phone, string $code): string
    {
        $messageText = 'Please use this code to activate your account:'.' '.$code;

        // send SMS message
        $this->malathSMSService->setUserName($this->params->get('malath_username'));
        $this->malathSMSService->setPassword($this->params->get('malath_password'));

        $result = $this->malathSMSService->sendSMS($phone, "MANDOBQUICK", $messageText);

        if ($result) {
            if ($result['RESULT'] === 0) {
                // message sent successfully
                return 'sentSuccessfully';

            } elseif ($result['RESULT'] === 101) {
                // Parameter are missing
                return 'parameterAreMissing';

            } elseif ($result['RESULT'] === 104) {
                // either user name or password are missing or your Account is on hold
                return 'userNameOrPasswordAreMissingOrYourAccountIsOnHold';

            } elseif ($result['RESULT'] === 105) {
                // Credit are not available
                return 'creditAreNotAvailable';
            }
        }
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
}
