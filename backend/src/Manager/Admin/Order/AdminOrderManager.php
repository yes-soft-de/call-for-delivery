<?php

namespace App\Manager\Admin\Order;

use App\Constant\Order\OrderConflictedAnswersResolvedByConstant;
use App\Constant\Order\OrderHasPayConflictAnswersConstant;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Entity\OrderEntity;
use App\Repository\OrderEntityRepository;
use App\Request\Admin\Order\CaptainNotArrivedOrderFilterByAdminRequest;
use App\Request\Admin\Order\FilterDifferentlyAnsweredCashOrdersByAdminRequest;
use App\Request\Admin\Order\OrderCreateByAdminRequest;
use App\Request\Admin\Order\OrderFilterByAdminRequest;
use App\Request\Admin\Order\OrderHasPayConflictAnswersUpdateByAdminRequest;
use App\Request\Admin\Order\SubOrderCreateByAdminRequest;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;
use App\Constant\Order\OrderIsHideConstant;
use App\Constant\Order\OrderResultConstant;
use App\Request\Admin\Order\UpdateOrderByAdminRequest;
use App\AutoMapping;
use App\Manager\Admin\Order\AdminStoreOrderDetailsManager;
use App\Request\Admin\Order\OrderAssignToCaptainByAdminRequest;
use App\Manager\Admin\Captain\AdminCaptainManager;
use App\Request\Admin\Order\OrderStateUpdateByAdminRequest;
use App\Constant\Captain\CaptainConstant;
use App\Request\Admin\Order\OrderCaptainFilterByAdminRequest;
use App\Request\Admin\Order\FilterOrdersPaidOrNotPaidByAdminRequest;
use App\Request\Admin\Order\FilterOrdersWhoseHasNotDistanceHasCalculatedRequest;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceByAdminRequest;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceAndDestinationByAdminRequest;

class AdminOrderManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private OrderEntityRepository $orderEntityRepository;
    private AdminStoreOrderDetailsManager $adminStoreOrderDetailsManager;
    private AdminCaptainManager $adminCaptainManager;

    public function __construct(EntityManagerInterface $entityManager, OrderEntityRepository $orderEntityRepository, AutoMapping $autoMapping, AdminStoreOrderDetailsManager $adminStoreOrderDetailsManager, AdminCaptainManager $adminCaptainManager)
    {
        $this->entityManager = $entityManager;
        $this->orderEntityRepository = $orderEntityRepository;
        $this->autoMapping = $autoMapping;
        $this->adminStoreOrderDetailsManager = $adminStoreOrderDetailsManager;
        $this->adminCaptainManager = $adminCaptainManager;
    }

    public function getCountOrderOngoingForAdmin(): int
    {
        return $this->orderEntityRepository->getCountOrderOngoingForAdmin();
    }

    public function getAllOrdersCountForAdmin(): int
    {
        return count($this->orderEntityRepository->findAll());
    }

    public function filterStoreOrdersByAdmin(OrderFilterByAdminRequest $request): ?array
    {
        return $this->orderEntityRepository->filterStoreOrdersByAdmin($request);
    }

    public function getSpecificOrderByIdForAdmin(int $id): ?array
    {
        return $this->orderEntityRepository->getSpecificOrderByIdForAdmin($id);
    }

    // This function filters only orders in which the captain does not arrive the store yet
    public function filterCaptainNotArrivedOrdersByAdmin(CaptainNotArrivedOrderFilterByAdminRequest $request): ?array
    {
        return $this->orderEntityRepository->filterCaptainNotArrivedOrdersByAdmin($request);
    }

    public function filterStoreBidOrdersByAdmin(OrderFilterByAdminRequest $request): ?array
    {
        return $this->orderEntityRepository->filterStoreBidOrdersByAdmin($request);
    }

    public function getSpecificBidOrderByIdForAdmin(int $id): ?array
    {
        return $this->orderEntityRepository->getSpecificBidOrderByIdForAdmin($id);
    }
     
    public function getPendingOrdersForAdmin(): ?array
    {
        return $this->orderEntityRepository->getPendingOrdersForAdmin();
    }

    public function getHiddenOrdersForAdmin(): ?array
    {
        return $this->orderEntityRepository->getHiddenOrdersForAdmin();
    }

    /**
     * Not delivered orders are all orders which status = on way to pick order, in store, picked, or on going
     */
    public function getNotDeliveredOrdersForAdmin(): ?array
    {
        return $this->orderEntityRepository->getNotDeliveredOrdersForAdmin();
    }

    public function getOrderByIdForAdmin(int $orderId): ?OrderEntity
    {
        return $this->orderEntityRepository->find($orderId);
    }

    // This function updates the order info according to be become a pending orders
    public function returnOrderToPendingStatus(OrderEntity $orderEntity): OrderEntity
    {
        $orderEntity->setState(OrderStateConstant::ORDER_STATE_PENDING);
        $orderEntity->setCaptainId(null);
        $orderEntity->setDateCaptainArrived(null);
        $orderEntity->setIsCaptainArrived(false);
        $orderEntity->setUpdatedAt(new DateTime('now'));

        $this->entityManager->flush();

        return $orderEntity;
    }

    public function getPendingOrdersCountForAdmin(): int
    {
        return $this->orderEntityRepository->getPendingOrdersCountForAdmin();
    }

    public function getDeliveredOrdersCountBetweenTwoDatesForAdmin(DateTime $fromDate, DateTime $toDate): int
    {
        return $this->orderEntityRepository->getDeliveredOrdersCountBetweenTwoDatesForAdmin($fromDate, $toDate);
    }

    public function updateOrderToHidden(int $id): OrderEntity|string
    {
        $orderEntity = $this->orderEntityRepository->find($id);
        if(! $orderEntity) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        $orderEntity->setIsHide(OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE);

        $this->entityManager->flush();

        return $orderEntity;
    }

    public function getOrderByIdWithStoreOrderDetailForAdmin(int $orderId): ?array
    {
        return $this->orderEntityRepository->getOrderByIdWithStoreOrderDetail($orderId);
    }

    public function orderUpdateByAdmin(UpdateOrderByAdminRequest $request): OrderEntity
    {
        $orderEntity = $this->orderEntityRepository->find($request->getId());

        //$orderEntity->setIsHide(OrderIsHideConstant::ORDER_SHOW);

        $orderEntity = $this->autoMapping->mapToObject(UpdateOrderByAdminRequest::class, OrderEntity::class, $request, $orderEntity);
        $orderEntity->setDeliveryDate($request->getDeliveryDate());
        
        $this->entityManager->flush();

        $this->adminStoreOrderDetailsManager->updateOrderDetail($orderEntity, $request);
        
        return $orderEntity;
    }

    public function createOrderByAdmin(OrderCreateByAdminRequest $request): OrderEntity
    {
        $orderEntity = $this->autoMapping->map(OrderCreateByAdminRequest::class, OrderEntity::class, $request);

        $orderEntity->setDeliveryDate($orderEntity->getDeliveryDate());
        $orderEntity->setState(OrderStateConstant::ORDER_STATE_PENDING);
        $orderEntity->setOrderType(OrderTypeConstant::ORDER_TYPE_NORMAL);
        // $orderEntity->setIsHide(OrderIsHideConstant::ORDER_SHOW);

        $this->entityManager->persist($orderEntity);
        $this->entityManager->flush();

        $this->adminStoreOrderDetailsManager->createOrderDetailsByAdmin($orderEntity, $request);

        return $orderEntity;
    }
    
    public function getOrdersOngoingCountByCaptainIdForAdmin(int $captainId): int
    {
        return $this->orderEntityRepository->getOrdersOngoingCountByCaptainIdForAdmin($captainId);
    }

    public function getOrderById(int $orderId): ?OrderEntity
    {
        return $this->orderEntityRepository->find($orderId);
    }

    public function assignOrderToCaptain(OrderAssignToCaptainByAdminRequest $request, OrderEntity $orderEntity): OrderEntity|int
    {
        $captain = $this->adminCaptainManager->getCaptainProfileById($request->getId());
       
        if(! $captain) {
            return CaptainConstant::CAPTAIN_NOT_FOUND;
        }

        $orderEntity->setCaptainId($captain);
        $orderEntity->setState(OrderStateConstant::ORDER_STATE_ON_WAY);

        $this->entityManager->flush();

        return $orderEntity;
    }

    public function updateOrderStatusToCancelled(OrderEntity $orderEntity): OrderEntity
    {
        $orderEntity->setState(OrderStateConstant::ORDER_STATE_CANCEL);

        $this->entityManager->flush();

        return $orderEntity;
    }
    
    public function updateOrderStateByAdmin(OrderStateUpdateByAdminRequest $request): int|array|null
    {
        $orderEntity = $this->orderEntityRepository->find($request->getId());

        if(! $orderEntity) {
            return $orderEntity;
        }

        // currently, we can not update an order that its status is delivered
        if ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_DELIVERED) {
            return OrderResultConstant::ORDER_IS_BEING_DELIVERED;
        }

        $captainId = 0;

        if($request->getState() === OrderStateConstant::ORDER_STATE_PENDING){
            // save the captain id in order to return it to the Service function for creating local notification for him/her
            $captainId = $orderEntity->getCaptainId()->getCaptainId();

            $orderEntity->setCaptainId(null);
            $orderEntity->setDateCaptainArrived(null);
            $orderEntity->setIsCaptainArrived(false);
        }

        $orderEntity = $this->autoMapping->mapToObject(OrderStateUpdateByAdminRequest::class, OrderEntity::class, $request, $orderEntity);
        
        $this->entityManager->flush();
        
        return [$orderEntity, $captainId];
    }

    public function filterCaptainOrdersByAdmin(OrderCaptainFilterByAdminRequest $request): array
    {
        return $this->orderEntityRepository->filterCaptainOrdersByAdmin($request);
    }

    public function getSubOrdersByPrimaryOrderIdForAdmin(int $primaryOrderId): array
    {
        return $this->orderEntityRepository->getSubOrdersByPrimaryOrderIdForAdmin($primaryOrderId);
    }

    // filter orders in which the store's answer differs from that of the captain (paid or not paid)
    public function filterOrdersPaidOrNotPaidByAdmin(FilterOrdersPaidOrNotPaidByAdminRequest $request): ?array
    {
        return $this->orderEntityRepository->filterOrdersPaidOrNotPaidByAdmin($request);
    }
   
    // filter orders whose has not distance  has calculated
    public function filterOrdersWhoseHasNotDistanceHasCalculated(FilterOrdersWhoseHasNotDistanceHasCalculatedRequest $request): ?array
    {
        return $this->orderEntityRepository->filterOrdersWhoseHasNotDistanceHasCalculated($request);
    }
   
    public function updateStoreBranchToClientDistanceByAdmin(OrderStoreBranchToClientDistanceByAdminRequest $request): ?OrderEntity
    {
        $orderEntity = $this->orderEntityRepository->find($request->getId());

        if(! $orderEntity) {
            return $orderEntity;
        }

        $orderEntity = $this->autoMapping->mapToObject(OrderStoreBranchToClientDistanceByAdminRequest::class, OrderEntity::class, $request, $orderEntity);
        
        $this->entityManager->flush();
        
        return $orderEntity;
    }

    public function filterOrders(FilterOrdersWhoseHasNotDistanceHasCalculatedRequest $request): ?array
    {
        return $this->orderEntityRepository->filterOrders($request);
    }

    public function createSubOrderByAdmin(SubOrderCreateByAdminRequest $request): ?OrderEntity
    {
        $orderEntity = $this->autoMapping->map(SubOrderCreateByAdminRequest::class, OrderEntity::class, $request);

        $orderEntity->setDeliveryDate($orderEntity->getDeliveryDate());
        $orderEntity->setState(OrderStateConstant::ORDER_STATE_PENDING);
        $orderEntity->setOrderType(OrderTypeConstant::ORDER_TYPE_NORMAL);
        $orderEntity->setIsHide(OrderIsHideConstant::ORDER_HIDE);

        $this->entityManager->persist($orderEntity);
        $this->entityManager->flush();

        $orderCreateRequest = $this->autoMapping->map(SubOrderCreateByAdminRequest::class, OrderCreateByAdminRequest::class, $request);

        $this->adminStoreOrderDetailsManager->createOrderDetailsByAdmin($orderEntity, $orderCreateRequest);

        return $orderEntity;
    }

    public function filterOrdersNotAnsweredByTheStore(FilterOrdersPaidOrNotPaidByAdminRequest $request): ?array
    {
        return $this->orderEntityRepository->filterOrdersNotAnsweredByTheStore($request);
    }

    /** Following function check if captain has ongoing orders from specific store **/
//    public function checkWhetherCaptainReceivedOrderForSpecificStore(int $captainProfileId, int $storeId): ?OrderEntity
//    {
//        return $this->orderEntityRepository->checkWhetherCaptainReceivedOrderForSpecificStoreForAdmin($captainProfileId, $storeId);
//    }

    // filter cash orders which have different answers for cash payment
    public function filterDifferentAnsweredCashOrdersByAdmin(FilterDifferentlyAnsweredCashOrdersByAdminRequest $request): array
    {
        return $this->orderEntityRepository->filterDifferentAnsweredCashOrdersByAdmin($request);
    }

    // Get orders which accepted by captains and their created date is above 8/19/2022
    public function getOrders(): array
    {
        return $this->orderEntityRepository->getOrders();
    }
    
    public function updateStoreBranchToClientDistanceAndDestinationByAdmin(OrderStoreBranchToClientDistanceAndDestinationByAdminRequest $request): ?OrderEntity
    {
        $orderEntity = $this->orderEntityRepository->find($request->getOrderId());

        if(! $orderEntity) {
            return $orderEntity;
        }

        $orderEntity = $this->autoMapping->mapToObject(OrderStoreBranchToClientDistanceAndDestinationByAdminRequest::class, OrderEntity::class, $request, $orderEntity);
      
        $this->adminStoreOrderDetailsManager->updateDestination($request->getOrderId(), $request->getDestination());
        
        $this->entityManager->flush();
        
        return $orderEntity;
    }

    /**
     * this function resolves the orders which have conflicted answers about cash payment by updating the field
     * hasPayConflictAnswers to 2 (which means there is no conflict between the store's answer and the captain answer
     */
    public function resolveOrderHasPayConflictAnswersByAdmin(OrderHasPayConflictAnswersUpdateByAdminRequest $request): array
    {
        $ordersArray = $this->orderEntityRepository->filterCashPaymentAnsweredOrdersForAdmin($request);

        if (count($ordersArray) > 0) {
            foreach ($ordersArray as $orderEntity) {
                $orderEntity->setHasPayConflictAnswers(OrderHasPayConflictAnswersConstant::ORDER_DOES_NOT_HAVE_PAYMENT_CONFLICT_ANSWERS);

                $orderEntity->setConflictedAnswersResolvedBy(OrderConflictedAnswersResolvedByConstant::CONFLICTED_ANSWERS_RESOLVED_BY_ADMIN_CONST);

                $this->entityManager->flush();
            }
        }

        return $ordersArray;
    }
}
