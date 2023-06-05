<?php

namespace App\Service\OrderSendService;

/**
 * Responsible for handling the process of sending order to an external party (company)
 */
class OrderSendingHandlingService
{
    public function __construct()
    {
    }

    /**
     * Checks if the order being passed meets the setting or not
     */
    public function checkIfOrderMatchTheSetting()
    {

    }

    /**
     * Actually, this ...
     */
    public function sendOrder()
    {

    }

    /**
     * Main function
     * Responsible for handling the process of sending order to an external party
     */
    public function handleOrderSending()
    {
        // 1 check if sending order feature is On.
        // 2 check which company is available in order to send order to.
        // 3 check sending order setting which set by admin
        // 4 check if order meet the setting options
        // 5 send the order if 4 is true
        // 6 As 5 done successfully, then create a record of the sent order in the ...
    }
}
