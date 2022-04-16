<?php

namespace App\Manager\Order;

use App\AutoMapping;
use App\Constant\Order\OrderResultConstant;
use App\Entity\OrderEntity;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Manager\AnnouncementOrderDetails\AnnouncementOrderDetailsManager;
use App\Repository\OrderEntityRepository;
use App\Request\Main\OrderStateUpdateBySuperAdminRequest;
use App\Request\Order\AnnouncementOrderCreateRequest;
use App\Request\Order\AnnouncementOrderFilterBySupplierRequest;
use App\Request\Order\OrderFilterByCaptainRequest;
use App\Request\Order\OrderFilterRequest;
use App\Request\Order\OrderCreateRequest;
use App\Request\Order\OrderUpdateByCaptainRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Manager\Captain\CaptainManager;
use DateTime;
use App\Request\Order\OrderUpdateCaptainOrderCostRequest;
use App\Request\Order\OrderUpdateCaptainArrivedRequest;

class OrderManager
{
   private AutoMapping $autoMapping;
   private EntityManagerInterface $entityManager;
   private OrderEntityRepository $orderRepository;
   private StoreOwnerProfileManager $storeOwnerProfileManager;
   private StoreOrderDetailsManager $storeOrderDetailsManager;
   private CaptainManager $captainManager;
   private AnnouncementOrderDetailsManager $announcementOrderDetailsManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, OrderEntityRepository $orderRepository, StoreOwnerProfileManager $storeOwnerProfileManager,
                                StoreOrderDetailsManager $storeOrderDetailsManager, CaptainManager $captainManager, AnnouncementOrderDetailsManager $announcementOrderDetailsManager)
    {
      $this->autoMapping = $autoMapping;
      $this->entityManager = $entityManager;
      $this->orderRepository = $orderRepository;
      $this->storeOwnerProfileManager = $storeOwnerProfileManager;
      $this->storeOrderDetailsManager = $storeOrderDetailsManager;
      $this->captainManager = $captainManager;
      $this->announcementOrderDetailsManager = $announcementOrderDetailsManager;
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

    public function createAnnouncementOrder(AnnouncementOrderCreateRequest $request): OrderEntity
    {
        $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($request->getStoreOwner());
        $request->setStoreOwner($storeOwner);

        $orderEntity = $this->autoMapping->map(AnnouncementOrderCreateRequest::class, OrderEntity::class, $request);

        $orderEntity->setCreatedAt(new DateTime());
        $orderEntity->setDeliveryDate($orderEntity->getDeliveryDate());
        $orderEntity->setState(OrderStateConstant::ORDER_STATE_PENDING);
        $orderEntity->setOrderType(OrderTypeConstant::ORDER_TYPE_ADV);

        $this->entityManager->persist($orderEntity);
        $this->entityManager->flush();

        $this->announcementOrderDetailsManager->createAnnouncementOrderDetails($request, $orderEntity);

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

    public function filterStoreOrders(OrderFilterRequest $request, int $userId): ?array
    {
        $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($userId);

        return $this->orderRepository->filterStoreOrders($request, $storeOwner);
    }

    public function updateOrderStateBySuperAdmin(OrderStateUpdateBySuperAdminRequest $request): string|OrderEntity
    {
        $orderEntity = $this->orderRepository->find($request->getId());

        if(! $orderEntity) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;

        } else {
            $orderEntity = $this->autoMapping->mapToObject(OrderStateUpdateBySuperAdminRequest::class, OrderEntity::class, $request, $orderEntity);

            $this->entityManager->flush();

            return $orderEntity;
        }
    }

    public function closestOrders(int $userId): ?array
    {
        $captainId = $this->captainManager->getCaptainProfileByUserId($userId);

        return $this->orderRepository->closestOrders($captainId->getId());
    }
    
    public function acceptedOrderByCaptainId($userId): ?array
    {
        $captainId = $this->captainManager->getCaptainProfileByUserId($userId);

        return $this->orderRepository->acceptedOrderByCaptainId($captainId->getId(), $userId);
    }
    
    public function getSpecificOrderForCaptain(int $id, int $userId): ?array
    {
        $captainId = $this->captainManager->getCaptainProfileByUserId($userId);

        return $this->orderRepository->getSpecificOrderForCaptain($id, $captainId->getId(), $userId);
    }

    public function  orderUpdateStateByCaptain(OrderUpdateByCaptainRequest $request): ?OrderEntity
    {
        $orderEntity = $this->orderRepository->find($request->getId());

        if(! $orderEntity) {
            return $orderEntity;
        }
        
        $captainId = $this->captainManager->getCaptainProfileByUserId($request->getCaptainId());
       
        $request->setCaptainId($captainId);

        if(! $request->getCaptainOrderCost()) {
            $request->setCaptainOrderCost($orderEntity->getCaptainOrderCost());
        }

        if(! $request->getNoteCaptainOrderCost()) {
            $request->setNoteCaptainOrderCost($orderEntity->getNoteCaptainOrderCost());
        }
        
        $orderEntity = $this->autoMapping->mapToObject(OrderUpdateByCaptainRequest::class, OrderEntity::class, $request, $orderEntity);

        $this->entityManager->flush();
     
        return $orderEntity;
    }

    public function getOrderById($id): ?OrderEntity
    {
        return $this->orderRepository->find($id);
    }

    public function filterOrdersByCaptain(OrderFilterByCaptainRequest $request): ?array
    {
        $captainProfile = $this->captainManager->getCaptainProfileByUserId($request->getCaptainId());

        if (! $captainProfile) {
            $request->setCaptainId(0);

        } else {
            $request->setCaptainId($captainProfile->getId());
        }

        return $this->orderRepository->filterOrdersByCaptain($request);
    }
    
    public function orderUpdateCaptainOrderCost(OrderUpdateCaptainOrderCostRequest $request): ?OrderEntity
    {
        $orderEntity = $this->orderRepository->find($request->getId());

        if(! $orderEntity) {
            return $orderEntity;
        }
               
        $request->setCaptainId($orderEntity->getCaptainId());
       
        $orderEntity = $this->autoMapping->mapToObject(OrderUpdateCaptainOrderCostRequest::class, OrderEntity::class, $request, $orderEntity);

        $this->entityManager->flush();

        return $orderEntity;
    }
    
    public function updateCaptainArrived(OrderUpdateCaptainArrivedRequest $request): ?OrderEntity
    {
        $orderEntity = $this->orderRepository->find($request->getId());

        if(! $orderEntity) {
            return $orderEntity;
        }
               
        $orderEntity = $this->autoMapping->mapToObject(OrderUpdateCaptainArrivedRequest::class, OrderEntity::class, $request, $orderEntity);
        
        $orderEntity->setDateCaptainArrived(new DateTime());
        
        $this->entityManager->flush();

        return $orderEntity;
    }
    
    public function orderCancel(OrderEntity $orderEntity): ?OrderEntity
    {        
        $orderEntity->setState(OrderStateConstant::ORDER_STATE_CANCEL);
        
        $this->entityManager->flush();

        return $orderEntity;
    }
    
    public function getCountOrdersByCaptainId(int $captainId): array
    {
        return $this->orderRepository->getCountOrdersByCaptainId($captainId);
    }    
    
    public function getDetailOrdersByCaptainId(int $captainId): array
    {
        return $this->orderRepository->getDetailOrdersByCaptainId($captainId);
    }    
    
    public function getCountOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderRepository->getCountOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }    

    public function filterAnnouncementOrdersBySupplier(AnnouncementOrderFilterBySupplierRequest $request): ?array
    {
        return $this->orderRepository->filterAnnouncementOrdersBySupplier($request);
    }
}
