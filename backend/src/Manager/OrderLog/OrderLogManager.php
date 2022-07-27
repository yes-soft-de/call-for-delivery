<?php

namespace App\Manager\OrderLog;

use App\AutoMapping;
use App\Entity\OrderLogEntity;
use App\Repository\OrderLogEntityRepository;
use App\Request\OrderLog\OrderLogCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class OrderLogManager
{
    private EntityManagerInterface $entityManager;
    private AutoMapping $autoMapping;
    private OrderLogEntityRepository $orderLogEntityRepository;

    public function __construct(EntityManagerInterface $entityManager, AutoMapping $autoMapping, OrderLogEntityRepository $orderLogEntityRepository)
    {
        $this->entityManager = $entityManager;
        $this->autoMapping = $autoMapping;
        $this->orderLogEntityRepository = $orderLogEntityRepository;
    }

    public function createNewOrderLog(OrderLogCreateRequest $request): OrderLogEntity
    {
        $orderLogEntity = $this->autoMapping->map(OrderLogCreateRequest::class, OrderLogEntity::class, $request);

        $this->entityManager->persist($orderLogEntity);
        $this->entityManager->flush();

        return $orderLogEntity;
    }

    public function getOrderLogsByOrderIdForAdmin(int $orderId): array
    {
        return $this->orderLogEntityRepository->getOrderLogsByOrderIdForAdmin($orderId);
    }
}
