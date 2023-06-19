<?php

namespace App\Response\Account;

class CompleteAccountStatusGetResponse
{
    public ?string $completeAccountStatus;

    /**
     * user status (activated | maintenance mood | etc)
     */
    public ?string $status;

    // can store create subscription with opening package without payment, or not
    public bool $openingSubscriptionWithoutPayment = false;
}
