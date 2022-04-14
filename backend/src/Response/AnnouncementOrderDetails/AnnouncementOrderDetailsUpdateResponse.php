<?php

namespace App\Response\AnnouncementOrderDetails;

use DateTime;

class AnnouncementOrderDetailsUpdateResponse
{
    public int $id;

//    public $orderId;
//
//    public $announcement;

    public DateTime $createdAt;

    public DateTime $updatedAt;

    /**
     * @var float|null
     */
    public $priceOfferValue;

    /**
     * @var int|null
     */
    public $priceOfferStatus;
}
