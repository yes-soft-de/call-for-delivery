<?php

namespace App\Response\Admin\StoreOwnerSubscription;

use DateTime;

class StoreFutureSubscriptionGetForAdminResponse
{
    /**
     * @var int|null
     */
    public $id;

    public DateTime $startDate;

    public DateTime $endDate;

    /**
     * @var string|null
     */
    public $status;

    /**
     * @var string|null
     */
    public $note;

    /**
     * @var int|null
     */
    public $flag;
}
