<?php

namespace App\Service\Admin\DeliveryCar;

use App\AutoMapping;
use App\Entity\DeliveryCarEntity;
use App\Manager\Admin\DeliveryCar\AdminDeliveryCarManager;
use App\Request\Admin\DeliveryCar\DeliveryCarCreateRequest;
use App\Response\Admin\DeliveryCar\DeliveryCarGetForAdminResponse;

class AdminDeliveryCarService
{
    private AutoMapping $autoMapping;
    private AdminDeliveryCarManager $adminDeliveryCarManager;

    public function __construct(AutoMapping $autoMapping, AdminDeliveryCarManager $adminDeliveryCarManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminDeliveryCarManager = $adminDeliveryCarManager;
    }

    public function createDeliveryCarByAdmin(DeliveryCarCreateRequest $request): DeliveryCarGetForAdminResponse
    {
        $deliveryCarEntity = $this->adminDeliveryCarManager->createDeliveryCarByAdmin($request);

        return $this->autoMapping->map(DeliveryCarEntity::class, DeliveryCarGetForAdminResponse::class, $deliveryCarEntity);
    }

    public function getAllDeliveryCarsForAdmin(): array
    {
        $response = [];

        $deliveryCarsEntities = $this->adminDeliveryCarManager->getAllDeliveryCarsForAdmin();

        foreach ($deliveryCarsEntities as $deliveryCarsEntity) {
            $response[] = $this->autoMapping->map(DeliveryCarEntity::class, DeliveryCarGetForAdminResponse::class, $deliveryCarsEntity);
        }

        return $response;
    }
}
