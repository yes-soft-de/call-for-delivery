<?php

namespace App\Response\DeliveryCar;

class DeliveryCarForStoreOwnerGetResponse
{
    public int $id;

    public string $carModel;

    /**
     * @var string|null
     */
    public $details;

    public float $deliveryCost;
}
