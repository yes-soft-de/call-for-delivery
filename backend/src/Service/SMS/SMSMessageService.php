<?php

namespace App\Service\SMS;

use App\Constant\MalathSMS\MessageUsedAsConstant;
use App\Constant\Msegat\MsegatSendingResultConstant;
use App\Constant\SMS\SMSMessageSendResultConstant;
use App\Service\Msegat\MsegatService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class SMSMessageService
{
    public function __construct(
        private ParameterBagInterface $params,
        private MsegatService $msegatService
    )
    {
    }

    public function sendSMSMessageViaMsegat(string $phone, string $messageText): array
    {
        return $this->msegatService->sendSMSMessage($phone, $messageText);
    }

    public function sendSMSMessage(string $phone, string $code, string $usedAsMessage): int
    {
        if ($usedAsMessage === MessageUsedAsConstant::USER_VERIFICATION_MESSAGE) {
            $messageText = MessageUsedAsConstant::USER_VERIFICATION_TEXT_MESSAGE.$code;

        } elseif ($usedAsMessage === MessageUsedAsConstant::RESET_PASSWORD_MESSAGE) {
            $messageText = MessageUsedAsConstant::RESET_PASSWORD_TEXT_MESSAGE.$code;
        }

        // send SMS message
        // --- MALATH --- //
        //$this->malathSMSService->setUserName($this->params->get('malath_username'));
        //$this->malathSMSService->setPassword($this->params->get('malath_password'));

        //$result = $this->malathSMSService->sendSMS($phone, MalathURLConstant::SENDER_NAME_CONST, $messageText);
        // --- End of MALATH --- //

        // --- MSEGAT --- //
        $result = $this->sendSMSMessageViaMsegat($phone, $messageText);
        // --- End of MSEGAT --- //

        if ($result) {
            if (is_array($result)) {
                if ($result['code'] === MsegatSendingResultConstant::SUCCESS_CODE_CONST) {
                    // message sent successfully
                    return MsegatSendingResultConstant::SUCCESS_RESULT_CONST;

                } elseif ($result['code'] === MsegatSendingResultConstant::VARIABLES_MISSING_CODE_CONST
                    || $result['code'] === MsegatSendingResultConstant::VARIABLES_MISSING_SECOND_CODE_CONST) {
                    // Parameter/s are missing
                    return MsegatSendingResultConstant::VARIABLES_MISSING_RESULT_CONST;

                } elseif ($result['code'] === MsegatSendingResultConstant::VARIABLES_MISSING_CODE_CONST
                    || $result['code'] === MsegatSendingResultConstant::VARIABLES_MISSING_SECOND_CODE_CONST) {
                    // Parameter/s are missing
                    return MsegatSendingResultConstant::VARIABLES_MISSING_RESULT_CONST;

                }
            }
        }

        return SMSMessageSendResultConstant::NO_RESULT_WAS_EXIST_CONST;
    }
}
