<?php

namespace App\Manager\OrderLogs;

use App\AutoMapping;
use App\Entity\OrderLogsEntity;
use App\Repository\OrderLogsEntityRepository;
use App\Request\Rate\OrderLogsCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class OrderLogsManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, OrderLogsEntityRepository $orderLogsEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->orderLogsEntityRepository = $orderLogsEntityRepository;
    }

    public function create(OrderLogsCreateRequest $request): ?OrderLogsEntity
    {
        $entity = $this->autoMapping->map(OrderLogsCreateRequest::class, OrderLogsEntity::class, $request);
   
        $this->entityManager->persist($entity);

        $this->entityManager->flush();

        return $entity;
    }

    public function createOrderLogs($order, $storeOwner, $captain = null): ?OrderLogsEntity
    {
       $request = new OrderLogsCreateRequest();

       $request->setOrderId($order);
       $request->setStoreOwnerProfile($storeOwner);
       $request->setCaptainProfile($captain);

       return $this->create($request);
    }
}
