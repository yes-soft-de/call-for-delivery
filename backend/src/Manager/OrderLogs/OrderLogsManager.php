<?php

namespace App\Manager\OrderLogs;

use App\AutoMapping;
use App\Entity\OrderLogsEntity;
use App\Repository\OrderLogsEntityRepository;
use App\Request\OrderLogs\OrderLogsCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class OrderLogsManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private OrderLogsEntityRepository $orderLogsEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, OrderLogsEntityRepository $orderLogsEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->orderLogsEntityRepository = $orderLogsEntityRepository;
    }

    public function createOrderLogs(OrderLogsCreateRequest $request): ?OrderLogsEntity
    {
        $entity = $this->autoMapping->map(OrderLogsCreateRequest::class, OrderLogsEntity::class, $request);
   
        $this->entityManager->persist($entity);

        $this->entityManager->flush();

        return $entity;
    }

    public function getOrderLogsByOrderId($orderId): ?array
    {
      return $this->orderLogsEntityRepository->getOrderLogsByOrderId($orderId);
    }
}
