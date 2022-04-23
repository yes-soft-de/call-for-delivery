<?php

namespace App\Response\Admin\DeliveryCar;

use DateTime;

class DeliveryCarGetForAdminResponse
{
    public int $id;

    public string $carModel;

    /**
     * @var string|null
     */
    public $details;

    public float $deliveryCost;

    public DateTime $createdAt;

    public DateTime $updatedAt;
}
