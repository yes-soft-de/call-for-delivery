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
   private AutoMapping $autoMapping;
   private EntityManagerInterface $entityManager;
   private OrderEntityRepository $orderRepository;
   private StoreOwnerProfileManager $storeOwnerProfileManager;
   private StoreOrderDetailsManager $storeOrderDetailsManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, OrderEntityRepository $orderRepository, StoreOwnerProfileManager $storeOwnerProfileManager, StoreOrderDetailsManager $storeOrderDetailsManager)
    {
      $this->autoMapping = $autoMapping;
      $this->entityManager = $entityManager;
      $this->orderRepository = $orderRepository;
      $this->storeOwnerProfileManager = $storeOwnerProfileManager;
      $this->storeOrderDetailsManager = $storeOrderDetailsManager;

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

    /**
     * @param $userId
     * @return array|null
     */
    public function getStoreOrders(int $userId): ?array
    {      
       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($userId);
       
       return  $this->orderRepository->getStoreOrders($storeOwner->getId());     
    }

    /**
     * @param $id
     * @return array|null
     */
    public function getSpecificOrderForStore(int $id): ?array
    {      
       return  $this->orderRepository->getSpecificOrderForStore($id);     
    }
}
