<?php

namespace App\Response\Account;

class CompleteAccountStatusGetResponse
{
    /**
     * @var string|null
     */
    public $completeAccountStatus;

    /**
     * user status (activated | maintenance mood | etc)
     * @var string|null
     */
    public $status;
}
