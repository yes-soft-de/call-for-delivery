<?php

namespace App\Service\DeliveryCar;

use App\AutoMapping;
use App\Entity\DeliveryCarEntity;
use App\Manager\DeliveryCar\DeliveryCarManager;
use App\Response\DeliveryCar\DeliveryCarGetResponse;

class DeliveryCarService
{
    private AutoMapping $autoMapping;
    private DeliveryCarManager $deliveryCarManager;

    public function __construct(AutoMapping $autoMapping, DeliveryCarManager $deliveryCarManager)
    {
        $this->autoMapping = $autoMapping;
        $this->deliveryCarManager = $deliveryCarManager;
    }

    public function getAllDeliveryCarsForSupplier(): array
    {
        $response = [];

        $deliveryCarsEntities = $this->deliveryCarManager->getAllDeliveryCarsForSupplier();

        foreach ($deliveryCarsEntities as $deliveryCarsEntity) {
            $response[] = $this->autoMapping->map(DeliveryCarEntity::class, DeliveryCarGetResponse::class, $deliveryCarsEntity);
        }

        return $response;
    }
}
