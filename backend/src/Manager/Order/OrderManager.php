<?php

namespace App\Manager\Order;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Repository\OrderEntityRepository;
use App\Request\Order\OrderCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Manager\Order\StoreOrderDetailsManager;
use DateTime;

class OrderManager
{
    public function __construct(private AutoMapping $autoMapping, private EntityManagerInterface $entityManager, private OrderEntityRepository $orderRepository, private StoreOwnerProfileManager $storeOwnerProfileManager, private StoreOrderDetailsManager $storeOrderDetailsManager)
    {
    }
    
    /**
     * @param OrderCreateRequest $request
     * @return OrderEntity|null
     */
    public function createOrder(OrderCreateRequest $request): ?OrderEntity
    {      
       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($request->getStoreOwner());
       $request->setStoreOwner($storeOwner);
     
       $orderEntity = $this->autoMapping->map(OrderCreateRequest::class, OrderEntity::class, $request);

       $orderEntity->setCreatedAt(new DateTime());
       $orderEntity->setDeliveryDate($orderEntity->getDeliveryDate());
       $orderEntity->setState(OrderStateConstant::ORDER_STATE_PENDING);
       $orderEntity->setOrderType(OrderTypeConstant::ORDER_TYPE_NORMAL);

       $this->entityManager->persist($orderEntity);
       $this->entityManager->flush();

       $this->storeOrderDetailsManager->createOrderDetail($orderEntity, $request);

       return $orderEntity;
    }
}
