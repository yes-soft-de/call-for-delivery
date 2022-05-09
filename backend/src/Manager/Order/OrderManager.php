<?php

namespace App\Manager\Order;

use App\AutoMapping;
use App\Constant\Order\OrderResultConstant;
use App\Entity\OrderEntity;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Entity\OrderLogsEntity;
use App\Manager\BidDetails\BidDetailsManager;
use App\Manager\OrderLogs\OrderLogsManager;
use App\Repository\OrderEntityRepository;
use App\Request\Order\BidOrderFilterBySupplierRequest;
use App\Request\Order\BidDetailsCreateRequest;
use App\Request\Main\OrderStateUpdateBySuperAdminRequest;
use App\Request\Order\OrderFilterByCaptainRequest;
use App\Request\Order\OrderFilterRequest;
use App\Request\Order\OrderCreateRequest;
use App\Request\Order\OrderUpdateByCaptainRequest;
use App\Request\OrderLogs\OrderLogsCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Manager\Captain\CaptainManager;
use DateTime;
use App\Request\Order\OrderUpdateCaptainOrderCostRequest;
use App\Request\Order\OrderUpdateCaptainArrivedRequest;
use App\Request\Order\SubOrderCreateRequest;

class OrderManager
{
   private AutoMapping $autoMapping;
   private EntityManagerInterface $entityManager;
   private OrderEntityRepository $orderRepository;
   private StoreOwnerProfileManager $storeOwnerProfileManager;
   private StoreOrderDetailsManager $storeOrderDetailsManager;
   private CaptainManager $captainManager;
   private BidDetailsManager $bidDetailsManager;
   private OrderLogsManager $orderLogsManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, OrderEntityRepository $orderRepository, StoreOwnerProfileManager $storeOwnerProfileManager,
                                StoreOrderDetailsManager $storeOrderDetailsManager, CaptainManager $captainManager, BidDetailsManager $bidDetailsManager, OrderLogsManager $orderLogsManager)
    {
      $this->autoMapping = $autoMapping;
      $this->entityManager = $entityManager;
      $this->orderRepository = $orderRepository;
      $this->storeOwnerProfileManager = $storeOwnerProfileManager;
      $this->storeOrderDetailsManager = $storeOrderDetailsManager;
      $this->captainManager = $captainManager;
      $this->bidDetailsManager = $bidDetailsManager;
      $this->orderLogsManager = $orderLogsManager;
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

    public function createBidOrder(BidDetailsCreateRequest $request): OrderEntity
    {
        $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($request->getStoreOwner());
        $request->setStoreOwner($storeOwner);

        $orderEntity = $this->autoMapping->map(BidDetailsCreateRequest::class, OrderEntity::class, $request);

        $orderEntity->setCreatedAt(new DateTime());
        $orderEntity->setDeliveryDate($orderEntity->getDeliveryDate());
        $orderEntity->setState(OrderStateConstant::ORDER_STATE_INITIALIZED);
        $orderEntity->setOrderType(OrderTypeConstant::ORDER_TYPE_BID);

        $this->entityManager->persist($orderEntity);
        $this->entityManager->flush();

        $this->bidDetailsManager->createBidDetails($request, $orderEntity);

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

    public function closestBidOrders(int $userId): ?array
    {
        $captainId = $this->captainManager->getCaptainProfileByUserId($userId);

        return $this->orderRepository->closestBidOrders($captainId->getId());
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

    public function getSpecificBidOrderForCaptain(int $id, int $userId): ?array
    {
        $captainId = $this->captainManager->getCaptainProfileByUserId($userId);

        return $this->orderRepository->getSpecificBidOrderForCaptain($id, $captainId->getId(), $userId);
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
    
    public function getDetailOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderRepository->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }    
    
    public function getCountOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderRepository->getCountOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getCountOrdersByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): ?array
    {
        return $this->orderRepository->getCountOrdersByFinancialSystemThree($captainId, $fromDate, $toDate, $countKilometersFrom, $countKilometersTo);
    }

    // This function filter bid orders which the supplier had not provide a price offer for any one of them yet.
    public function filterBidOrdersBySupplier(BidOrderFilterBySupplierRequest $request): array
    {
        return $this->orderRepository->filterBidOrdersBySupplier($request);
    }

    public function getOrderByIdForSupplier(int $orderId): ?array
    {
        return $this->orderRepository->getOrderByIdForSupplier($orderId);
    }

    // This function filter bid orders which have price offers made by the supplier (who request the filter).
    public function filterBidOrdersThatHavePriceOffersBySupplier(BidOrderFilterBySupplierRequest $request): array
    {
        return $this->orderRepository->filterBidOrdersThatHavePriceOffersBySupplier($request);
    }

    public function getLastPriceOfferByBidDetailsId(int $bidDetailsId): array
    {
        return $this->orderRepository->getLastPriceOfferByBidDetailsId($bidDetailsId);
    }

    // this function will be used when a supplier confirm an acceptance of a store owner for specific bid order
    // then, the state of the order will be updated from 'initialized' to 'pending'
    public function updateBidOrderStateToPendingBySupplier(int $orderId, string $deliveryDate): ?OrderEntity
    {
        $orderEntity = $this->orderRepository->find($orderId);

        if (! $orderEntity) {
            return $orderEntity;
        }

        $orderEntity->setState(OrderStateConstant::ORDER_STATE_PENDING);
        $orderEntity->setDeliveryDate($deliveryDate);

        $this->entityManager->flush();

        // insert new order log
        $this->createOrderLog($orderEntity);

        return $orderEntity;
    }

    public function getOrderTypeByOrderId(int $orderId): int
    {
        $orderEntity = $this->orderRepository->find($orderId);

        if ($orderEntity === null) {
            return 0;
        }

        return $orderEntity->getOrderType();
    }

    public function getSpecificBidOrderForStore(int $id): ?array
    {
        return $this->orderRepository->getSpecificBidOrderForStore($id);
    }

    public function createOrderLog(OrderEntity $orderEntity): ?OrderLogsEntity
    {
        $request = new OrderLogsCreateRequest();

        $request->setOrderId($orderEntity);
        $request->setStoreOwnerProfile($orderEntity->getStoreOwner());
        $request->setOrderState($orderEntity->getState());
        $request->setCaptainProfile($orderEntity->getCaptainId());
        $request->setIsCaptainArrived($orderEntity->getIsCaptainArrived());

        $storeOrderDetails = $this->storeOrderDetailsManager->getOrderDetailsByOrderId($orderEntity->getId());

        if ($storeOrderDetails) {
            $branch = $storeOrderDetails->getBranch();

            if($branch) {
                $request->setStoreOwnerBranch($branch);
            }
        }

        return $this->orderLogsManager->createOrderLogs($request);
    }

    public function getOrdersPendingBeforeSpecificDate(DateTime $specificTime): ?array
    {
        return $this->orderRepository->getOrdersPendingBeforeSpecificDate($specificTime);
    }
    
    // this function checks if an order is being accepted by a captain
    public function isOrderAcceptedByCaptain(int $orderId): string|bool
    {
        $orderEntity = $this->orderRepository->find($orderId);

        if ($orderEntity) {
            if ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_PENDING) {
                return false;
            }

            return true;
        }

        return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
    }

    public function orderUpdatePaidToProvider(int $orderId, int $paidToProvider): ?OrderEntity
    {
        $orderEntity = $this->orderRepository->find($orderId);

        if(! $orderEntity) {
            return $orderEntity;
        }
               
        $orderEntity->setPaidToProvider($paidToProvider);
        
        $this->entityManager->flush();

        return $orderEntity;
    }

    public function createSubOrder(SubOrderCreateRequest $request): ?OrderEntity
    {      
       $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($request->getStoreOwner());
       $request->setStoreOwner($storeOwner);
     
       $orderEntity = $this->autoMapping->map(SubOrderCreateRequest::class, OrderEntity::class, $request);

       $orderEntity->setCreatedAt(new DateTime());
       $orderEntity->setDeliveryDate($orderEntity->getDeliveryDate());
       $orderEntity->setState(OrderStateConstant::ORDER_STATE_PENDING);
       $orderEntity->setOrderType(OrderTypeConstant::ORDER_TYPE_NORMAL);

       $this->entityManager->persist($orderEntity);
       $this->entityManager->flush();

       $orderCreateRequest = $this->autoMapping->map(SubOrderCreateRequest::class, OrderCreateRequest::class, $request);

       $this->storeOrderDetailsManager->createOrderDetail($orderEntity, $orderCreateRequest);

       return $orderEntity;
    }
}
