<?php

namespace App\Response\OrderLog;

use DateTime;

class OrderLogCaptainProfileUpdateResponse
{
    public int $id;

    public int $type;

    public int $action;

    public string $state;

    public DateTime $createdAt;

    public int $createdBy;

    public int $createdByUserType;

    /**
     * @var bool|null
     */
    public $isCaptainArrivedConfirmation;

    /**
     * @var int|null
     */
    public $isHide;

    /**
     * @var bool|null
     */
    public $orderIsMain;

    /**
     * @var int|null
     */
    public $paidToProvider;

    /**
     * @var int|null
     */
    public $isCashPaymentConfirmedByStore;

    public array $details = [];
}
