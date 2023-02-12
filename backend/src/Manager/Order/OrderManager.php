<?php

namespace App\Manager\Order;

use App\AutoMapping;
use App\Constant\Order\OrderHasPayConflictAnswersConstant;
use App\Constant\Order\OrderResultConstant;
use App\Entity\OrderEntity;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Entity\OrderTimeLineEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Manager\BidDetails\BidDetailsManager;
use App\Manager\OrderTimeLine\OrderTimeLineManager;
use App\Repository\OrderEntityRepository;
use App\Request\Order\BidOrderFilterBySupplierRequest;
use App\Request\Order\BidDetailsCreateRequest;
use App\Request\Main\OrderStateUpdateBySuperAdminRequest;
use App\Request\Order\CashOrdersPaidOrNotFilterByStoreRequest;
use App\Request\Order\OrderDeliveryCostUpdateRequest;
use App\Request\Order\OrderFilterByCaptainRequest;
use App\Request\Order\OrderFilterRequest;
use App\Request\Order\OrderCreateRequest;
use App\Request\Order\OrderStoreBranchToClientDistanceUpdateRequest;
use App\Request\Order\OrderUpdateByCaptainRequest;
use App\Request\OrderTimeLine\OrderLogsCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Manager\Captain\CaptainManager;
use DateTime;
use App\Request\Order\OrderUpdateCaptainOrderCostRequest;
use App\Request\Order\OrderUpdateCaptainArrivedRequest;
use App\Request\Order\SubOrderCreateRequest;
use App\Constant\Order\OrderIsHideConstant;
use App\Request\Order\RecyclingOrCancelOrderRequest;
use App\Request\Order\UpdateOrderRequest;
use App\Request\Order\OrderUpdateIsCashPaymentConfirmedByStoreRequest;

class OrderManager
{
   private AutoMapping $autoMapping;
   private EntityManagerInterface $entityManager;
   private OrderEntityRepository $orderRepository;
   private StoreOwnerProfileManager $storeOwnerProfileManager;
   private StoreOrderDetailsManager $storeOrderDetailsManager;
   private CaptainManager $captainManager;
   private BidDetailsManager $bidDetailsManager;
   private OrderTimeLineManager $orderTimeLineManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, OrderEntityRepository $orderRepository, StoreOwnerProfileManager $storeOwnerProfileManager,
                                StoreOrderDetailsManager $storeOrderDetailsManager, CaptainManager $captainManager, BidDetailsManager $bidDetailsManager, OrderTimeLineManager $orderTimeLineManager)
    {
      $this->autoMapping = $autoMapping;
      $this->entityManager = $entityManager;
      $this->orderRepository = $orderRepository;
      $this->storeOwnerProfileManager = $storeOwnerProfileManager;
      $this->storeOrderDetailsManager = $storeOrderDetailsManager;
      $this->captainManager = $captainManager;
      $this->bidDetailsManager = $bidDetailsManager;
      $this->orderTimeLineManager = $orderTimeLineManager;
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

       $orderEntity->setDeliveryDate($orderEntity->getDeliveryDate());
       $orderEntity->setState(OrderStateConstant::ORDER_STATE_PENDING);
       $orderEntity->setOrderType(OrderTypeConstant::ORDER_TYPE_NORMAL);
    //    $orderEntity->setIsHide(OrderIsHideConstant::ORDER_SHOW);
        $orderEntity->setPreviousVisibility($request->getIsHide());

       $this->entityManager->persist($orderEntity);
       $this->entityManager->flush();

       $this->storeOrderDetailsManager->createOrderDetail($orderEntity, $request);

       return $orderEntity;
    }

    public function createBidOrder(BidDetailsCreateRequest $request): array
    {
        $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($request->getStoreOwner());
        $request->setStoreOwner($storeOwner);

        $orderEntity = $this->autoMapping->map(BidDetailsCreateRequest::class, OrderEntity::class, $request);

        $orderEntity->setDeliveryDate($orderEntity->getDeliveryDate());
        $orderEntity->setState(OrderStateConstant::ORDER_STATE_INITIALIZED);
        $orderEntity->setOrderType(OrderTypeConstant::ORDER_TYPE_BID);
        $orderEntity->setIsHide(OrderIsHideConstant::ORDER_SHOW);
        $orderEntity->setPreviousVisibility($orderEntity->getIsHide());
        $orderEntity->setOrderIsMain(true);

        $this->entityManager->persist($orderEntity);
        $this->entityManager->flush();

        $bidDetailsEntity = $this->bidDetailsManager->createBidDetails($request, $orderEntity);

        return [$orderEntity, $bidDetailsEntity];
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

    public function getSpecificOrderForStore(int $id): ?array
    {      
       return  $this->orderRepository->getSpecificOrderForStore($id); 
    }

    public function filterStoreOrders(OrderFilterRequest $request, int $userId): ?array
    {
        $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($userId);

        return $this->orderRepository->filterStoreOrders($request, $storeOwner);
    }

    public function filterStoreBidOrders(OrderFilterRequest $request, int $userId): ?array
    {
        $storeOwner = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreOwnerId($userId);

        return $this->orderRepository->filterStoreBidOrders($request, $storeOwner);
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

    public function closestOrders(int $userId, DateTime $date): ?array
    {
        $captainId = $this->captainManager->getCaptainProfileByUserId($userId);

        return $this->orderRepository->closestOrders($captainId->getId(), $date);
    }

    // Currently we do not need this function
//    public function closestBidOrders(int $userId): ?array
//    {
//        $captainId = $this->captainManager->getCaptainProfileByUserId($userId);
//
//        return $this->orderRepository->closestBidOrders($captainId->getId());
//    }
    
    public function acceptedOrderByCaptainId($userId): ?array
    {
        $captainId = $this->captainManager->getCaptainProfileByUserId($userId);

        return $this->orderRepository->acceptedOrderNewByCaptainId($captainId->getId(), $userId);
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
        
        if($orderEntity->getState() === OrderStateConstant::ORDER_STATE_CANCEL) {
            return $orderEntity;
        }

        if($orderEntity->getIsHide() === OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE) {
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

    public function getOrdersByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): ?array
    {
        return $this->orderRepository->getOrdersByFinancialSystemThree($captainId, $fromDate, $toDate, $countKilometersFrom, $countKilometersTo);
    }

    // This function filter bid orders which the supplier had not provide a price offer for any one of them yet.
    public function filterBidOrdersBySupplier(BidOrderFilterBySupplierRequest $request): array|string
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

    public function getOrderTypeByOrderId(int $orderId): OrderEntity|int
    {
        $orderEntity = $this->orderRepository->find($orderId);

        if ($orderEntity === null) {
            return 0;
        }

        return $orderEntity;
    }

    public function getSpecificBidOrderForStore(int $id): ?array
    {
        return $this->orderRepository->getSpecificBidOrderForStore($id);
    }

    public function createOrderLog(OrderEntity $orderEntity): ?OrderTimeLineEntity
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

        return $this->orderTimeLineManager->createOrderLogs($request);
    }

    /// This function had been commented out because it isn't being used anywhere
    //public function getOrdersPendingBeforeSpecificDate(DateTime $specificTime): ?array
    //{
     //   return $this->orderRepository->getOrdersPendingBeforeSpecificDate($specificTime);
    //}

    public function getOrdersPending(): ?array
    {
        return $this->orderRepository->getOrdersPending();
    }
    
    // this function checks if an order is being accepted by a captain
    public function isOrderAcceptedByCaptain(int $orderId): string|bool
    {
        $orderEntity = $this->orderRepository->find($orderId);

        if ($orderEntity) {
            if ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_PENDING || $orderEntity->getState() === OrderStateConstant::ORDER_STATE_CANCEL) {
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

       $orderEntity->setDeliveryDate($orderEntity->getDeliveryDate());
       $orderEntity->setState(OrderStateConstant::ORDER_STATE_PENDING);
       $orderEntity->setOrderType(OrderTypeConstant::ORDER_TYPE_NORMAL);
       $orderEntity->setIsHide(OrderIsHideConstant::ORDER_HIDE);
        $orderEntity->setPreviousVisibility($orderEntity->getIsHide());

       $this->entityManager->persist($orderEntity);
       $this->entityManager->flush();

       $orderCreateRequest = $this->autoMapping->map(SubOrderCreateRequest::class, OrderCreateRequest::class, $request);

       $this->storeOrderDetailsManager->createOrderDetail($orderEntity, $orderCreateRequest);

       return $orderEntity;
    }
    
    public function getSubOrdersByPrimaryOrderId(int $primaryOrderId): ?array
    {
        return $this->orderRepository->getSubOrdersByPrimaryOrderId($primaryOrderId);
    }

    public function updateIsHideByOrderId(int $orderId, int $isHide): ?OrderEntity
    {
        $orderEntity = $this->orderRepository->find($orderId);

        if(! $orderEntity) {
            return $orderEntity;
        }
               
        $orderEntity->setIsHide($isHide);
        $orderEntity->setPrimaryOrder(null);
        $orderEntity->setCaptainId(null);

        $this->entityManager->flush();

        return $orderEntity;
    }

    // This function update isHide for all orders to 2 (Show order value)
//    public function isHideShow()
//    {
//        $orders = $this->orderRepository->findAll();
//        foreach($orders as  $order) {
//            $order->setIsHide(OrderIsHideConstant::ORDER_SHOW);
//        }
//
//        $this->entityManager->flush();
//
//        return $order;
//    }
    
    public function getOrderTemporarilyHidden(): array
    {
        return $this->orderRepository->findBy(['isHide' => OrderIsHideConstant::ORDER_HIDE_TEMPORARILY]);
    }
    
    public function updateIsHide(OrderEntity $orderEntity, int $isHide): ?OrderEntity
    {               
        $orderEntity->setIsHide($isHide);
        
        $this->entityManager->flush();

        return $orderEntity;
    }
 
    public function getOrderByOrderIdAndState(int $orderId, int $isHide): ?OrderEntity
    {        
        return $this->orderRepository->findOneBy(["id" => $orderId, "isHide" => $isHide]);
    }
    
    public function recyclingOrder(OrderEntity $orderEntity, RecyclingOrCancelOrderRequest $request): string|OrderEntity
    {
        $orderEntity = $this->autoMapping->mapToObject(RecyclingOrCancelOrderRequest::class, OrderEntity::class, $request, $orderEntity);

        // $orderEntity->setIsHide(OrderIsHideConstant::ORDER_SHOW);
        $orderEntity->setDeliveryDate($orderEntity->getDeliveryDate());
        $orderEntity->setState(OrderStateConstant::ORDER_STATE_PENDING);

        $this->entityManager->flush();

        $this->storeOrderDetailsManager->updateOrderDetail($orderEntity, $request);

        return $orderEntity;
    }
  
    public function orderNonSubByStore(int $orderId, int $isHide): OrderEntity|string
    {
        $orderEntity = $this->orderRepository->findOneBy(['id' => $orderId, 'state' => OrderStateConstant::ORDER_STATE_PENDING]);

        if(! $orderEntity) {
            return OrderResultConstant::ORDER_CAPTAIN_RECEIVED;
        }
               
        $orderEntity->setIsHide($isHide);
        $orderEntity->setPrimaryOrder(null);
        $orderEntity->setCaptainId(null);

        $this->entityManager->flush();

        return $orderEntity;
    }
    
    public function getSubOrdersByPrimaryOrderIdForStore(int $primaryOrderId): ?array
    {
        return $this->orderRepository->getSubOrdersByPrimaryOrderIdForStore($primaryOrderId);
    }

    public function getordersHiddenDueToExceedingDeliveryTime(int $userId): ?array
    {
       return $this->orderRepository->getordersHiddenDueToExceedingDeliveryTime($userId);
    }

    public function cancelBidOrder(int $orderId): string|OrderEntity|null
    {
        $orderEntity = $this->orderRepository->find($orderId);

        if ($orderEntity) {
            if ($orderEntity->getOrderType() !== OrderTypeConstant::ORDER_TYPE_BID) {
                return OrderResultConstant::ORDER_TYPE_IS_NOT_BID;
            }

            if ($orderEntity->getState() !== OrderStateConstant::ORDER_STATE_INITIALIZED) {
                // Can not delete the bid order because a confirmation on a price offer is made
                return OrderResultConstant::ORDER_NOT_REMOVE_STATE;
            }

            // Otherwise, we can safely delete the bid order
            $orderEntity->setState(OrderStateConstant::ORDER_STATE_CANCEL);

            $this->entityManager->flush();

            // Finally, set the order to be closed for further price offers
            $this->bidDetailsManager->updateBidDetailsToBeClosedForPriceOffer($orderEntity->getBidDetailsEntity()->getId());
        }

        return  $orderEntity;
    }
   
    public function getOrdersByCaptainId(int $captainId): array
    {
        return $this->orderRepository->getOrdersByCaptainId($captainId);
    }

    public function getOrderByIdWithStoreOrderDetail(int $captainId): array
    {
        return $this->orderRepository->getOrderByIdWithStoreOrderDetail($captainId);
    }

    public function orderUpdate(UpdateOrderRequest $request): OrderEntity
    {
        $orderEntity = $this->orderRepository->find($request->getId());

        if ($orderEntity) {
            //$orderEntity->setIsHide(OrderIsHideConstant::ORDER_SHOW);

            if (! $request->getDeliveryCost()) {
                $request->setDeliveryCost($orderEntity->getDeliveryCost());
            }

            $orderEntity = $this->autoMapping->mapToObject(UpdateOrderRequest::class, OrderEntity::class, $request, $orderEntity);

            // update order visibility to match last state in which it was before hiding the order
            $orderEntity->setIsHide($orderEntity->getPreviousVisibility());

            $orderEntity->setDeliveryDate($request->getDeliveryDate());

            $this->entityManager->flush();

            $this->storeOrderDetailsManager->updateOrderDetailByStore($orderEntity, $request);
        }
        
        return $orderEntity;
    }

    public function updateOrderToHiddenForStore(int $id): OrderEntity|string
    {
        $orderEntity = $this->orderRepository->find($id);

        if(! $orderEntity) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        // save current visibility
        $orderEntity->setPreviousVisibility($orderEntity->getIsHide());
        // update visibility
        $orderEntity->setIsHide(OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE);

        $this->entityManager->flush();

        return $orderEntity;
    }

    public function getOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderRepository->getOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function checkWhetherCaptainReceivedOrderForSpecificStore(int $captainId, int $storeId): ?OrderEntity
    {
        $captainId = $this->captainManager->getCaptainProfileByUserId($captainId);

        return $this->orderRepository->checkWhetherCaptainReceivedOrderForSpecificStore($captainId->getId(), $storeId);
    }

    public function getStoreOrdersByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->orderRepository->getStoreOrdersByStoreOwnerId($storeOwnerId);
    }

    public function updateIsCashPaymentConfirmedByStore(OrderUpdateIsCashPaymentConfirmedByStoreRequest $request): ?OrderEntity
    {
        $orderEntity = $this->orderRepository->find($request->getId());

        if (!$orderEntity) {
            return $orderEntity;
        }

        $orderEntity = $this->autoMapping->mapToObject(OrderUpdateIsCashPaymentConfirmedByStoreRequest::class, OrderEntity::class, $request, $orderEntity);

        $orderEntity->setIsCashPaymentConfirmedByStoreUpdateDate(new DateTime());

        // according to the updated field, we gonna decide if there is a conflict between answers or not
        if ($request->getIsCashPaymentConfirmedByStore() !== $orderEntity->getPaidToProvider()) {
            $orderEntity->setHasPayConflictAnswers(OrderHasPayConflictAnswersConstant::ORDER_HAS_PAYMENT_CONFLICT_ANSWERS);

        } else {
            // store and captain answers are the same, no conflict is existed
            $orderEntity->setHasPayConflictAnswers(OrderHasPayConflictAnswersConstant::ORDER_DOES_NOT_HAVE_PAYMENT_CONFLICT_ANSWERS);
        }

        $this->entityManager->flush();

        return $orderEntity;
    }

    public function getStoreOrdersWhichTakenByUniqueCaptainsAfterSpecificDate(StoreOwnerProfileEntity $storeOwnerProfileEntity, $specificDateTime): array
    {
        return $this->orderRepository->getStoreOrdersWhichTakenByUniqueCaptainsAfterSpecificDate($storeOwnerProfileEntity,
            $specificDateTime);
    }

    // filter Cash Orders which are not being answered by the store (paid or not paid) (for store)
    public function filterCashOrdersPaidOrNotByStore(CashOrdersPaidOrNotFilterByStoreRequest $request): array
    {
        return $this->orderRepository->filterCashOrdersPaidOrNotByStore($request);
    }

    public function updateStoreBranchToClientDistanceByAddNewDistance(OrderStoreBranchToClientDistanceUpdateRequest $request): string|OrderEntity
    {
        $orderEntity = $this->orderRepository->findOneBy(['id' => $request->getId()]);

        if (! $orderEntity) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        $orderEntity = $this->autoMapping->mapToObject(OrderStoreBranchToClientDistanceUpdateRequest::class, OrderEntity::class,
            $request, $orderEntity);

        $this->entityManager->flush();

        return $orderEntity;
    }

    public function getStoreBranchToClientDistanceByOrderId(int $orderId): float|string|null
    {
        $orderEntity = $this->orderRepository->findOneBy(['id' => $orderId]);

        if (! $orderEntity) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        return $orderEntity->getStoreBranchToClientDistance();
    }

    public function getStoreOwnerProfileByOrderId(int $orderId): string|StoreOwnerProfileEntity
    {
        $orderEntity = $this->orderRepository->findOneBy(['id' => $orderId]);

        if (! $orderEntity) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        return $orderEntity->getStoreOwner();
    }

    public function updateOrderDeliveryCost(OrderDeliveryCostUpdateRequest $request)
    {
        $orderEntity = $this->orderRepository->findOneBy(['id' => $request->getId()]);

        if (! $orderEntity) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        $orderEntity = $this->autoMapping->mapToObject(OrderDeliveryCostUpdateRequest::class, OrderEntity::class,
            $request, $orderEntity);

        $this->entityManager->flush();

        return $orderEntity;
    }

    public function getOrderEntityByIdAndState(int $orderId, string $orderState): ?OrderEntity
    {
        return $this->orderRepository->findOneBy(['id' => $orderId, 'state' => $orderState]);
    }

    /**
     * Get all orders with details that delivered by specific captain during specific date and storeBranchToClientDistance
     * for each order belong to the specific category of the third financial system
     */
    public function getOrdersDetailsByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): array
    {
        return $this->orderRepository->getOrdersDetailsByFinancialSystemThree($captainId, $fromDate, $toDate, $countKilometersFrom,
            $countKilometersTo);
    }

    /**
     * Get count of orders without distance and delivered by specific captain during specific time
     */
    public function getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderRepository->getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }
}
