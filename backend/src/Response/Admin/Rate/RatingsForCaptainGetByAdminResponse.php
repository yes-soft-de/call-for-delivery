<?php

namespace App\Response\Admin\Rate;

class RatingsForCaptainGetByAdminResponse
{
    public int $id;

    /**
     * @var string|null
     */
    public $comment;

    public float $rating;

    public string $storeOwnerName;

    public int $orderId;
}
