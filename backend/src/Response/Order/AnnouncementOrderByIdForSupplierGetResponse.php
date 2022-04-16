<?php

namespace App\Response\Order;

use DateTime;

class AnnouncementOrderByIdForSupplierGetResponse
{
    public int $id;

    public string $state;

    /**
     * @var string|null
     */
    public $payment;

    /**
     * @var float|null
     */
    public $orderCost;

    public int $orderType;

    /**
     * @var string|null
     */
    public $note;

    public DateTime $deliveryDate;

    public DateTime $createdAt;

    public string $storeOwnerName;

    public string $phone;

    public array|null $orderLogs;

    public int $announcementOrderDetailsId;

    /**
     * @var float|null
     */
    public $priceOfferValue;

    /**
     * @var int|null
     */
    public $priceOfferStatus;

    public int $announcementId;
}
