<?php

namespace App\Response\Order;

use DateTime;

class BidOrderFilterBySupplierResponse
{
    public int $id;

    public string $state;

    public int $bidOrderId;

    /**
     * @var string|null
     */
    public $title;

    /**
     * @var string|null
     */
    public $description;

    public DateTime $createdAt;

    /**
     * @var DateTime|null
     */
    public $updatedAt;

    /**
     * @var bool|null
     */
    public $openToPriceOffer;
}
