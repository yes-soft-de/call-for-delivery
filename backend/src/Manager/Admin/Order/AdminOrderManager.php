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
use App\Request\Admin\Order\OrderRecycleOrCancelByAdminRequest;
use App\Request\Admin\Order\SubOrderCreateByAdminRequest;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;
use App\Constant\Order\OrderIsHideConstant;
use App\Constant\Order\OrderResultConstant;
use App\Request\Admin\Order\UpdateOrderByAdminRequest;
use App\AutoMapping;
use App\Request\Admin\Order\OrderAssignToCaptainByAdminRequest;
use App\Manager\Admin\Captain\AdminCaptainManager;
use App\Request\Admin\Order\OrderStateUpdateByAdminRequest;
use App\Constant\Captain\CaptainConstant;
use App\Request\Admin\Order\OrderCaptainFilterByAdminRequest;
use App\Request\Admin\Order\FilterOrdersPaidOrNotPaidByAdminRequest;
use App\Request\Admin\Order\FilterOrdersWhoseHasNotDistanceHasCalculatedRequest;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceByAdminRequest;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceAndDestinationByAdminRequest;
use App\Request\Admin\Order\OrderUpdateIsCashPaymentConfirmedByStoreByAdminRequest;

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

        // save current visibility
        $orderEntity->setPreviousVisibility($orderEntity->getIsHide());
        // update visibility
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

        if ($orderEntity) {
            //$orderEntity->setIsHide(OrderIsHideConstant::ORDER_SHOW);

            if (! $request->getDeliveryCost()) {
                $request->setDeliveryCost($orderEntity->getDeliveryCost());
            }

            $orderEntity = $this->autoMapping->mapToObject(UpdateOrderByAdminRequest::class, OrderEntity::class, $request, $orderEntity);

            // update order visibility to match last state in which it was before hiding the order
            $orderEntity->setIsHide($orderEntity->getPreviousVisibility());

            $orderEntity->setDeliveryDate($request->getDeliveryDate());

            $this->entityManager->flush();

            $this->adminStoreOrderDetailsManager->updateOrderDetail($orderEntity, $request);
        }
        
        return $orderEntity;
    }

    public function createOrderByAdmin(OrderCreateByAdminRequest $request): OrderEntity
    {
        $orderEntity = $this->autoMapping->map(OrderCreateByAdminRequest::class, OrderEntity::class, $request);

        $orderEntity->setDeliveryDate($orderEntity->getDeliveryDate());
        $orderEntity->setState(OrderStateConstant::ORDER_STATE_PENDING);
        $orderEntity->setOrderType(OrderTypeConstant::ORDER_TYPE_NORMAL);
        // $orderEntity->setIsHide(OrderIsHideConstant::ORDER_SHOW);
        $orderEntity->setPreviousVisibility($request->getIsHide());

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
        $orderEntity->setPreviousVisibility($orderEntity->getIsHide());

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
     * This function resolves a conflict answers (between captain and store about cash payment) for one order or multi orders.
     * Resolving the conflict is done by deciding the correct answer + updating the contrast one + mark that the conflict
     * is being resolved, and that's done via the API.
     *
     * Note: hasPayConflictAnswers to 2 (which means there is no conflict between the store's answer and the captain answer
     */
    public function resolveOrderHasPayConflictAnswersByAdmin(OrderHasPayConflictAnswersUpdateByAdminRequest $request): array
    {
        $ordersArray = $this->orderEntityRepository->filterCashPaymentAnsweredOrdersForAdmin($request);

        if (count($ordersArray) > 0) {
            foreach ($ordersArray as $orderEntity) {
                if ($request->getCorrectAnswer()) {
                    // admin decided that there is a correct answer
                    if ($request->getCorrectAnswer() === OrderConflictedAnswersResolvedByConstant::CAPTAIN_ANSWER_IS_CORRECT_CONST) {
                        // captain answer is the correct one. Update store's answer to it.
                        $orderEntity->setIsCashPaymentConfirmedByStore($orderEntity->getPaidToProvider());
                        $orderEntity->setIsCashPaymentConfirmedByStoreUpdateDate(new DateTime('now'));

                    } elseif ($request->getCorrectAnswer() === OrderConflictedAnswersResolvedByConstant::STORE_ANSWER_IS_CORRECT_CONST) {
                        // store's answer is the correct, update captain's answer to it.
                        $orderEntity->setPaidToProvider($orderEntity->getIsCashPaymentConfirmedByStore());
                    }
                }

                // Now, check that the conflict had being resolved, and by the API
                $orderEntity->setHasPayConflictAnswers(OrderHasPayConflictAnswersConstant::ORDER_DOES_NOT_HAVE_PAYMENT_CONFLICT_ANSWERS);

                $orderEntity->setConflictedAnswersResolvedBy(OrderConflictedAnswersResolvedByConstant::CONFLICTED_ANSWERS_RESOLVED_BY_ADMIN_CONST);

                $this->entityManager->flush();
            }
        }

        return $ordersArray;
    }

    // Update isCashPaymentConfirmedByStore by admin
    public function updateIsCashPaymentConfirmedByStoreByAdmin(OrderUpdateIsCashPaymentConfirmedByStoreByAdminRequest $request): ?OrderEntity
    {
        $orderEntity = $this->orderEntityRepository->find($request->getId());

        if (! $orderEntity) {
            return $orderEntity;
        }

        $orderEntity = $this->autoMapping->mapToObject(OrderUpdateIsCashPaymentConfirmedByStoreByAdminRequest::class, OrderEntity::class, $request, $orderEntity);

        $orderEntity->setIsCashPaymentConfirmedByStoreUpdateDate(new DateTime('now'));

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

    public function getOrderTypeAndDestinationFromStoreOrderDetailsByOrderIdForAdmin(int $orderId): ?array
    {
        return $this->orderEntityRepository->getOrderTypeAndDestinationFromStoreOrderDetailsByOrderIdForAdmin($orderId);
    }

    public function updateNormalOrderDestinationViaOrderIdAndDestinationArrayByAdmin(int $orderId, array $newDestination): ?OrderEntity
    {
        $orderEntity = $this->orderEntityRepository->find($orderId);

        if(! $orderEntity) {
            return $orderEntity;
        }

        $this->adminStoreOrderDetailsManager->updateDestinationByAddition($orderId, $newDestination);

        return $orderEntity;
    }

    // Add distance to the existing one (in storeBranchToClientDistance field)
    public function updateOrderStoreBranchToClientDistanceViaAddingNewDistanceByAdmin(int $orderId, float $distance, string $storeBranchToClientDistanceAdditionExplanation): ?OrderEntity
    {
        $orderEntity = $this->orderEntityRepository->find($orderId);

        if(! $orderEntity) {
            return $orderEntity;
        }

        $orderEntity->setStoreBranchToClientDistance($orderEntity->getStoreBranchToClientDistance() + $distance);
        $orderEntity->setStoreBranchToClientDistanceAdditionExplanation($storeBranchToClientDistanceAdditionExplanation);

        $this->entityManager->flush();

        return $orderEntity;
    }

    public function getOrderIsHideByOrderId(int $orderId): array
    {
        return $this->orderEntityRepository->getOrderIsHideByOrderId($orderId);
    }

    public function getOrderByOrderIdAndHideStateForAdmin(int $orderId, int $isHide): ?OrderEntity
    {
        return $this->orderEntityRepository->findOneBy(["id" => $orderId, "isHide" => $isHide]);
    }

    public function recyclingOrderByAdmin(OrderEntity $orderEntity, OrderRecycleOrCancelByAdminRequest $request): OrderEntity
    {
        $orderEntity = $this->autoMapping->mapToObject(OrderRecycleOrCancelByAdminRequest::class, OrderEntity::class,
            $request, $orderEntity);

        $orderEntity->setDeliveryDate($orderEntity->getDeliveryDate());
        $orderEntity->setState(OrderStateConstant::ORDER_STATE_PENDING);

        $this->entityManager->flush();

        $this->adminStoreOrderDetailsManager->updateStoreOrderDetailsAfterRecyclingByAdmin($orderEntity, $request);

        return $orderEntity;
    }

    // Get delivered orders during current active financial cycle of a captain by admin
    public function getOrdersByCaptainProfileIdAndCaptainFinancialCycle(int $captainProfileId): array
    {
        return $this->orderEntityRepository->getOrdersByCaptainProfileIdAndCaptainFinancialCycle($captainProfileId);
    }
}
