<?php

namespace App\Response\Order;

use DateTime;

class BidOrderFilterBySupplierResponse
{
    public int $id;

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

    public DateTime $updatedAt;

    /**
     * @var bool|null
     */
    public $openToPriceOffer;
}
