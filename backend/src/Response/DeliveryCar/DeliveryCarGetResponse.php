<?php

namespace App\Response\DeliveryCar;

use DateTime;

class DeliveryCarGetResponse
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
