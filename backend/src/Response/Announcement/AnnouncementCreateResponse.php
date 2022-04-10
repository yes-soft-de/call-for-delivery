<?php

namespace App\Response\Announcement;

class AnnouncementCreateResponse
{
    /**
     * @var int|null
     */
    public $id;

    /**
     * @var float|null
     */
    public $price;

    /**
     * @var string|null
     */
    public $details;

    /**
     * @var int|null
     */
    public $quantity;

    /**
     * @var object|null
     */
    public $createdAt;
}
