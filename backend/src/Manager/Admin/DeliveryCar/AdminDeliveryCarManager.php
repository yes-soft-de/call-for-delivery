<?php

namespace App\Manager\Admin\DeliveryCar;

use App\AutoMapping;
use App\Entity\DeliveryCarEntity;
use App\Repository\DeliveryCarEntityRepository;
use App\Request\Admin\DeliveryCar\DeliveryCarCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminDeliveryCarManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private DeliveryCarEntityRepository $deliveryCarEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, DeliveryCarEntityRepository $deliveryCarEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->deliveryCarEntityRepository = $deliveryCarEntityRepository;
    }

    public function createDeliveryCarByAdmin(DeliveryCarCreateRequest $request): DeliveryCarEntity
    {
        $deliveryCarEntity = $this->autoMapping->map(DeliveryCarCreateRequest::class, DeliveryCarEntity::class, $request);

        $this->entityManager->persist($deliveryCarEntity);
        $this->entityManager->flush();

        return $deliveryCarEntity;
    }
}
