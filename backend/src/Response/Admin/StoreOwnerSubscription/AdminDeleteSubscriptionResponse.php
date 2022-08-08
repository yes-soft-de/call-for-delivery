<?php

namespace App\Response\Admin\StoreOwnerSubscription;

use DateTime;

class AdminDeleteSubscriptionResponse
{
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
     * @var bool|null
     */
    public $isFuture;

    /**
     * @var int|null
     */
    public $flag;

    /**
     * @var bool|null
     */
    public $captainOfferFirstTime;

}
