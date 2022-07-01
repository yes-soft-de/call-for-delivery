<?php

namespace App\Manager\OrderTimeLine;

use App\AutoMapping;
use App\Entity\OrderTimeLineEntity;
use App\Repository\OrderTimeLineEntityRepository;
use App\Request\OrderTimeLine\OrderLogsCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class OrderTimeLineManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private OrderTimeLineEntityRepository $orderTimeLineEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, OrderTimeLineEntityRepository $orderTimeLineEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->orderTimeLineEntityRepository = $orderTimeLineEntityRepository;
    }

    public function createOrderLogs(OrderLogsCreateRequest $request): ?OrderTimeLineEntity
    {
        $entity = $this->autoMapping->map(OrderLogsCreateRequest::class, OrderTimeLineEntity::class, $request);
   
        $this->entityManager->persist($entity);

        $this->entityManager->flush();

        return $entity;
    }

    public function getOrderTimeLineByOrderId(int $orderId): ?array
    {
      return $this->orderTimeLineEntityRepository->getOrderTimeLineByOrderId($orderId);
    }
    
    public function getCurrentStage(int $orderId): ?array
    {
      return $this->orderTimeLineEntityRepository->getCurrentStage($orderId);
    }
}
