<?php

namespace App\Response\BidOrder;

use DateTime;

class BidOrderFilterBySupplierResponse
{
    public int $id;

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
