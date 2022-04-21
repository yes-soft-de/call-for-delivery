<?php

namespace App\Manager\DeliveryCar;

use App\Repository\DeliveryCarEntityRepository;

class DeliveryCarManager
{
    private DeliveryCarEntityRepository $deliveryCarEntityRepository;

    public function __construct(DeliveryCarEntityRepository $deliveryCarEntityRepository)
    {
        $this->deliveryCarEntityRepository = $deliveryCarEntityRepository;
    }

    public function getAllDeliveryCarsForSupplier(): array
    {
        return $this->deliveryCarEntityRepository->findAll();
    }
}
