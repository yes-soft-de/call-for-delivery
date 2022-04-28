<?php

namespace App\Manager\DeliveryCar;

use App\Entity\DeliveryCarEntity;
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

    public function getDeliveryCarEntityById(int $id): ?DeliveryCarEntity
    {
        return $this->deliveryCarEntityRepository->find($id);
    }
}
