<?php

namespace App\Manager\OrderLog;

use App\AutoMapping;
use App\Entity\OrderLogEntity;
use App\Request\OrderLog\OrderLogCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class OrderLogManager
{
    private EntityManagerInterface $entityManager;
    private AutoMapping $autoMapping;

    public function __construct(EntityManagerInterface $entityManager, AutoMapping $autoMapping)
    {
        $this->entityManager = $entityManager;
        $this->autoMapping = $autoMapping;
    }

    public function createNewOrderLog(OrderLogCreateRequest $request): OrderLogEntity
    {
        $orderLogEntity = $this->autoMapping->map(OrderLogCreateRequest::class, OrderLogEntity::class, $request);

        $this->entityManager->persist($orderLogEntity);
        $this->entityManager->flush();

        return $orderLogEntity;
    }
}
