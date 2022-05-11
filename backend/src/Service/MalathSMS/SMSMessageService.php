<?php

namespace App\Service\MalathSMS;

use App\Constant\MalathSMS\MalathSendMessageResultConstant;
use App\Constant\MalathSMS\MessageUsedAsConstant;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class SMSMessageService
{
    private MalathSMSService $malathSMSService;
    private ParameterBagInterface $params;

    public function __construct(MalathSMSService $malathSMSService, ParameterBagInterface $params)
    {
        $this->malathSMSService = $malathSMSService;
        $this->params = $params;
    }

    public function sendSMSMessage(string $phone, string $code, string $usedAsMessage): string
    {
        if ($usedAsMessage === MessageUsedAsConstant::USER_VERIFICATION_MESSAGE) {
            $messageText = MessageUsedAsConstant::USER_VERIFICATION_TEXT_MESSAGE.$code;

        } elseif ($usedAsMessage === MessageUsedAsConstant::RESET_PASSWORD_MESSAGE) {
            $messageText = MessageUsedAsConstant::RESET_PASSWORD_TEXT_MESSAGE.$code;
        }

        // send SMS message
        $this->malathSMSService->setUserName($this->params->get('malath_username'));
        $this->malathSMSService->setPassword($this->params->get('malath_password'));

        $result = $this->malathSMSService->sendSMS($phone, "MANDOB-AD", $messageText);

        if($result)
        {
            if ($result['RESULT'] == 0)
            {
                // message sent successfully
                return MalathSendMessageResultConstant::MESSAGE_SENT_SUCCESSFULLY;
            }
            elseif ($result['RESULT'] == 101)
            {
                // Parameter are missing
                return MalathSendMessageResultConstant::PARAMETER_ARE_MISSING;
            }
            elseif ($result['RESULT'] == 104)
            {
                // either user name or password are missing or your Account is on hold
                return MalathSendMessageResultConstant::USER_NAME_OR_PASSWORD_ARE_MISSING_OR_YOUR_ACCOUNT_IS_ON_HOLD;
            }
            elseif ($result['RESULT'] == 105)
            {
                // Credit are not available
                return MalathSendMessageResultConstant::CREDIT_ARE_NOT_AVAILABLE;
            }
        }
    }
}
