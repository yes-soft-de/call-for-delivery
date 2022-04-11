<?php

namespace App\Response\Admin\Announcement;

class AnnouncementUpdateByAdminResponse
{
    /**
     * @var int|null
     */
    public $id;

    public $createdAt;

    public $updatedAt;

    public $status;

    public $administrationStatus;

    public $price;

    public $details;

    public $quantity;
}