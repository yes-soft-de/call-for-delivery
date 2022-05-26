<?php

namespace App\Request\Admin\DeliveryCar;

class DeliveryCarUpdateRequest
{
    private int $id;

    private string $carModel;

    /**
     * @var string|null
     */
    private $details;

    private float $deliveryCost;

    public function getId(): int
    {
        return $this->id;
    }
}
