<?php

namespace App\Response\OrderTimeLine;

use DateTime;

class OrderTimelineCaptainProfileUpdateResponse
{
    public int $id;

    public DateTime $createdAt;

    public string $orderState;

    /**
     * @var bool|null
     */
    public $isCaptainArrived;

    /**
     * @var int|null
     */
    public $visibleTo;

    /**
     * @var bool|null
     */
    public $isVisible;

    /**
     * @var int|null
     */
    public $paidToProvider;
}
