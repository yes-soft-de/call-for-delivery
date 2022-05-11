<?php


namespace App\Service\ResetPassword;

use App\AutoMapping;
use App\Constant\ResetPassword\ResetPasswordResultConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\ResetPasswordOrderEntity;
use App\Manager\ResetPassword\ResetPasswordOrderManager;
use App\Request\ResetPassword\ResetPasswordOrderCreateRequest;
use App\Request\ResetPassword\VerifyResetPasswordCodeRequest;
use App\Request\User\UserPasswordUpdateRequest;
use App\Response\ResetPassword\ResetPasswordOrderGetResponse;
use App\Response\User\UserRegisterResponse;
use App\Service\MalathSMS\MalathSMSService;
use App\Service\User\UserService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class ResetPasswordOrderService
{
    private AutoMapping $autoMapping;
    private ResetPasswordOrderManager $resetPasswordOrderManager;
    private UserService $userService;
    private ParameterBagInterface $params;
    private MalathSMSService $malathSMSService;

    public function __construct(AutoMapping $autoMapping, ResetPasswordOrderManager $resetPasswordOrderManager, UserService $userService, ParameterBagInterface $params,
                                MalathSMSService $malathSMSService)
    {
        $this->autoMapping = $autoMapping;
        $this->resetPasswordOrderManager = $resetPasswordOrderManager;
        $this->userService = $userService;
        $this->params = $params;
        $this->malathSMSService = $malathSMSService;
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
//                $this->sendSMSMessage($resetPasswordOrder->getUser()->getUserId(), $resetPasswordOrder->getCode());

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
                    //TODO code is valid one, update codeStatus to be false while we verified the code

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

    public function sendSMSMessage($phone, $code): string
    {
        $messageText = 'Please use this code to reset your password:'.' '.$code;

        // send SMS message
        $this->malathSMSService->setUserName($this->params->get('malath_username'));
        $this->malathSMSService->setPassword($this->params->get('malath_password'));

        $result = $this->malathSMSService->sendSMS($phone, "MANDOB-AD", $messageText);

        if($result)
        {
            if ($result['RESULT'] == 0)
            {
                // message sent successfully
                return 'sentSuccessfully';
            }
            elseif ($result['RESULT'] == 101)
            {
                // Parameter are missing
                return 'parameterAreMissing';
            }
            elseif ($result['RESULT'] == 104)
            {
                // either user name or password are missing or your Account is on hold
                return 'userNameOrPasswordAreMissingOrYourAccountIsOnHold';
            }
            elseif ($result['RESULT'] == 105)
            {
                // Credit are not available
                return 'creditAreNotAvailable';
            }
        }
    }

    public function updateUserPassword(UserPasswordUpdateRequest $request): UserRegisterResponse|string
    {
        return $this->userService->updateUserPassword($request);
    }
}
