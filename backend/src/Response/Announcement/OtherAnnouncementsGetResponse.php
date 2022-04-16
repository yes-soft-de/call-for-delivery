<?php

namespace App\Response\Announcement;

use DateTime;

class OtherAnnouncementsGetResponse
{
    public int $id;

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
     * @var array|null
     */
    public $images;
}