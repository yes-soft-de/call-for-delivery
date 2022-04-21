<?php

namespace App\Request\Admin\DeliveryCar;

class DeliveryCarCreateRequest
{
    private string $carModel;

    /**
     * @var string|null
     */
    private $details;

    private float $deliveryCost;
}
