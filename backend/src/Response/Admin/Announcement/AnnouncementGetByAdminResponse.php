<?php

namespace App\Response\Admin\Announcement;

use App\Entity\SupplierProfileEntity;
use DateTime;

class AnnouncementGetByAdminResponse
{
    public int $id;

    public float $price;

    /**
     * @var string|null
     */
    public $details;

    public int $quantity;

    public bool $status;

    public bool $administrationStatus;

    public Datetime $createdAt;

    public Datetime $updatedAt;

    /**
     * @var SupplierProfileEntity|array
     */
    public $supplier;

    /**
     * @var array|null
     */
    public $images;
}