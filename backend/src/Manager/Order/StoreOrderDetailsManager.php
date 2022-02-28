<?php

namespace App\Manager\Order;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Entity\StoreOrderDetailsEntity;
use App\Repository\StoreOrderDetailsEntityRepository;
use App\Request\Order\OrderCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\StoreOwnerBranch\StoreOwnerBranchManager;

class StoreOrderDetailsManager
{
    public function __construct(private AutoMapping $autoMapping, private EntityManagerInterface $entityManager, private StoreOrderDetailsEntityRepository $storeOrderDetailsEntityRepository, private StoreOwnerBranchManager $storeOwnerBranchManager)
    {
    }
    
    /**
     * @param OrderCreateRequest $request
     * @param OrderEntity $orderEntity
     * @return StoreOrderDetailsEntity|null
     */
    public function createOrderDetail(OrderEntity $orderEntity, OrderCreateRequest $request): ?StoreOrderDetailsEntity
    {      
       $branch = $this->storeOwnerBranchManager->getBranchById($request->getBranch());
       $request->setBranch($branch);

       $orderDetailEntity = $this->autoMapping->map(OrderCreateRequest::class, StoreOrderDetailsEntity::class, $request);

       $orderDetailEntity->setOrderId($orderEntity);

       $this->entityManager->persist($orderDetailEntity);
       $this->entityManager->flush();

       return  $orderDetailEntity;
    }
}
