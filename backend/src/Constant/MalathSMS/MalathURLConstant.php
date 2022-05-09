<?php

namespace App\Constant\MalathSMS;

final class MalathURLConstant
{
    // Main URL for Server
    const URL_GATEWAY = "http://sms.malath.net.sa";

    // Url 4 Send SMS
    const URL_GATEWAY_SEND = "/httpSmsProvider.aspx";

    // Url 4 Get Balance
    const URL_GATEWAY_CREDIT = "/api/getBalance.aspx";

    // Url 4 Get & ADD Sender Names
    const URL_GATEWAY_SENDER = "/apis/users.aspx";
}
