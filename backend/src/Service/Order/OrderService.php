<?php

namespace App\Service\Order;

use App\AutoMapping;
use App\Constant\Eraser\EraserResultConstant;
use App\Constant\Notification\DashboardLocalNotification\DashboardLocalNotificationAppTypeConstant;
use App\Constant\Notification\DashboardLocalNotification\DashboardLocalNotificationMessageConstant;
use App\Constant\Notification\DashboardLocalNotification\DashboardLocalNotificationTitleConstant;
use App\Constant\Notification\NotificationTokenConstant;
use App\Constant\Order\OrderCostTypeConstant;
use App\Constant\Order\OrderHasPayConflictAnswersConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Constant\Order\OrderUpdateStateConstant;
use App\Constant\OrderLog\OrderLogActionTypeConstant;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Constant\OrderLog\OrderLogResultConstant;
use App\Constant\Payment\PaymentConstant;
use App\Constant\PriceOffer\PriceOfferStatusConstant;
use App\Constant\Subscription\SubscriptionDetailsConstant;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Entity\BidDetailsEntity;
use App\Entity\CaptainEntity;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Entity\OrderEntity;
use App\Entity\StoreOrderDetailsEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Manager\Order\OrderManager;
use App\Request\Order\BidOrderFilterBySupplierRequest;
use App\Request\Order\BidDetailsCreateRequest;
use App\Request\Order\CashOrdersPaidOrNotFilterByStoreRequest;
use App\Request\Order\OrderDeliveryCostUpdateRequest;
use App\Request\Order\OrderFilterByCaptainRequest;
use App\Request\Order\OrderFilterRequest;
use App\Request\Order\OrderCreateRequest;
use App\Request\Order\OrderStoreBranchToClientDistanceUpdateRequest;
use App\Request\Order\OrderUpdateByCaptainRequest;
use App\Request\Order\RePendingAcceptedOrderByCaptainRequest;
use App\Response\BidDetails\BidDetailsGetForCaptainResponse;
use App\Response\Order\BidOrderByIdGetForCaptainResponse;
use App\Response\Order\BidOrderForStoreOwnerGetResponse;
use App\Response\Order\CashOrdersPaidOrNotFilterByStoreResponse;
use App\Response\Order\FilterBidOrderByStoreOwnerResponse;
use App\Response\Order\OrderByIdForSupplierGetResponse;
use App\Response\Order\BidOrderFilterBySupplierResponse;
use App\Response\Order\FilterOrdersByCaptainResponse;
use App\Response\Order\OrderDeliveryCostUpdateResponse;
use App\Response\Order\OrderResponse;
use App\Response\Order\OrdersResponse;
use App\Response\Order\OrderClosestResponse;
use App\Response\Order\OrderUpdateByCaptainResponse;
use App\Response\Order\RePendingOrderByCaptainResponse;
use App\Response\OrderTimeLine\OrderLogsResponse;
use App\Response\Subscription\CanCreateOrderResponse;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Subscription\SubscriptionConstant;
use App\Service\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyService;
use App\Service\CaptainOrderFinancialService\OrderFinancialValueGetService;
use App\Service\DateFactory\DateFactoryService;
use App\Service\ExternallyDeliveredOrderHandle\ExternallyDeliveredOrderHandleService;
use App\Service\Notification\DashboardLocalNotification\DashboardLocalNotificationService;
use App\Service\OrderLog\OrderLogGetService;
use App\Service\OrderLog\OrderLogService;
use App\Service\Subscription\SubscriptionService;
use App\Service\Notification\NotificationLocalService;
use App\Service\Captain\CaptainService;
use App\Service\FileUpload\UploadFileHelperService;
use App\Constant\Captain\CaptainConstant;
use App\Response\Captain\CaptainStatusResponse;
use App\Response\Order\SpecificOrderForCaptainResponse;
use App\Constant\Order\OrderResultConstant;
use App\Constant\ChatRoom\ChatRoomConstant;
use App\Service\ChatRoom\OrderChatRoomService;
use App\Constant\Order\OrderStateConstant;
use App\Entity\OrderChatRoomEntity ;
use App\Request\Order\OrderUpdateCaptainOrderCostRequest;
use App\Response\Order\OrderUpdateCaptainOrderCostResponse;
use App\Constant\Order\OrderAttentionConstant;
use App\Request\Order\OrderUpdateCaptainArrivedRequest;
use App\Response\Order\OrderUpdateCaptainArrivedResponse;
use App\Service\OrderTimeLine\OrderTimeLineService;
use App\Service\Notification\NotificationFirebaseService;
use App\Response\Order\OrderCancelResponse;
use DateTime;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Service\CaptainFinancialSystem\CaptainFinancialDuesService;
use App\Service\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashService;
use App\Service\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersService;
use App\Response\Order\OrderUpdatePaidToProviderResponse;
use App\Request\Order\SubOrderCreateRequest;
use App\Constant\Order\OrderIsHideConstant;
use App\Request\Order\RecyclingOrCancelOrderRequest;
use App\Constant\Order\OrderIsCancelConstant;
use App\Constant\Notification\NotificationFirebaseConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Request\Order\UpdateOrderRequest;
use App\Response\Admin\Order\OrderUpdateToHiddenResponse;
use App\Constant\Order\OrderIsMainConstant;
use App\Request\Order\OrderUpdateIsCashPaymentConfirmedByStoreRequest;
use App\Response\Order\OrderUpdateIsCashPaymentConfirmedByStoreResponse;
use App\Constant\Order\OrderAmountCashConstant;
use App\Request\Subscription\CalculateCostDeliveryOrderRequest;
use App\Response\Subscription\CalculateCostDeliveryOrderResponse;
use DateTimeInterface;
use Doctrine\ORM\EntityManagerInterface;

class OrderService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private OrderManager $orderManager,
        private SubscriptionService $subscriptionService,
        private NotificationLocalService $notificationLocalService,
        private UploadFileHelperService $uploadFileHelperService,
        private CaptainService $captainService,
        private OrderChatRoomService $orderChatRoomService,
        private OrderTimeLineService $orderTimeLineService,
        private NotificationFirebaseService $notificationFirebaseService,
        private CaptainFinancialDuesService $captainFinancialDuesService,
        private CaptainAmountFromOrderCashService $captainAmountFromOrderCashService,
        private StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService,
        private BidOrderFinancialService $bidOrderFinancialService,
        private OrderLogService $orderLogService,
        private OrderLogGetService $orderLogGetService,
        private DateFactoryService $dateFactoryService,
        private OrderFinancialValueGetService $orderFinancialValueGetService,
        private StoreOrderDetailsService $storeOrderDetailsService,
        private DashboardLocalNotificationService $dashboardLocalNotificationService,
        private CaptainFinancialDailyService $captainFinancialDailyService,
        private ExternallyDeliveredOrderHandleService $externallyDeliveredOrderHandleService
    )
    {
    }

    public function createOrder(OrderCreateRequest $request): OrderResponse|CanCreateOrderResponse|string
    {
        if (new DateTime($request->getDeliveryDate()) < new DateTime('now')) {
            // we set the delivery date equals to current datetime + 3 minutes just for affording the late in persisting the order
            // to the database if it is happened
            $request->setDeliveryDate((new DateTime('+ 3 minutes'))->format('Y-m-d H:i:s'));
        }

        $canCreateOrder = $this->subscriptionService->canCreateOrder($request->getStoreOwner());

        if ($canCreateOrder === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS || $canCreateOrder->canCreateOrder === SubscriptionConstant::CAN_NOT_CREATE_ORDER) {

            return $canCreateOrder;
        }

        $request->setIsHide(OrderIsHideConstant::ORDER_SHOW);

        if ($canCreateOrder->subscriptionStatus === SubscriptionConstant::CARS_FINISHED) {

            $request->setIsHide(OrderIsHideConstant::ORDER_HIDE_TEMPORARILY);
        }

        $order = $this->orderManager->createOrder($request);

        if ($order) {
            $this->subscriptionService->updateRemainingOrders($request->getStoreOwner()->getStoreOwnerId(), SubscriptionConstant::OPERATION_TYPE_SUBTRACTION);

            $this->notificationLocalService->createNotificationLocal($request->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NEW_ORDER_TITLE,
                NotificationConstant::CREATE_ORDER_SUCCESS, NotificationTokenConstant::APP_TYPE_STORE, $order->getId());

            // create dashboard local notification
            // $this->createDashboardLocalNotificationByStore(DashboardLocalNotificationTitleConstant::CREATE_NEW_ORDER_BY_STORE_TITLE_CONST,
              // ["text" => DashboardLocalNotificationMessageConstant::CREATE_ORDER_BY_STORE_TEXT_CONST.$order->getId()], null, $order->getId());

            $this->orderTimeLineService->createOrderLogsRequest($order);

            // save log of the action on order
            $this->orderLogService->createOrderLogMessage($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                OrderLogActionTypeConstant::CREATE_ORDER_BY_STORE_ACTION_CONST, [], null,
                null);

            // send order to external delivery company
            $this->sendOrderToExternalDeliveryCompany($order);

            //create firebase notification to store
            try {
                $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), $order->getState(), NotificationConstant::STORE);
            } catch (\Exception $e) {
                error_log($e);
            }
            //create firebase notification to captains
            try {
                $this->notificationFirebaseService->notificationToCaptains($order->getId());

                // scheduled notification to captain
                //  $this->notificationFirebaseService->scheduledNotificationToCaptains($order->getId(), $order->getDeliveryDate());

            } catch (\Exception $e) {
                error_log($e);
            }

            // check if receiver location is a valid one
            $this->checkIfReceiverLocationIsValid($order->getId(), $request->getDestination(), $order->getStoreBranchToClientDistance());
        }

        return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $order);
    }

    public function createBidOrder(BidDetailsCreateRequest $request): OrderResponse|CanCreateOrderResponse|string
    {
        $canCreateOrder = $this->subscriptionService->getStoreOwnerProfileStatus($request->getStoreOwner());

        if ($canCreateOrder === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
            return $canCreateOrder;
        }

        $orderAndBidDetailsEntities = $this->orderManager->createBidOrder($request);

        if ($orderAndBidDetailsEntities[0]) {
            $this->notificationLocalService->createNotificationLocal($request->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NEW_BID_ORDER_TITLE,
                NotificationConstant::CREATE_BID_ORDER_SUCCESS, NotificationTokenConstant::APP_TYPE_STORE,
                $orderAndBidDetailsEntities[0]->getId());

            $this->orderTimeLineService->createOrderLogsRequest($orderAndBidDetailsEntities[0]);
            //create firebase notification to store
            try {
                $this->notificationFirebaseService->notificationOrderStateForUser($orderAndBidDetailsEntities[0]->getStoreOwner()->getStoreOwnerId(), $orderAndBidDetailsEntities[0]->getId(), $orderAndBidDetailsEntities[0]->getState(), NotificationConstant::STORE);
            } catch (\Exception $e) {
                error_log($e);
            }
            //create firebase notification to captains
            try {
                $this->notificationFirebaseService->notificationToCaptains($orderAndBidDetailsEntities[0]->getId());
            } catch (\Exception $e) {
                error_log($e);
            }
            //create firebase notification to supplier who belong to the same category that the bid order belong
            try {
                $this->notificationFirebaseService->sendNotificationToSpecificSuppliers($orderAndBidDetailsEntities[0]->getId(), $orderAndBidDetailsEntities[1]->getSupplierCategory()->getId());
            } catch (\Exception $e) {
                error_log($e);
            }
        }

        return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $orderAndBidDetailsEntities[0]);
    }

    public function getStoreOrders(int $userId): ?array
    {
        $response = [];

        $this->showSubOrderIfCarIsAvailable($userId, OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST);

        $this->hideOrderExceededDeliveryTimeByHour($userId, OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST);

        // Hide pending orders if the remaining cars of the store current subscription are finished
        $this->hidePendingOrderIfStoreSubscriptionRemainingCarsAreFinished($userId, OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST);

        $orders = $this->orderManager->getStoreOrders($userId);

        foreach ($orders as $order) {

            $order['subOrder'] = $this->orderManager->getSubOrdersByPrimaryOrderIdForStore($order['id']);

            $response[] = $this->autoMapping->map("array", OrdersResponse::class, $order);
        }

        return $response;
    }

    /**
     * Gets specific order details with store and captain info for store owner
     */
    public function getSpecificOrderForStore(int $id): ?OrdersResponse
    {
        $order = $this->orderManager->getSpecificOrderForStore($id);

        if ($order) {
            $order['attention'] = $order['noteCaptainOrderCost'];

            $order['images'] = $this->uploadFileHelperService->getImageParams($order['imagePath']);

            $order['filePdf'] = $this->uploadFileHelperService->getFileParams($order['filePdf']);

            if ($order['roomId']) {
                $order['roomId'] = $order['roomId']->toBase32();
            }

            if ($order['chatSupportRoomId']) {
                $order['chatSupportRoomId'] = $order['chatSupportRoomId']->toBase32();
            }

            $order['orderLogs'] = $this->orderTimeLineService->getOrderLogsByOrderId($id);

            $order['captain'] = null;

            if ($order['captainUserId']) {
                $order['captain'] = $this->captainService->getCaptain($order['captainUserId']);
            }

            $order['subOrder'] = $this->orderManager->getSubOrdersByPrimaryOrderIdForStore($order['id']);

            // If there is a note from admin about order distance conflict then return it in the response
            if ($order['orderDistanceConflict']) {
                $order['adminNote'] = $order['orderDistanceConflict']->getAdminNote();
            }
        }

        return $this->autoMapping->map("array", OrdersResponse::class, $order);
    }

    public function filterStoreOrders(OrderFilterRequest $request, int $userId): ?array
    {
        $response = [];

        $orders = $this->orderManager->filterStoreOrders($request, $userId);

        foreach ($orders as $order) {

            $order['subOrder'] = $this->orderManager->getSubOrdersByPrimaryOrderIdForStore($order['id']);

            $response[] = $this->autoMapping->map("array", OrdersResponse::class, $order);
        }

        return $response;
    }

    public function filterStoreBidOrders(OrderFilterRequest $request, int $userId): array
    {
        $response = [];

        $orders = $this->orderManager->filterStoreBidOrders($request, $userId);

        foreach ($orders as $order) {
            // get bid details info
            $order['bidDetailsId'] = $order['bidDetails']->getId();
            $order['title'] = $order['bidDetails']->getTitle();
            $order['openToPriceOffer'] = $order['bidDetails']->getOpenToPriceOffer();

            // get store branch info
            $order['storeOwnerBranchId'] = $order['bidDetails']->getBranch()->getId();
            $order['branchName'] = $order['bidDetails']->getBranch()->getName();
            $order['branchPhone'] = $order['bidDetails']->getBranch()->getBranchPhone();
            $order['location'] = $order['bidDetails']->getBranch()->getLocation();

            $order['supplierCategoryId'] = $order['bidDetails']->getSupplierCategory()->getId();
            $order['supplierCategoryName'] = $order['bidDetails']->getSupplierCategory()->getName();

            $response[] = $this->autoMapping->map("array", FilterBidOrderByStoreOwnerResponse::class, $order);
        }

        return $response;
    }

    public function closestOrders($userId): array|CaptainStatusResponse|string
    {
        $captain = $this->captainService->captainIsActive($userId);
        if ($captain->status === CaptainConstant::CAPTAIN_INACTIVE) {

            return $this->autoMapping->map(CaptainStatusResponse::class, CaptainStatusResponse::class, $captain);
        }

        //not show orders for captain because not online
        if ($captain->isOnline === CaptainConstant::CAPTAIN_ONLINE_FALSE) {
            return CaptainConstant::ERROR_CAPTAIN_ONLINE_FALSE;
        }

        $this->captainFinancialDuesService->updateCaptainFinancialSystemDetail($userId);

        $captainFinancialSystemStatus = $this->captainService->getCaptainFinancialSystemStatus($userId);
        if ($captainFinancialSystemStatus->status === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_INACTIVE) {
            return CaptainFinancialSystem::FINANCIAL_SYSTEM_INACTIVE;
        }

        $this->showSubOrderIfCarIsAvailable($userId, OrderLogCreatedByUserTypeConstant::CAPTAIN_USER_TYPE_CONST);
        $this->hideOrderExceededDeliveryTimeByHour($userId, OrderLogCreatedByUserTypeConstant::CAPTAIN_USER_TYPE_CONST);

        // Hide pending orders if the remaining cars of the store current subscription are finished
        $this->hidePendingOrderIfStoreSubscriptionRemainingCarsAreFinished($userId, OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST);

        $response = [];
        //get closest orders half an hour in advance
        $date = date_modify(new DateTime('now'), '+30 minutes');

        $orders = $this->orderManager->closestOrders($userId, $date);

        foreach ($orders as $key => $value) {
            $value['subOrder'] = $this->orderManager->getSubOrdersByPrimaryOrderId($value['id']);

            // Get the financial value that the order will add to the financial dues of the captain if he/she accept the order
            $value['captainProfit'] = $this->getSingleOrderFinancialValueByCaptainUserId($userId, $value['storeBranchToClientDistance']);

            if ($value['roomId']) {
                $value['roomId'] = $value['roomId']->toBase32();
                $value['usedAs'] = $this->getUsedAs($value['usedAs']);
            } else {
                $value['usedAs'] = ChatRoomConstant::CHAT_ENQUIRE_NOT_USE;
            }

            $response[$key] = $this->autoMapping->map('array', OrderClosestResponse::class, $value);

            if ($value['bidDetailsInfo']) {
                $response[$key]->branchName = $value['bidDetailsInfo']->getBranch()->getName();
                $response[$key]->location = $value['bidDetailsInfo']->getBranch()->getLocation();
                $response[$key]->sourceDestination = $value['bidDetailsInfo']->getSourceDestination();
            }
        }

        return $response;
    }

    // Currently we do not need this function
//    public function closestBidOrders(int $userId): array|CaptainStatusResponse
//    {
//        $captain = $this->captainService->captainIsActive($userId);
//
//        if ($captain->status === CaptainConstant::CAPTAIN_INACTIVE) {
//            return $this->autoMapping->map(CaptainStatusResponse::class ,CaptainStatusResponse::class, $captain);
//        }
//
//        $this->hideOrderExceededDeliveryTimeByHour();
//
//        $response = [];
//
//        $orders = $this->orderManager->closestBidOrders($userId);
//
//        foreach ($orders as $order) {
//            // get bid details info
//            $order['bidDetailsId'] = $order['bidDetails']->getId();
//            $order['title'] = $order['bidDetails']->getTitle();
//            $order['sourceDestination'] = $order['bidDetails']->getSourceDestination();
//
//            // get branch info
//            $order['branchName'] = $order['bidDetails']->getBranch()->getName();
//            $order['location'] = $order['bidDetails']->getBranch()->getLocation();
//
//            $response[] = $this->autoMapping->map('array', BidOrderClosestGetResponse::class, $order);
//        }
//
//        return $response;
//    }

    public function acceptedOrderByCaptainId($captainId): ?array
    {
        $response = [];

        $orders = $this->orderManager->acceptedOrderByCaptainId($captainId);

        foreach ($orders as $order) {
            $order['subOrder'] = $this->orderManager->getSubOrdersByPrimaryOrderId($order['id']);

            if ($order['bidDetails']) {
                // get branch info
                $order['branchName'] = $order['bidDetails']->getBranch()->getName();
                $order['location'] = $order['bidDetails']->getBranch()->getLocation();
                $order['sourceDestination'] = $order['bidDetails']->getSourceDestination();
            }

            $response[] = $this->autoMapping->map('array', OrderClosestResponse::class, $order);
        }

        return $response;
    }

    public function getSpecificOrderForCaptain(int $id, int $userId): null|SpecificOrderForCaptainResponse|string
    {
        $order = $this->orderManager->getSpecificOrderForCaptain($id, $userId);
        if ($order) {

            if ($order[0]->getState() !== OrderStateConstant::ORDER_STATE_PENDING) {
                if ($order[0]->getCaptainId()->getCaptainId() !== $userId) {
                    return OrderResultConstant::ORDER_ALREADY_IS_BEING_ACCEPTED;
                }
            }

            $order['subOrder'] = $this->orderManager->getSubOrdersByPrimaryOrderId($order['id']);

            $order['images'] = $this->uploadFileHelperService->getImageParams($order['imagePath']);
            $order['filePdf'] = $this->uploadFileHelperService->getFileParams($order['filePdf']);

            if ($order['roomId']) {
                $order['roomId'] = $order['roomId']->toBase32();
                $order['usedAs'] = $this->getUsedAs($order['usedAs']);
            } else {
                $order['usedAs'] = ChatRoomConstant::CHAT_ENQUIRE_NOT_USE;
            }

            $order['orderLogs'] = $this->orderTimeLineService->getOrderLogsByOrderId($id);

            if ($order['storeBranchToClientDistance'] !== null) {
                $order['storeBranchToClientDistance'] = (string)$order['storeBranchToClientDistance'];
            }
        }

        return $this->autoMapping->map("array", SpecificOrderForCaptainResponse::class, $order);
    }

    public function getSpecificBidOrderForCaptain(int $id, int $userId): ?BidOrderByIdGetForCaptainResponse
    {
        $order = $this->orderManager->getSpecificBidOrderForCaptain($id, $userId);

        if ($order) {
            $order['bidDetailsInfo'] = $this->autoMapping->map(BidDetailsEntity::class, BidDetailsGetForCaptainResponse::class, $order['bidDetails']);

            $order['bidDetailsInfo']->images = $this->customizeBidOrderImages($order['bidDetails']->getImages()->toArray());

            $order['bidDetailsInfo']->branchPhone = $order['bidDetails']->getBranch()->getBranchPhone();
            $order['bidDetailsInfo']->location = $order['bidDetails']->getBranch()->getLocation();
            $order['bidDetailsInfo']->sourceDestination = $order['bidDetails']->getSourceDestination();

            if ($order['roomId']) {
                $order['roomId'] = $order['roomId']->toBase32();
                $order['usedAs'] = $this->getUsedAs($order['usedAs']);

            } else {
                $order['usedAs'] = ChatRoomConstant::CHAT_ENQUIRE_NOT_USE;
            }

            $order['orderLogs'] = $this->orderTimeLineService->getOrderLogsByOrderId($id);
        }

        return $this->autoMapping->map("array", BidOrderByIdGetForCaptainResponse::class, $order);
    }

    public function orderUpdateStateByCaptain(OrderUpdateByCaptainRequest $request): OrderUpdateByCaptainResponse|string|int|null
    {
        // check captain complete account status
        $captainStatusResult = $this->captainService->getCompleteAccountStatusOfCaptainProfile($request->getCaptainId());

        if ($captainStatusResult !== null) {
            if ($captainStatusResult['completeAccountStatus'] === CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED) {
                return CaptainConstant::CAPTAIN_PROFILE_NOT_COMPLETED;
            }
        }
        // end check captain complete account status

        // check captain profile status
        $captain = $this->captainService->captainIsActive($request->getCaptainId());
        if ($captain->status === CaptainConstant::CAPTAIN_INACTIVE) {

            return CaptainConstant::CAPTAIN_INACTIVE;
        }
        // end check captain profile status

        $this->captainFinancialDuesService->updateCaptainFinancialSystemDetail($request->getCaptainId());

        $captainFinancialSystemStatus = $this->captainService->getCaptainFinancialSystemStatus($request->getCaptainId());
        if ($captainFinancialSystemStatus->status === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_INACTIVE) {
            return CaptainFinancialSystem::FINANCIAL_SYSTEM_INACTIVE;
        }

        // Check if captain try to update order state before specific time (except 'on way to pick order' state)
        if (in_array($request->getState(), OrderStateConstant::ORDER_STATE_ONGOING_TILL_DELIVERED_ARRAY)) {
            $result = $this->checkIfNormalOrderStateUpdateBeforeSpecificTimeForCaptain($request->getId(),
                $request->getCaptainId(), $request->getState());

            if ($result === true) {
                return OrderResultConstant::ORDER_UPDATE_STATE_NOT_ALLOWED_DUE_TO_SHORT_TIME_CONST;
            }
        }

        if ($request->getState() === OrderStateConstant::ORDER_STATE_ON_WAY) {

            //not show orders for captain because not online
            if ($captain->isOnline === CaptainConstant::CAPTAIN_ONLINE_FALSE) {
                return CaptainConstant::ERROR_CAPTAIN_ONLINE_FALSE;
            }
            // check if order is not being accepted by a captain yet
            if ($this->orderManager->isOrderAcceptedByCaptain($request->getId()) === true) {
                // order is already being accepted by another captain
                return OrderResultConstant::ORDER_ALREADY_IS_BEING_ACCEPTED;
            }

            $orderEntity = $this->orderManager->getOrderTypeByOrderId($request->getId());

            if ($orderEntity) {
                // Check whether the captain has received an order for a specific store
                $checkCaptainReceivedOrder = $this->checkWhetherCaptainReceivedOrderForSpecificStore($request->getCaptainId(), $orderEntity->getStoreOwner()->getId(), $orderEntity->getPrimaryOrder()?->getId());
                if ($checkCaptainReceivedOrder === OrderResultConstant::CAPTAIN_RECEIVED_ORDER_FOR_THIS_STORE_INT) {
                    return OrderResultConstant::CAPTAIN_RECEIVED_ORDER_FOR_THIS_STORE;
                }
                // end check

                if ($orderEntity->getOrderType() === OrderTypeConstant::ORDER_TYPE_NORMAL) {
                    // Following if block will be executed only when the order is not sub-order,
                    // otherwise, we will move to update statement directly
                    if ($orderEntity->getOrderIsMain() === OrderIsMainConstant::ORDER_MAIN || $orderEntity->getOrderIsMain() === OrderIsMainConstant::ORDER_MAIN_WITHOUT_SUBORDER) {
                        $canAcceptOrder = $this->subscriptionService->checkRemainingCarsByOrderId($request->getId());

                        if ($canAcceptOrder === SubscriptionConstant::CARS_FINISHED) {
                            return $canAcceptOrder;
                        }
                    }
                }
            }
        }

        $order = $this->orderManager->orderUpdateStateByCaptain($request);

        if ($order) {
            if ($order->getState() === OrderStateConstant::ORDER_STATE_CANCEL) {
                return OrderStateConstant::ORDER_STATE_CANCEL;
            }

            if ($order->getIsHide() === OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE) {
                return OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE;
            }

            if ($order->getState() === OrderStateConstant::ORDER_STATE_ON_WAY) {
                $this->createOrderChatRoomOrUpdateCurrent($order);
                // update the distance between the captain and the branch of the store
                $this->updateCaptainToStoreBranchDistanceByOrderId($order->getId(), $request->getCaptainToStoreBranchDistance());
            }

            if ($order->getState() === OrderStateConstant::ORDER_STATE_DELIVERED) {

                $this->captainFinancialDuesService->captainFinancialDues($request->getCaptainId()->getCaptainId());

                //Save the price of the order in cash in case the captain does not pay the store
                if ($this->checkCashOrderCostPaidToStoreOrNotByOrderEntity($order)) {
                    $this->captainAmountFromOrderCashService->createCaptainAmountFromOrderCash($order, OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO, $order->getOrderCost());
                    $this->storeOwnerDuesFromCashOrdersService->createStoreOwnerDuesFromCashOrders($order, OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO, $order->getOrderCost());
                }

                // Create or update captain financial daily amount
                $this->createOrUpdateCaptainFinancialDaily($order->getId());
            }

            // save log of the action on order
            $this->orderLogService->createOrderLogMessage($order, $request->getCaptainId()->getCaptainId(), OrderLogCreatedByUserTypeConstant::CAPTAIN_USER_TYPE_CONST,
                OrderLogActionTypeConstant::UPDATE_ORDER_STATE_BY_CAPTAIN_ACTION_CONST, [], null,
                null);

            //create Notification Local for store
            $this->notificationLocalService->createNotificationLocalForOrderState($order->getStoreOwner()->getStoreOwnerId(),
                NotificationConstant::STATE_TITLE, $order->getState(), NotificationConstant::STORE, $order->getId(),
                $order->getCaptainId()->getId());

            //create Notification Local for captain
            $this->notificationLocalService->createNotificationLocalForOrderState($order->getCaptainId()->getCaptainId(),
                NotificationConstant::STATE_TITLE, $order->getState(), NotificationConstant::CAPTAIN, $order->getId());

//            // create dashboard local notification
//            $this->createDashboardLocalNotificationByCaptain(DashboardLocalNotificationTitleConstant::UPDATE_ORDER_STATE_BY_CAPTAIN_TITLE_CONST,
//                ["text" => DashboardLocalNotificationMessageConstant::UPDATE_ORDER_STATE_BY_CAPTAIN_TEXT_CONST.$order->getId()], null, $order->getId());

            if ($order->getOrderType() === OrderTypeConstant::ORDER_TYPE_BID) {
                //create Notification Local for supplier
                $this->notificationLocalService->createNotificationLocalForOrderState($order->getBidDetailsEntity()->getSupplierProfile()->getUser()->getId(),
                    NotificationConstant::STATE_TITLE, $order->getState(), $order->getId(), NotificationConstant::SUPPLIER);
            }

            //create order log
            $this->orderTimeLineService->createOrderLogsRequest($order);
            //create firebase notification to store
            try {
                $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), $order->getState(), NotificationConstant::STORE);
            } catch (\Exception $e) {
                error_log($e);
            }
            // create firebase notification to captain
             try {
                 if ($order->getState() === OrderStateConstant::ORDER_STATE_ON_WAY) {
                     $this->notificationFirebaseService->notificationOrderStateForUser($order->getCaptainId()->getCaptainId(), $order->getId(), $order->getState(), NotificationConstant::CAPTAIN);
                 }

             } catch (\Exception $e){
                  error_log($e);
              }
        }

        return $this->autoMapping->map(OrderEntity::class, OrderUpdateByCaptainResponse::class, $order);
    }

    public function getUsedAs($usedAs): string
    {
        if ($usedAs === ChatRoomConstant::CAPTAIN_STORE_ENQUIRE) {

            return ChatRoomConstant::CHAT_ENQUIRE_USE;
        }

        return ChatRoomConstant::CHAT_ENQUIRE_NOT_USE;
    }

    public function createOrderChatRoomOrUpdateCurrent(OrderEntity $order): ?OrderChatRoomEntity
    {
        return $this->orderChatRoomService->createOrderChatRoomOrUpdateCurrent($order);
    }

    public function filterOrdersByCaptain(OrderFilterByCaptainRequest $request): ?array
    {
        $response = [];

        $orders = $this->orderManager->filterOrdersByCaptain($request);

        foreach ($orders as $order) {
            $order['subOrder'] = $this->orderManager->getSubOrdersByPrimaryOrderIdForStore($order['id']);

            if ($order['bidDetails']) {
                // get branch info
                $order['branchName'] = $order['bidDetails']->getBranch()->getName();
                $order['location'] = $order['bidDetails']->getBranch()->getLocation();
                $order['sourceDestination'] = $order['bidDetails']->getSourceDestination();
            }

            $response[] = $this->autoMapping->map('array', FilterOrdersByCaptainResponse::class, $order);
        }

        return $response;
    }

    public function orderUpdateCaptainOrderCost(OrderUpdateCaptainOrderCostRequest $request): ?OrderUpdateCaptainOrderCostResponse
    {
        $order = $this->orderManager->orderUpdateCaptainOrderCost($request);

        $response = $this->autoMapping->map(OrderEntity::class, OrderUpdateCaptainOrderCostResponse::class, $order);

        if ($order) {
            $response->attention = OrderAttentionConstant::ATTENTION_VALUE_MATCH;

            if ($order->getOrderCost() !== $order->getCaptainOrderCost()) {
                $response->attention = OrderAttentionConstant::ATTENTION_VALUE_NOT_MATCH;
            }
        }

        return $response;
    }

    public function updateCaptainArrived(OrderUpdateCaptainArrivedRequest $request): ?OrderUpdateCaptainArrivedResponse
    {
        $order = $this->orderManager->updateCaptainArrived($request);

        if ($order) {
            // create order log in order time line
            $this->orderTimeLineService->createOrderLogsRequest($order);

            // save log of the action on order
            $this->orderLogService->createOrderLogMessage($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                OrderLogActionTypeConstant::CONFIRM_CAPTAIN_ARRIVAL_BY_STORE_ACTION_CONST, [], null,
                null);

            // send firebase notification to admin if isCaptainArrived = false
            if ($order->getIsCaptainArrived() === false) {
                $this->notificationFirebaseService->notificationCaptainNotArrivedStoreToAdmin($order->getId());
            }
        }

        return $this->autoMapping->map(OrderEntity::class, OrderUpdateCaptainArrivedResponse::class, $order);
    }

    /**
     * This function currently cancel NORMAL order exclusively (not a bid order)
     */
    public function orderCancelByStoreOwner(int $orderId, int $userId)
    {
        // 1. Make sure order is exist
        $orderEntity = $this->getOrderEntityByOrderId($orderId);

        if (! $orderEntity) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        // 2. Check order type
        if ($orderEntity->getOrderType() === OrderTypeConstant::ORDER_TYPE_BID) {
            return OrderResultConstant::ORDER_TYPE_BID;
        }

        // 3. Check order state, and according to it, cancel order, or not
        if ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_PENDING) {
            // 3.1. Update order state
            $newUpdatedOrder = $this->orderManager->updateOrderStatusToCancelled($orderEntity);

            // 3.2. Update store subscription (remaining orders), if order relate
            if ($newUpdatedOrder) {
                $this->updateRemainingOrdersOfStoreSubscription($newUpdatedOrder->getStoreOwner()->getId(), $newUpdatedOrder->getCreatedAt(),
                    SubscriptionConstant::OPERATION_TYPE_ADDITION, 1);

                // 3.3. Create log
                $this->createOrderLogViaOrderEntity($newUpdatedOrder);

                $this->createOrderLogMessageViaOrderEntityAndByStoreOwner($newUpdatedOrder, $userId,
                    OrderLogActionTypeConstant::CANCEL_ORDER_BY_STORE_ACTION_CONST);

                // 3.4. Send notifications
                // local notification to store
                $this->createLocalNotificationForStore($userId, NotificationConstant::CANCEL_ORDER_TITLE,
                    NotificationConstant::CANCEL_ORDER_SUCCESS, $newUpdatedOrder->getId());

                // Create local notification for admin
                $this->createDashboardLocalNotificationByStore(DashboardLocalNotificationTitleConstant::CANCEL_ORDER_BY_STORE_TITLE_CONST,
                    ['text' => DashboardLocalNotificationMessageConstant::CANCEL_ORDER_BY_STORE_TEXT_CONST.$newUpdatedOrder->getId()],
                    null, $newUpdatedOrder->getId());

                // firebase notification to store
                $this->sendFirebaseNotificationAboutOrderStateForUser($userId, $newUpdatedOrder->getId(), $newUpdatedOrder->getState(),
                    NotificationConstant::STORE);

                return $this->autoMapping->map(OrderEntity::class, OrderCancelResponse::class, $newUpdatedOrder);
            }

            return OrderResultConstant::ORDER_UPDATE_PROBLEM;

        } elseif ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_ON_WAY) {
            // 3.1. Update order state and other info
            $arrayResult = $this->orderManager->updateOngoingOrderToCancelled($orderEntity);

            if ($arrayResult[0]) {
                // 3.2. Delete the chat room of the order
                $this->deleteChatRoomByOrderId($arrayResult[0]->getId());

                // 3.3. Update store subscription (remaining orders + remaining cars), if order relate
                $this->updateRemainingOrdersOfStoreSubscription($arrayResult[0]->getStoreOwner()->getId(), $arrayResult[0]->getCreatedAt(),
                    SubscriptionConstant::OPERATION_TYPE_ADDITION, 1);

                $this->updateRemainingCarsOfStoreSubscription($arrayResult[0]->getStoreOwner()->getId(), $arrayResult[0]->getCreatedAt(),
                    SubscriptionConstant::OPERATION_TYPE_ADDITION, 1);

                // 3.4. Create log
                $this->createOrderLogViaOrderEntity($arrayResult[0]);

                $this->createOrderLogMessageViaOrderEntityAndByStoreOwner($arrayResult[0], $userId,
                    OrderLogActionTypeConstant::CANCEL_ORDER_BY_STORE_ACTION_CONST);

                // 3.5. Send notifications
                // local notification to store
                $this->createLocalNotificationForStore($userId, NotificationConstant::CANCEL_ORDER_TITLE,
                    NotificationConstant::CANCEL_ORDER_SUCCESS, $arrayResult[0]->getId());

                // local notification to captain
                $this->createLocalNotificationForCaptain($arrayResult[1], NotificationConstant::CANCEL_ORDER_TITLE,
                    NotificationConstant::CANCEL_ORDER_SUCCESS, $arrayResult[0]->getId());

                // Create local notification for admin
                $this->createDashboardLocalNotificationByStore(DashboardLocalNotificationTitleConstant::CANCEL_ORDER_BY_STORE_TITLE_CONST,
                    ['text' => DashboardLocalNotificationMessageConstant::CANCEL_ORDER_BY_STORE_TEXT_CONST.$arrayResult[0]->getId()],
                    null, $arrayResult[0]->getId());

                // firebase notification to store
                $this->sendFirebaseNotificationAboutOrderStateForUser($userId, $arrayResult[0]->getId(), $arrayResult[0]->getState(),
                    NotificationConstant::STORE);

                // firebase notification to captain
                $this->sendFirebaseNotificationAboutOrderStateForUser($arrayResult[1], $arrayResult[0]->getId(), $arrayResult[0]->getState(),
                    NotificationConstant::CAPTAIN);

                return $this->autoMapping->map(OrderEntity::class, OrderCancelResponse::class, $arrayResult[0]);
            }

            return OrderResultConstant::ORDER_UPDATE_PROBLEM;

        } elseif ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_IN_STORE) {
            // 3.1. Update order state and other info
            $updatedOrder = $this->orderManager->updateInStoreOrderToCancelledByStore($orderEntity);

            if ($updatedOrder) {
                // 3.2. Delete the chat room of the order
                $this->deleteChatRoomByOrderId($updatedOrder->getId());

                // If the captain had reached the store then we won't update remaining orders

                // If the captain had reached the store, then we would count half of the order financial value for the captain
                // A. Update captain financial due
                $this->createOrUpdateCaptainFinancialDue($updatedOrder->getCaptainId()->getCaptainId(), $updatedOrder->getId(),
                    $updatedOrder->getCreatedAt());

                // B. Update captain financial daily
                $this->createOrUpdateCaptainFinancialDaily($updatedOrder->getId(), $updatedOrder->getCaptainId());

                $this->updateRemainingCarsOfStoreSubscription($updatedOrder->getStoreOwner()->getId(), $updatedOrder->getCreatedAt(),
                    SubscriptionConstant::OPERATION_TYPE_ADDITION, 1);

                // 3.4. Create log
                $this->createOrderLogViaOrderEntity($updatedOrder);

                $this->createOrderLogMessageViaOrderEntityAndByStoreOwner($updatedOrder, $userId,
                    OrderLogActionTypeConstant::CANCEL_ORDER_BY_STORE_ACTION_CONST);

                // 3.5. Send notifications
                // local notification to store
                $this->createLocalNotificationForStore($userId, NotificationConstant::CANCEL_ORDER_TITLE,
                    NotificationConstant::CANCEL_ORDER_SUCCESS, $updatedOrder->getId());

                // local notification to captain
                $this->createLocalNotificationForCaptain($updatedOrder->getCaptainId()->getCaptainId(), NotificationConstant::CANCEL_ORDER_TITLE,
                    NotificationConstant::CANCEL_ORDER_SUCCESS, $updatedOrder->getId());

                // Create local notification for admin
                $this->createDashboardLocalNotificationByStore(DashboardLocalNotificationTitleConstant::CANCEL_ORDER_BY_STORE_TITLE_CONST,
                    ['text' => DashboardLocalNotificationMessageConstant::CANCEL_ORDER_BY_STORE_TEXT_CONST.$updatedOrder->getId()],
                    null, $updatedOrder->getId());

                // firebase notification to store
                $this->sendFirebaseNotificationAboutOrderStateForUser($userId, $updatedOrder->getId(), $updatedOrder->getState(),
                    NotificationConstant::STORE);

                // firebase notification to captain
                $this->sendFirebaseNotificationAboutOrderStateForUser($updatedOrder->getCaptainId()->getCaptainId(),
                    $updatedOrder->getId(), $updatedOrder->getState(), NotificationConstant::CAPTAIN);

                return $this->autoMapping->map(OrderEntity::class, OrderCancelResponse::class, $updatedOrder);
            }

            return OrderResultConstant::ORDER_UPDATE_PROBLEM;

        } elseif (($orderEntity->getState() === OrderStateConstant::ORDER_STATE_ONGOING)
            || ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_DELIVERED)) {
            // Order is already being cancelled
            return OrderResultConstant::ORDER_IS_EITHER_ONGOING_OR_DELIVERED_CONST;

        }

        return OrderResultConstant::ORDER_ALREADY_BEING_CANCELLED;
    }

    public function getCountOrdersByCaptainId(int $captainId): array
    {
        return $this->orderManager->getCountOrdersByCaptainId($captainId);
    }

    public function getDetailOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getCountOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderManager->getCountOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    // This function filter bid orders which the supplier had not provide a price offer for any one of them yet.
    public function filterBidOrdersBySupplier(BidOrderFilterBySupplierRequest $request): array|string
    {
        $response = [];

        $result = $this->orderManager->filterBidOrdersBySupplier($request);

        // check before the profile status of the supplier
        if ($result === SupplierProfileConstant::INACTIVE_SUPPLIER_PROFILE_STRING_STATUS) {
            return SupplierProfileConstant::INACTIVE_SUPPLIER_PROFILE_RESULT;
        }

        foreach ($result as $key => $value) {
            $response[$key] = $this->autoMapping->map("array", BidOrderFilterBySupplierResponse::class, $value);

            $response[$key]->bidDetailsId = $value['bidDetails']->getId();
            $response[$key]->title = $value['bidDetails']->getTitle();
            $response[$key]->description = $value['bidDetails']->getDescription();
        }

        return $response;
    }

    public function getOrderByIdForSupplier(int $orderId, int $supplierId): OrderByIdForSupplierGetResponse|array
    {
        $response = [];

        $bidOrder = $this->orderManager->getOrderByIdForSupplier($orderId);

        if ($bidOrder) {
            $bidOrder['orderLogs'] = $this->orderTimeLineService->getOrderLogsByOrderId($bidOrder['id']);

            $bidOrder['bidDetailsId'] = $bidOrder['bidDetails']->getId();
            $bidOrder['bidDetailsImages'] = $this->customizeBidOrderImages($bidOrder['bidDetails']->getImages()->toArray());
            $bidOrder['title'] = $bidOrder['bidDetails']->getTitle();
            $bidOrder['description'] = $bidOrder['bidDetails']->getDescription();
            $bidOrder['openToPriceOffer'] = $bidOrder['bidDetails']->getOpenToPriceOffer();

            $bidOrder['pricesOffers'] = $this->filterAndCustomizePricesOffersAccordingToSupplier($bidOrder['bidDetails']->getPriceOfferEntities()->toArray(), $supplierId);

            if ($bidOrder['roomId']) {
                $bidOrder['roomId'] = $bidOrder['roomId']->toBase32();
            }

            $response = $this->autoMapping->map("array", OrderByIdForSupplierGetResponse::class, $bidOrder);
        }

        return $response;
    }

    // This function filter prices offers according to the supplier, and returns specific fields
    public function filterAndCustomizePricesOffersAccordingToSupplier(array $pricesOffersEntities, int $supplierId): ?array
    {
        if (!empty($pricesOffersEntities)) {
            $response = [];

            foreach ($pricesOffersEntities as $key => $value) {
                if ($value->getSupplierProfile()->getUser()->getId() === $supplierId) {
                    // get delivery car info
                    $response[$key]['deliveryCar']['id'] = $value->getDeliveryCar()->getId();
                    $response[$key]['deliveryCar']['carModel'] = $value->getDeliveryCar()->getCarModel();
                    $response[$key]['deliveryCar']['details'] = $value->getDeliveryCar()->getDetails();
                    $response[$key]['deliveryCar']['deliveryCost'] = $value->getDeliveryCar()->getDeliveryCost();

                    // get price offer info
                    $response[$key]['priceOfferId'] = $value->getId();
                    $response[$key]['priceOfferValue'] = $value->getPriceOfferValue();
                    $response[$key]['priceOfferStatus'] = $value->getPriceOfferStatus();
                    $response[$key]['transportationCount'] = $value->getTransportationCount();
                    $response[$key]['offerDeadline'] = $value->getOfferDeadline();
                }
            }

            return $response;
        }

        return null;
    }

    public function customizeBidOrderImages(array $imagesArray): ?array
    {
        $response = [];

        if (!empty($imagesArray)) {
            foreach ($imagesArray as $image) {
                $response[] = $this->uploadFileHelperService->getImageParams($image->getImagePath());
            }

            return $response;

        } else {
            return null;
        }
    }

    // This function filter bid orders which have price offers made by the supplier (who request the filter).
    public function filterBidOrdersThatHavePriceOffersBySupplier(BidOrderFilterBySupplierRequest $request): array
    {
        $response = [];

        $orders = $this->orderManager->filterBidOrdersThatHavePriceOffersBySupplier($request);

        if ($orders) {
            // if the price offer status filter is set, then we have to filter the orders here in the Service layer
            if ($request->getPriceOfferStatus()) {
                $orders = $this->filterBidOrdersAccordingToLastPriceOfferStatus($orders, $request->getPriceOfferStatus());
            }

            foreach ($orders as $order) {
                $response[] = $this->autoMapping->map("array", BidOrderFilterBySupplierResponse::class, $order);
            }
        }

        return $response;
    }

    // This function filter the orders according to the last offer status of each order
    public function filterBidOrdersAccordingToLastPriceOfferStatus(array $bidOrders, string $priceOfferStatus): array
    {
        $response = [];

        foreach ($bidOrders as $bidOrder) {
            $pricesOffer = $this->orderManager->getLastPriceOfferByBidDetailsId($bidOrder['bidDetailsId']);

            if (!empty($pricesOffer)) {
                if ($pricesOffer['priceOfferStatus'] === $priceOfferStatus) {
                    $response[] = $bidOrder;
                }
            }
        }

        return $response;
    }

    public function getSpecificBidOrderForStore(int $id, int $userId): ?BidOrderForStoreOwnerGetResponse
    {
        $order = $this->orderManager->getSpecificBidOrderForStore($id);

        if ($order) {
            $order['bidDetailsId'] = $order['bidDetails']->getId();
            $order['title'] = $order['bidDetails']->getTitle();
            $order['description'] = $order['bidDetails']->getDescription();
            $order['openToPriceOffer'] = $order['bidDetails']->getOpenToPriceOffer();

            $order['supplierCategoryId'] = $order['bidDetails']->getSupplierCategory()->getId();
            $order['supplierCategoryName'] = $order['bidDetails']->getSupplierCategory()->getName();
            $order['sourceDestination'] = $order['bidDetails']->getSourceDestination();
            $order['destination'] = $order['bidDetails']->getBranch()->getLocation();
            $order['storeOwnerBranchId'] = $order['bidDetails']->getBranch()->getId();
            $order['branchName'] = $order['bidDetails']->getBranch()->getName();

            $order['attention'] = $order['noteCaptainOrderCost'];

            $order['bidDetailsImages'] = $this->customizeBidOrderImages($order['bidDetails']->getImages()->toArray());

            if ($order['roomId']) {
                $order['roomId'] = $order['roomId']->toBase32();
            }

            // Check if there is confirmed price offer, then set deliver date as price offer deadline
            $priceOfferDeadlineResult = $this->getDeliveryDateOfConfirmedPriceOffer($order['bidDetails']->getPriceOfferEntities()->toArray());

            if ($priceOfferDeadlineResult !== null) {
                $order['deliveryDate'] = $priceOfferDeadlineResult;
            }

            $order['orderLogs'] = $this->orderTimeLineService->getOrderLogsByOrderId($id);

            $order['orderCost'] = $this->bidOrderFinancialService->getBidOrderTotalCostForStoreOwnerByBidDetailsId($order['bidDetails'], $userId);
        }

        return $this->autoMapping->map("array", BidOrderForStoreOwnerGetResponse::class, $order);
    }

    public function getDeliveryDateOfConfirmedPriceOffer(array $pricesOffersEntities): ?\DateTimeInterface
    {
        if (!empty($pricesOffersEntities)) {
            foreach ($pricesOffersEntities as $priceOfferEntity) {
                if ($priceOfferEntity->getPriceOfferStatus() === PriceOfferStatusConstant::PRICE_OFFER_CONFIRMED_STATUS) {
                    return $priceOfferEntity->getOfferDeadline();
                }
            }
        }

        return null;
    }

    /**
     * Hide the order that exceeded the delivery time by an hour
     */
    public function hideOrderExceededDeliveryTimeByHour(int $userId, int $userType)
    {
        //Get pending orders which aren't hidden nor sub orders
        $pendingOrders = $this->orderManager->getNotHiddenNotSubPendingOrders();

        foreach ($pendingOrders as $pendingOrder) {

            $deliveredDate = $pendingOrder->getDeliveryDate();

            $deliveredDate->diff(date_modify($deliveredDate, '+1 hours'));

            if (new DateTime('now') >= $deliveredDate) {

                $order = $this->orderManager->updateIsHide($pendingOrder, OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE);

                if ($order) {
                    if ($order->getOrderType() === OrderTypeConstant::ORDER_TYPE_NORMAL) {
                        $this->subscriptionService->updateRemainingOrders($order->getStoreOwner()->getStoreOwnerId(), SubscriptionConstant::OPERATION_TYPE_ADDITION);
                    }

                    // save log of the action on order
                    $this->orderLogService->createOrderLogMessage($order, $userId, $userType,
                        OrderLogActionTypeConstant::HIDE_ORDER_EXCEEDED_DELIVERY_TIME_ACTION_CONST, [], null,
                        null);

                    //create firebase notification to store
                    try {
                        $this->notificationFirebaseService->orderVisibilityNotificationToUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(),
                            NotificationFirebaseConstant::ORDER_IS_BEING_HIDDEN);

                    } catch (\Exception $e) {
                        error_log($e);
                    }
                }
            }
        }
    }

    public function orderUpdatePaidToProvider(int $orderId, int $paidToProvider, int $userId): OrderUpdatePaidToProviderResponse|null|int
    {
        //Is the captain allowed to edit?
        $captainAllowedEdit = $this->captainAmountFromOrderCashService->getEditingByCaptain($orderId);

        if ($captainAllowedEdit === false) {
            return OrderAmountCashConstant::CAPTAIN_NOT_ALLOWED_TO_EDIT_ORDER_PAID_FLAG_STRING;
        }

        $order = $this->orderManager->orderUpdatePaidToProvider($orderId, $paidToProvider);

        if ($order->getPayment() === OrderTypeConstant::ORDER_PAYMENT_CASH) {
            //if captain paid to provider
            if ($order->getPaidToProvider() === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_YES) {
                $orderCost = 0;
                $flag = OrderTypeConstant::ORDER_PAID_TO_PROVIDER_YES;
            }
            //if captain not paid provider
            if ($order->getPaidToProvider() === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                $orderCost = $order->getOrderCost();
                $flag = OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO;
            }

            $this->captainAmountFromOrderCashService->createCaptainAmountFromOrderCash($order, $flag, $orderCost);
            $this->storeOwnerDuesFromCashOrdersService->createStoreOwnerDuesFromCashOrders($order, $flag, $orderCost);

            $this->captainFinancialDuesService->captainFinancialDues($order->getCaptainId()->getCaptainId());
        }

        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::CAPTAIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::UPDATE_PAID_TO_PROVIDER_BY_CAPTAIN_ACTION_CONST, [], null,
            null);

        return $this->autoMapping->map(OrderEntity::class, OrderUpdatePaidToProviderResponse::class, $order);
    }

    public function createSubOrder(SubOrderCreateRequest $request): OrderResponse|string
    {
        $packageBalance = $this->subscriptionService->packageBalance($request->getStoreOwner());

        if ($packageBalance->remainingOrders <= 0) {

            return SubscriptionConstant::CAN_NOT_CREATE_SUB_ORDER;
        }

        $primaryOrder = $this->orderManager->getOrderById($request->getPrimaryOrder());
        if ($primaryOrder->getState() === OrderStateConstant::ORDER_STATE_DELIVERED) {
            return OrderStateConstant::ORDER_STATE_DELIVERED;
        }

        if ($primaryOrder->getCaptainId()) {
            $request->setCaptainId($primaryOrder->getCaptainId());
        }

        $request->setPrimaryOrder($primaryOrder);

        if (new DateTime($request->getDeliveryDate()) < new DateTime('now')) {
            // we set the delivery date equals to current datetime + 3 minutes just for affording the late in persisting the order
            // to the database if it is happened
            $request->setDeliveryDate((new DateTime('+ 3 minutes'))->format('Y-m-d H:i:s'));
        }

        $order = $this->orderManager->createSubOrder($request);

        if ($order) {
            $this->subscriptionService->updateRemainingOrders($request->getStoreOwner()->getStoreOwnerId(), SubscriptionConstant::OPERATION_TYPE_SUBTRACTION);
            //notification to store
            $this->notificationLocalService->createNotificationLocal($request->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NEW_SUB_ORDER_TITLE,
                NotificationConstant::CREATE_SUB_ORDER_SUCCESS, NotificationTokenConstant::APP_TYPE_STORE, $order->getId());

            // create dashboard local notification
            $this->createDashboardLocalNotificationByStore(DashboardLocalNotificationTitleConstant::CREATE_SUB_ORDER_BY_STORE_TITLE_CONST,
                ["text" => DashboardLocalNotificationMessageConstant::CREATE_SUB_ORDER_BY_STORE_TEXT_CONST.$order->getId()], null, $order->getId());

            if ($primaryOrder->getCaptainId()) {
                //notification to captain
                $this->notificationLocalService->createNotificationLocal($primaryOrder->getCaptainId()->getCaptainId(), NotificationConstant::NEW_SUB_ORDER_TITLE,
                    NotificationConstant::ADD_SUB_ORDER, NotificationTokenConstant::APP_TYPE_CAPTAIN, $request->getPrimaryOrder()->getId());
            }

            $this->orderTimeLineService->createOrderLogsRequest($order);

            // save log of the action on order
            $this->orderLogService->createOrderLogMessage($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                OrderLogActionTypeConstant::CREATE_SUB_ORDER_BY_STORE_ACTION_CONST, [], null,
                null);

            // send order to external delivery company
            $this->sendOrderToExternalDeliveryCompany($order);

            try {
                // create firebase notification to store
                $this->notificationFirebaseService->notificationSubOrderForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), NotificationFirebaseConstant::CREATE_SUB_ORDER_SUCCESS);
                if ($primaryOrder->getCaptainId()) {
                    //create firebase notification to captain
                    $this->notificationFirebaseService->notificationSubOrderForUser($primaryOrder->getCaptainId()->getCaptainId(), $order->getId(), NotificationFirebaseConstant::ADD_SUB_ORDER);
                }
            } catch (\Exception $e) {
                error_log($e);
            }
        }

        return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $order);
    }

    /**
     * un-link order by captain
     * orderId is the id of the sub order
     */
    public function orderNonSub(int $orderId, $userId): ?OrderUpdatePaidToProviderResponse
    {
        $checkRemainingCars = $this->subscriptionService->checkRemainingCarsByOrderId($orderId);

        $isHide = OrderIsHideConstant::ORDER_SHOW;

        if ($checkRemainingCars === SubscriptionConstant::CARS_FINISHED) {
            $isHide = OrderIsHideConstant::ORDER_HIDE_TEMPORARILY;
        }

        $order = $this->orderManager->updateIsHideByOrderId($orderId, $isHide);

        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::CAPTAIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::UN_LINK_SUB_ORDER_BY_CAPTAIN_ACTION_CONST, [], null,
            null);

        //notification to store
        $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NON_SUB_ORDER_TITLE,
            NotificationConstant::NON_SUB_ORDER_BY_CAPTAIN, NotificationTokenConstant::APP_TYPE_STORE, $order->getId());

        if ($isHide === OrderIsHideConstant::ORDER_HIDE_TEMPORARILY) {
            $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::SUB_ORDER_ATTENTION,
                NotificationConstant::SUB_ORDER_HIDE_TEMPORARILY, NotificationTokenConstant::APP_TYPE_STORE, $order->getId());
        }

        //notification to captain
        $this->notificationLocalService->createNotificationLocal($userId, NotificationConstant::NON_SUB_ORDER_TITLE, NotificationConstant::NON_SUB_ORDER,
            NotificationTokenConstant::APP_TYPE_CAPTAIN, $order->getId());

        // create dashboard local notification
        $this->createDashboardLocalNotificationByCaptain(DashboardLocalNotificationTitleConstant::UN_LINK_ORDERS_BY_CAPTAIN_TITLE_CONST,
            ["text" => DashboardLocalNotificationMessageConstant::UN_LINK_ORDERS_BY_CAPTAIN_TEXT_CONST.$order->getId()], null, $order->getId());

        try {
            // create firebase notification to store
            $this->notificationFirebaseService->notificationSubOrderForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), NotificationFirebaseConstant::NON_SUB_ORDER_BY_CAPTAIN);
            if ($isHide === OrderIsHideConstant::ORDER_HIDE_TEMPORARILY) {
                $this->notificationFirebaseService->notificationSubOrderForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), NotificationFirebaseConstant::SUB_ORDER_HIDE_TEMPORARILY);
            }
            //create firebase notification to captain
            $this->notificationFirebaseService->notificationSubOrderForUser($userId, $order->getId(), NotificationFirebaseConstant::NON_SUB_ORDER);
        } catch (\Exception $e) {
            error_log($e);
        }

        return $this->autoMapping->map(OrderEntity::class, OrderUpdatePaidToProviderResponse::class, $order);
    }

    // This function update isHide for all orders to 2 (Show order value)
//    public function isHideShow()
//    {
//        $order = $this->orderManager->isHideShow();
//
//        return $this->autoMapping->map(OrderEntity::class, OrderUpdatePaidToProviderResponse::class, $order);
//    }

    //Show the sub-order for captains if a car is available
    //Show Temporarily hidden orders
    //Modify the field (isHide) from (ORDER_HIDE_TEMPORARILY) to (ORDER_SHOW)
    public function showSubOrderIfCarIsAvailable(int $userId, int $userType)
    {
        $orders = $this->orderManager->getOrderTemporarilyHidden();
        foreach ($orders as $order) {

            $checkRemainingCars = $this->subscriptionService->checkRemainingCarsByOrderId($order->getId());

            if ($checkRemainingCars === SubscriptionConstant::SUBSCRIPTION_OK) {
              
                $order->setCreatedAt(new DateTime('now'));

                $order = $this->orderManager->updateIsHide($order, OrderIsHideConstant::ORDER_SHOW);

                // save log of the action on order
                $this->orderLogService->createOrderLogMessage($order, $userId, $userType, OrderLogActionTypeConstant::SHOW_SUB_ORDER_IF_CAR_AVAILABLE_ACTION_CONST,
                    [], null, null);

                //notification to store
                $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::SUB_ORDER_ATTENTION,
                    NotificationConstant::SUB_ORDER_SHOW, NotificationTokenConstant::APP_TYPE_STORE, $order->getId());
                try {
                    // create firebase notification to store
                    $this->notificationFirebaseService->notificationSubOrderForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), NotificationFirebaseConstant::SUB_ORDER_SHOW);
                } catch (\Exception $e) {
                    error_log($e);
                }
            }
        }
    }

    public function recyclingOrCancelOrder(RecyclingOrCancelOrderRequest $request): OrderCancelResponse|CanCreateOrderResponse|null|OrderResponse|string
    {
        $orderEntity = $this->orderManager->getOrderByOrderIdAndState($request->getId(), OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE);
       
        if ($orderEntity) {
            if ($request->getCancel() === OrderIsCancelConstant::ORDER_CANCEL) {

                $order = $this->orderManager->orderCancel($orderEntity);

                if ($order) {
                    $this->orderTimeLineService->createOrderLogsRequest($order);

                    // save log of the action on order
                    $this->orderLogService->createOrderLogMessage($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                        OrderLogActionTypeConstant::CANCEL_ORDER_BY_STORE_ACTION_CONST, [], null,
                        null);

                    //create local notification to store
                    $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::CANCEL_ORDER_TITLE,
                        NotificationConstant::CANCEL_ORDER_SUCCESS, NotificationTokenConstant::APP_TYPE_STORE, $order->getId());

                    // create dashboard local notification
                    $this->createDashboardLocalNotificationByStore(DashboardLocalNotificationTitleConstant::CANCEL_ORDER_BY_STORE_TITLE_CONST,
                        ["text" => DashboardLocalNotificationMessageConstant::CANCEL_ORDER_BY_STORE_TEXT_CONST.$order->getId()], null, $order->getId());

                    //create firebase notification to store
                    try {
                        $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), NotificationConstant::CANCEL_ORDER_SUCCESS, NotificationConstant::STORE);
                    } catch (\Exception $e) {
                        error_log($e);
                    }
                }

                return $this->autoMapping->map(OrderEntity::class, OrderCancelResponse::class, $order);
            }

            if (new DateTime($request->getDeliveryDate()) < new DateTime('now')) {
                // we set the delivery date equals to current datetime + 3 minutes just for affording the late in persisting the order
                // to the database if it is happened
                $request->setDeliveryDate((new DateTime('+ 3 minutes'))->format('Y-m-d H:i:s'));
            }

            $canCreateOrder = $this->subscriptionService->canCreateOrder($orderEntity->getStoreOwner()->getStoreOwnerId());

            if ($canCreateOrder->canCreateOrder === SubscriptionConstant::CAN_NOT_CREATE_ORDER) {

                return $canCreateOrder;
            }
           
            $request->setIsHide(OrderIsHideConstant::ORDER_SHOW);

            if ($canCreateOrder->subscriptionStatus === SubscriptionConstant::CARS_FINISHED) {
    
                $request->setIsHide(OrderIsHideConstant::ORDER_HIDE_TEMPORARILY);
            }

            $order = $this->orderManager->recyclingOrder($orderEntity, $request);
            if ($order) {

                $this->subscriptionService->updateRemainingOrders($orderEntity->getStoreOwner()->getStoreOwnerId(), SubscriptionConstant::OPERATION_TYPE_SUBTRACTION);

                // save log of the action on order
                $this->orderLogService->createOrderLogMessage($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::RECYCLE_ORDER_BY_STORE_ACTION_CONST, [], null,
                    null);

                $this->notificationLocalService->createNotificationLocal($orderEntity->getStoreOwner()->getStoreOwnerId(), NotificationConstant::RECYCLING_ORDER_TITLE,
                    NotificationConstant::RECYCLING_ORDER_SUCCESS, NotificationTokenConstant::APP_TYPE_STORE, $order->getId());

                // create dashboard local notification
                $this->createDashboardLocalNotificationByStore(DashboardLocalNotificationTitleConstant::RECYCLE_ORDER_BY_STORE_TITLE_CONST,
                    ["text" => DashboardLocalNotificationMessageConstant::RECYCLE_ORDER_BY_STORE_TEXT_CONST.$order->getId()], null, $order->getId());

                //create firebase notification to store
//                  try{
//                       $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), $order->getState(), NotificationConstant::STORE);
//                       }
//                  catch (\Exception $e){
//                       error_log($e);
//                     }
                //create firebase notification to captains
                try {
                    $this->notificationFirebaseService->notificationToCaptains($order->getId());
                } catch (\Exception $e) {
                    error_log($e);
                }
            }

            return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $order);
        }

        return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $orderEntity);
    }

    /**
     * un-link order by store
     * orderId is the id of the sub order
     */
    public function orderNonSubByStore(int $orderId): OrderUpdatePaidToProviderResponse|string
    {
        $checkRemainingCars = $this->subscriptionService->checkRemainingCarsByOrderId($orderId);

        $isHide = OrderIsHideConstant::ORDER_SHOW;

        if ($checkRemainingCars === SubscriptionConstant::CARS_FINISHED) {
            $isHide = OrderIsHideConstant::ORDER_HIDE_TEMPORARILY;
        }

        $order = $this->orderManager->orderNonSubByStore($orderId, $isHide);

        if ($order === OrderResultConstant::ORDER_CAPTAIN_RECEIVED) {
            return $order;
        }

        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
            OrderLogActionTypeConstant::UN_LINK_SUB_ORDER_BY_STORE_ACTION_CONST, [], null,
            null);

        //notification to store
        $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NON_SUB_ORDER_TITLE,
            NotificationConstant::NON_SUB_ORDER, NotificationTokenConstant::APP_TYPE_STORE, $order->getId());

        // create dashboard local notification
        $this->createDashboardLocalNotificationByStore(DashboardLocalNotificationTitleConstant::UN_LINK_ORDERS_BY_STORE_TITLE_CONST,
            ["text" => DashboardLocalNotificationMessageConstant::UN_LINK_ORDERS_BY_STORE_TEXT_CONST.$order->getId()], null, $order->getId());

        if ($isHide === OrderIsHideConstant::ORDER_HIDE_TEMPORARILY) {
            $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::SUB_ORDER_ATTENTION,
                NotificationConstant::SUB_ORDER_HIDE_TEMPORARILY, NotificationTokenConstant::APP_TYPE_STORE, $order->getId());
        }

        if ($isHide = OrderIsHideConstant::ORDER_SHOW) {
            //create firebase notification to captains
            try {
                $this->notificationFirebaseService->notificationToCaptains($order->getId());
                $this->notificationFirebaseService->notificationSubOrderForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), NotificationFirebaseConstant::SUB_ORDER_SHOW);
            } catch (\Exception $e) {
                error_log($e);
            }
        }

        return $this->autoMapping->map(OrderEntity::class, OrderUpdatePaidToProviderResponse::class, $order);
    }

    public function getordersHiddenDueToExceedingDeliveryTime(int $userId): ?array
    {
        $response = [];

        $this->showSubOrderIfCarIsAvailable($userId, OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST);

        $this->hideOrderExceededDeliveryTimeByHour($userId, OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST);

        // Hide pending orders if the remaining cars of the store current subscription are finished
        $this->hidePendingOrderIfStoreSubscriptionRemainingCarsAreFinished($userId, OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST);

        $orders = $this->orderManager->getordersHiddenDueToExceedingDeliveryTime($userId);

        foreach ($orders as $order) {
            $order['subOrder'] = $this->orderManager->getSubOrdersByPrimaryOrderIdForStore($order['id']);

            $response[] = $this->autoMapping->map("array", OrdersResponse::class, $order);
        }

        return $response;
    }

    public function cancelBidOrder(int $orderId): string|BidOrderForStoreOwnerGetResponse|null
    {
        $bidOrderResult = $this->orderManager->cancelBidOrder($orderId);

        if ($bidOrderResult === OrderResultConstant::ORDER_NOT_REMOVE_STATE || $bidOrderResult === OrderResultConstant::ORDER_TYPE_IS_NOT_BID) {
            return $bidOrderResult;
        }

        return $this->autoMapping->map(OrderEntity::class, BidOrderForStoreOwnerGetResponse::class, $bidOrderResult);
    }

    public function getOrdersByCaptainId(int $captainId): array
    {
        return $this->orderManager->getOrdersByCaptainId($captainId);
    }

    public function getSubOrdersByPrimaryOrderId(int $orderId): array
    {
        return $this->orderManager->getSubOrdersByPrimaryOrderId($orderId);
    }

    public function orderUpdate(UpdateOrderRequest $request): string|null|OrderResponse
    {
        if (new DateTime($request->getDeliveryDate()) < new DateTime('now')) {
            // we set the delivery date equals to current datetime + 3 minutes just for affording the late in persisting the order
            // to the database if it is happened
            $request->setDeliveryDate((new DateTime('+ 3 minutes'))->format('Y-m-d H:i:s'));
        }

        $order = $this->orderManager->getOrderByIdWithStoreOrderDetail($request->getId());

        if ($order) {
            // if( $order['state'] === OrderStateConstant::ORDER_STATE_IN_STORE) {
            //   if( $request->getBranch() !== $order['storeOwnerBranchId']) {

            //     return OrderResultConstant::ERROR_UPDATE_BRANCH;
            //   }
            // }

            // if( $order['state'] === OrderStateConstant::ORDER_STATE_ONGOING) {
            //     if( new DateTime($request->getDeliveryDate()) != $order['deliveryDate'] || $request->getDestination() !== $order['destination'] || $request->getDetail() !== $order['detail']) {

            //         return OrderResultConstant::ERROR_UPDATE_CAPTAIN_ONGOING;
            //       }
            // }

            // *** Check if there are any remaining cars in order to hide or show order ***
            //$request->setIsHide($order['isHide']);

            //$checkRemainingCarsResult = $this->subscriptionService->checkRemainingCarsOnlyByOrderId($request->getId());

//            if ($checkRemainingCarsResult !== SubscriptionConstant::YOU_DO_NOT_HAVE_SUBSCRIBED) {
//                if ($checkRemainingCarsResult <= 0) {
//                    $request->setIsHide(OrderIsHideConstant::ORDER_HIDE_TEMPORARILY);
//
//                } else {
//                    $request->setIsHide(OrderIsHideConstant::ORDER_SHOW);
//                }
//
//                // But if the order is a sub order, then we have to hide it in all circumstances
//                if ($order['primaryOrderId']) {
//                    $request->setIsHide(OrderIsHideConstant::ORDER_HIDE);
//                }
//            }
            // *** End check ***

            $order = $this->orderManager->orderUpdate($request);

            if ($order) {

                // save log of the action on order
                $this->orderLogService->createOrderLogMessage($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::UPDATE_ORDER_BY_STORE_ACTION_CONST, [], null,
                    null);

                if ($order->getCaptainId()) {
                    // create firebase notification to captain
                    try {
                        $this->notificationFirebaseService->notificationToUser($order->getCaptainId()->getCaptainId(), $order->getId(), NotificationFirebaseConstant::ORDER_UPDATE_BY_STORE);
                    } catch (\Exception $e) {
                        error_log($e);
                    }
                }

                // send firebase notification to admin
                $this->sendFirebaseNotificationToAdminAboutOrder($order->getId(), NotificationFirebaseConstant::ORDER_UPDATE_BY_STORE);
            }
        }

        return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $order);
    }

    public function updateOrderToHiddenForStore(int $id): OrderUpdateToHiddenResponse|string
    {
        $orderEntity = $this->orderManager->updateOrderToHiddenForStore($id);
        if ($orderEntity === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($orderEntity, $orderEntity->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
            OrderLogActionTypeConstant::HIDE_ORDER_WHILE_UPDATING_BY_STORE_ACTION_CONST, [], null,
            null);

        return $this->autoMapping->map(OrderEntity::class, OrderUpdateToHiddenResponse::class, $orderEntity);
    }

    public function checkWhetherCaptainReceivedOrderForSpecificStore(int $captainId, int $storeId, int|null $primaryOrderId): int
    {
        $orderEntity = $this->orderManager->checkWhetherCaptainReceivedOrderForSpecificStore($captainId, $storeId);
        if (!empty($orderEntity)) {
            //if the order not main
            if ($orderEntity->getOrderIsMain() !== true) {
                return OrderResultConstant::CAPTAIN_RECEIVED_ORDER_FOR_THIS_STORE_INT;
            }
            //if the order main and (request order) related
            if ($primaryOrderId === $orderEntity->getId()) {

                return OrderResultConstant::CAPTAIN_NOT_RECEIVED_ORDER_FOR_THIS_STORE_INT;
            }
            //if the order main and (request order) not related
            return OrderResultConstant::CAPTAIN_RECEIVED_ORDER_FOR_THIS_STORE_INT;
        }

        return OrderResultConstant::CAPTAIN_NOT_RECEIVED_ORDER_FOR_THIS_STORE_INT;
    }

    public function checkIfStoreHasOrdersByStoreOwnerId(int $storeOwnerId): int
    {
        $orders = $this->orderManager->getStoreOrdersByStoreOwnerId($storeOwnerId);

        if (! empty($orders)) {
            return EraserResultConstant::STORE_HAS_ORDERS;
        }

        return EraserResultConstant::STORE_HAS_NOT_ORDERS;
    }

    public function updateIsCashPaymentConfirmedByStore(OrderUpdateIsCashPaymentConfirmedByStoreRequest $request): ?OrderUpdateIsCashPaymentConfirmedByStoreResponse
    {
        $order = $this->orderManager->updateIsCashPaymentConfirmedByStore($request);

        if ($order) {
            // create order log in order time line
            $this->orderTimeLineService->createOrderLogsRequest($order);

            // save log of the action on order
            $this->orderLogService->createOrderLogMessage($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                OrderLogActionTypeConstant::CONFIRM_CAPTAIN_PAID_TO_PROVIDER_BY_STORE_ACTION_CONST, [], null,
                null);

            // send firebase notification to admin if the captain’s answer differs from that of the store, regarding the field (paidToProvider and isCashPaymentConfirmedByStore)
            if ($order->getIsCashPaymentConfirmedByStore() !== $order->getPaidToProvider()) {

                $this->notificationFirebaseService->notificationToAdmin($order->getId(), NotificationFirebaseConstant::CAPTAIN_ANSWER_DIFFERS_FROM_THAT_OF_STORE);
            }
        }

        return $this->autoMapping->map(OrderEntity::class, OrderUpdateIsCashPaymentConfirmedByStoreResponse::class, $order);
    }

    public function getStoreOrdersWhichTakenByUniqueCaptainsAfterSpecificDate(StoreOwnerProfileEntity $storeOwnerProfileEntity, $specificDateTime): array
    {
        return $this->orderManager->getStoreOrdersWhichTakenByUniqueCaptainsAfterSpecificDate($storeOwnerProfileEntity,
            $specificDateTime);
    }

    public function calculateCostDeliveryOrder(CalculateCostDeliveryOrderRequest $request): CalculateCostDeliveryOrderResponse
    {
        return $this->subscriptionService->calculateCostDeliveryOrder($request);
    }

    // filter Cash Orders which are not being answered by the store (paid or not paid) (for store)
    public function filterCashOrdersPaidOrNotByStore(CashOrdersPaidOrNotFilterByStoreRequest $request): array
    {
        $response = [];

        $orders = $this->orderManager->filterCashOrdersPaidOrNotByStore($request);

        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map("array", CashOrdersPaidOrNotFilterByStoreResponse::class, $order);
        }

        return $response;
    }

    public function checkIfReceiverLocationIsValid(int $orderId, array $destination, ?float $storeBranchToClientDistance): void
    {
        if (count($destination) > 0) {
            if (((! $destination['lat']) || (! $destination['lon'])) && (! $storeBranchToClientDistance)) {
                // there is no lat or lon, so the location is not a valid one, send a firebase notification to admin
                try {
                    $this->notificationFirebaseService->notificationToAdmin($orderId,
                        NotificationFirebaseConstant::NOT_VALID_RECEIVER_LOCATION_OF_ORDER_CONST);

                } catch (\Exception $e) {
                    error_log($e);
                }
            }
        }
    }

    public function sendFirebaseNotificationToAdminAboutOrder(int $orderId, string $text)
    {
        try {
            $this->notificationFirebaseService->notificationToAdmin($orderId, $text);

        } catch (\Exception $exception) {
            error_log($exception);
        }
    }

    public function getOrderLogCreatedAtByOrderIdAndTypeAndActionAndCreatedByUserType(int $orderId, int $orderType, int $actions, int $createdByUserType): \DateTimeInterface|int
    {
        return $this->orderLogGetService->getLastStateCreatedAtOrderLogByOrderIdAndTypeAndActionAndCreatedByUserType($orderId,
            $orderType, $actions, $createdByUserType);
    }

    public function checkIfDifferenceBetweenDateTimeInterfaceAndDateTimeIsMoreThanSpecificMinutes(\DateTimeInterface $oldDate, DateTime $newDate, int $minuets): bool
    {
        return $this->dateFactoryService->checkIfDifferenceBetweenDateTimeInterfaceAndDateTimeIsMoreThanSpecificMinutes($oldDate,
            $newDate, $minuets);
    }

    public function checkIfNormalOrderStateUpdateBeforeSpecificTimeForCaptain(int $orderId, int $captainUserId, string $nextOrderState): bool|int
    {
        // Get the creation time of the record of last order state
        $createdAtResult = $this->getOrderLogCreatedAtByOrderIdAndTypeAndActionAndCreatedByUserType($orderId, OrderTypeConstant::ORDER_TYPE_NORMAL,
            OrderLogActionTypeConstant::UPDATE_ORDER_STATE_BY_CAPTAIN_ACTION_CONST, OrderLogCreatedByUserTypeConstant::CAPTAIN_USER_TYPE_CONST);

        if ($createdAtResult === OrderLogResultConstant::ORDER_LOG_NOT_EXIST_CONST) {
            return OrderLogResultConstant::ORDER_LOG_NOT_EXIST_CONST;
        }

        // Check date according to order state
        if ($nextOrderState === OrderStateConstant::ORDER_STATE_IN_STORE) {
            $overdueTime = $this->checkIfDifferenceBetweenDateTimeInterfaceAndDateTimeIsMoreThanSpecificMinutes($createdAtResult,
                new DateTime('now'), OrderUpdateStateConstant::TWO_MINUETS_TIME_CONST);

        } else {
            $overdueTime = $this->checkIfDifferenceBetweenDateTimeInterfaceAndDateTimeIsMoreThanSpecificMinutes($createdAtResult,
                new DateTime('now'), OrderUpdateStateConstant::ONE_MINUETS_TIME_CONST);
        }

        if ($overdueTime === true) {
            // 1. Send firebase notification to admin
            $this->sendFirebaseNotificationToAdminAboutOrderAndCaptain($orderId,
                NotificationFirebaseConstant::THE_CAPTAIN.
                $this->getCaptainNameByCaptainUserId($captainUserId).
                NotificationFirebaseConstant::ORDER_UPDATE_STATE_BEFORE_TIME_BY_CAPTAIN_COST);

            // 2. Stop the rested flow, and return an appropriate result
            return true;
        }

        return false;
    }

    public function sendFirebaseNotificationToAdminAboutOrderAndCaptain(int $orderId, string $text)
    {
        try {
            $this->notificationFirebaseService->notificationToAdmin($orderId, $text);

        } catch (\Exception $exception) {
            error_log($exception);
        }
    }

    public function getCaptainNameByCaptainUserId(int $captainUserId): string
    {
        return $this->captainService->getCaptainNameByCaptainUserId($captainUserId);
    }

    public function getCaptainProfileIdByCaptainUserId(int $captainUserId): int|string
    {
        return $this->captainService->getCaptainProfileIdByCaptainUserId($captainUserId);
    }

    // Get the financial value that the order will add to the financial dues of the captain if he/she accept the order
    public function getSingleOrderFinancialValueByCaptainUserId(int $captainUserId, float $orderDistance = null): float
    {
        $captainProfileId = $this->getCaptainProfileIdByCaptainUserId($captainUserId);

        if ($captainProfileId === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return 0.0;
        }

        return $this->orderFinancialValueGetService->getSingleOrderFinancialValueByCaptainUserId($captainProfileId, $captainUserId, $orderDistance);
    }

    public function updateCaptainToStoreBranchDistanceByOrderId(int $orderId, float $captainToStoreBranchDistance = null): int|StoreOrderDetailsEntity
    {
        return $this->storeOrderDetailsService->updateCaptainToStoreBranchDistanceByOrderId($orderId, $captainToStoreBranchDistance);
    }

    public function getOrderEntityByOrderId(int $orderId): ?OrderEntity
    {
        return $this->orderManager->getOrderById($orderId);
    }

    public function updateStoreBranchToClientDistanceByAddNewDistance(OrderStoreBranchToClientDistanceUpdateRequest $request): OrderEntity|string
    {
        return $this->orderManager->updateStoreBranchToClientDistanceByAddNewDistance($request);
    }

    public function getStoreBranchToClientDistanceByOrderId(int $orderId): float|string
    {
        $storeBranchToClientDistance = $this->orderManager->getStoreBranchToClientDistanceByOrderId($orderId);

        if (! $storeBranchToClientDistance) {
            return 0.0;
        }

        if ($storeBranchToClientDistance === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        return $storeBranchToClientDistance;
    }

    public function getStoreOwnerProfileByOrderId(int $orderId): string|StoreOwnerProfileEntity
    {
        return $this->orderManager->getStoreOwnerProfileByOrderId($orderId);
    }

    public function updateOrderDeliveryCost(OrderDeliveryCostUpdateRequest $request): string|OrderDeliveryCostUpdateResponse
    {
        $orderDeliveryCostUpdateResult = $this->orderManager->updateOrderDeliveryCost($request);

        if ($orderDeliveryCostUpdateResult === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        return $this->autoMapping->map(OrderEntity::class, OrderDeliveryCostUpdateResponse::class, $orderDeliveryCostUpdateResult);
    }

    public function createDashboardLocalNotificationByStore(string $title, array $message, int $adminUserId = null, int $orderId = null)
    {
        $this->dashboardLocalNotificationService->createOrderLogMessage($title, $message,
            DashboardLocalNotificationAppTypeConstant::STORE_APP_TYPE_CONST, $adminUserId, $orderId);
    }

    public function createDashboardLocalNotificationByCaptain(string $title, array $message, int $adminUserId = null, int $orderId = null)
    {
        $this->dashboardLocalNotificationService->createOrderLogMessage($title, $message,
            DashboardLocalNotificationAppTypeConstant::CAPTAIN_APP_TYPE_CONST, $adminUserId, $orderId);
    }

    /**
     * Creates or Updates Daily Financial amount for captain
     */
    public function createOrUpdateCaptainFinancialDaily(int $orderId, CaptainEntity $captainEntity = null)
    {
        $this->captainFinancialDailyService->createOrUpdateCaptainFinancialDaily($orderId, $captainEntity);
    }

    /**
     * returns true if cash order cost had not been paid to store, and returns false otherwise
     */
    public function checkCashOrderCostPaidToStoreOrNotByOrderEntity(OrderEntity $orderEntity): bool
    {
        if ($orderEntity->getPayment() === PaymentConstant::CASH_PAYMENT_METHOD_CONST) {
            // payment method is of type cash, so continue checking process
            if (! $orderEntity->getCostType()) {
                // cost type is not defined
                if ($orderEntity->getHasPayConflictAnswers()) {
                    // it had been set if there conflicted answers or not
                    if ($orderEntity->getHasPayConflictAnswers() === OrderHasPayConflictAnswersConstant::ORDER_DOES_NOT_HAVE_PAYMENT_CONFLICT_ANSWERS) {
                        // both store and captain answers are matched, check any one of them
                        if ($orderEntity->getPaidToProvider() === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                            return true;
                        }
                    }

                } elseif (! $orderEntity->getHasPayConflictAnswers()) {
                    // till here means the store has not confirmed the cash payment yet
                    if ($orderEntity->getPaidToProvider() === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                        return true;
                    }
                }

            } elseif ($orderEntity->getCostType()) {
                // check cost type
                if ($orderEntity->getCostType() === OrderCostTypeConstant::ORDER_COST_TYPE_DELIVERY_COST_ONLY_CONST) {
                    // the cost is delivery cost only, no need to create
                    return false;

                } elseif ($orderEntity->getCostType() === OrderCostTypeConstant::ORDER_COST_TYPE_DELIVERY_COST_AND_ORDER_COST_CONST) {
                    if ($orderEntity->getHasPayConflictAnswers()) {
                        // it had been set if there conflicted answers or not
                        if ($orderEntity->getHasPayConflictAnswers() === OrderHasPayConflictAnswersConstant::ORDER_DOES_NOT_HAVE_PAYMENT_CONFLICT_ANSWERS) {
                            // both store and captain answers are matched, check any one of them
                            if ($orderEntity->getPaidToProvider() === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                                return true;
                            }
                        }

                    } elseif (! $orderEntity->getHasPayConflictAnswers()) {
                        // till here means the store has not confirmed the cash payment yet
                        if ($orderEntity->getPaidToProvider() === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                            return true;
                        }
                    }
                }
            }
        }

        return false;
    }

    /**
     * Note: factor is the parameter that we want to subtract/add from/to remaining cars field
     */
    public function updateRemainingOrdersOfStoreSubscription(int $storeOwnerProfileId, DateTimeInterface $orderCreationDate, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        return $this->subscriptionService->handleUpdatingRemainingOrdersOfStoreSubscription($storeOwnerProfileId, $orderCreationDate,
            $operationType, $factor);
    }

    /**
     * Note: factor is the parameter that we want to subtract/add from/to remaining cars field
     */
    public function updateRemainingCarsOfStoreSubscription(int $storeOwnerProfileId, DateTimeInterface $orderCreationDate, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        return $this->subscriptionService->handleUpdatingRemainingCarsOfStoreSubscriptionViaStoreOwnerProfileIdAndOrderCreationDate($storeOwnerProfileId,
            $orderCreationDate, $operationType, $factor);
    }

    public function createOrderLogViaOrderEntity(OrderEntity $orderEntity): OrderLogsResponse
    {
        return $this->orderTimeLineService->createOrderLogsRequest($orderEntity);
    }

    public function createOrderLogMessageViaOrderEntityAndByStoreOwner(OrderEntity $orderEntity, int $userId, int $action)
    {
        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($orderEntity, $userId, OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
            $action, [], null, null);
    }

    public function createLocalNotificationForStore(int $storeOwnerUserId, string $title, string $text, int $orderId)
    {
        $this->notificationLocalService->createNotificationLocal($storeOwnerUserId, $title, $text,
            NotificationTokenConstant::APP_TYPE_STORE, $orderId);
    }

    public function createLocalNotificationForCaptain(int $captainUserId, string $title, string $text, int $orderId)
    {
        $this->notificationLocalService->createNotificationLocal($captainUserId, $title, $text,
            NotificationTokenConstant::APP_TYPE_CAPTAIN, $orderId);
    }

    public function sendFirebaseNotificationAboutOrderStateForUser(int $userId, int $orderId, string $orderState, string $userType)
    {
        try {
            $this->notificationFirebaseService->notificationOrderStateForUser($userId, $orderId, $orderState, $userType);

        } catch (\Exception $exception) {
            error_log($exception);
        }
    }

    public function deleteChatRoomByOrderId(int $orderId): void
    {
        $this->orderChatRoomService->deleteChatRoomByOrderId($orderId);
    }

    public function createOrUpdateCaptainFinancialDue(int $captainUserId, int $orderId = null, DateTimeInterface $orderCreatedAt = null)
    {
        $this->captainFinancialDuesService->captainFinancialDues($captainUserId, $orderId, $orderCreatedAt);
    }

    /**
     * Updates an (ongoing) order to 'pending' state
     */
    public function updateOrderStateToPendingByOrderEntity(OrderEntity $orderEntity): array
    {
        return $this->orderManager->updateOrderStateToPendingByOrderEntity($orderEntity);
    }

    /**
     * Deletes the chat room of the order which being created when order had been accepted by the captain
     */
    public function deleteChatRoomByOrderIdAndCaptainProfileId(int $orderId, int $captainProfileId): ?OrderChatRoomEntity
    {
        return $this->orderChatRoomService->deleteChatRoomByOrderIdAndCaptainId($orderId, $captainProfileId);
    }

    /**
     * save log of the action on order which done by the captain
     */
    public function createOrderLogMessageViaOrderEntityAndByCaptain(OrderEntity $orderEntity, int $userId, int $action)
    {
        $this->orderLogService->createOrderLogMessage($orderEntity, $userId, OrderLogCreatedByUserTypeConstant::CAPTAIN_USER_TYPE_CONST,
            $action, [], null, null);
    }

    /**
     * Un accept order by captain by returning it to the pending state
     */
    public function rePendingOrderByCaptain(RePendingAcceptedOrderByCaptainRequest $request): string|int|RePendingOrderByCaptainResponse
    {
        $orderEntity = $this->getOrderEntityByOrderId($request->getId());

        if (! $orderEntity) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        if ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_DELIVERED) {
            return OrderResultConstant::ORDER_IS_BEING_DELIVERED;

        } elseif ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_CANCEL) {
            return OrderResultConstant::ORDER_ALREADY_BEING_CANCELLED;

        } elseif ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_PENDING) {
            return OrderResultConstant::ORDER_STATE_PENDING_CONST;

        } elseif (in_array($orderEntity->getState(), OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY)) {
            // start transaction commit ...
            $this->entityManager->getConnection()->beginTransaction();

            try {
                // 1. Update order state and other fields
                $orderUpdateResultArray = $this->updateOrderStateToPendingByOrderEntity($orderEntity);

                if ($orderUpdateResultArray[0]) {
                    // 2. Delete chat room
                    $this->deleteChatRoomByOrderIdAndCaptainProfileId($orderUpdateResultArray[0]->getId(), $orderUpdateResultArray[1]->getId());

                    // 3. Update remaining cars of the current subscription of the store
                    $this->updateRemainingCarsOfStoreSubscription($orderUpdateResultArray[0]->getStoreOwner()->getId(),
                        $orderUpdateResultArray[0]->getCreatedAt(), SubscriptionConstant::OPERATION_TYPE_ADDITION,
                        SubscriptionDetailsConstant::ONE_VALUE_CONST);

                    // 4. Create order log
                    // 4.1 create order log record
                    $this->createOrderLogMessageViaOrderEntityAndByCaptain($orderUpdateResultArray[0], $orderUpdateResultArray[1]->getCaptainId(),
                        OrderLogActionTypeConstant::UN_ASSIGN_ORDER_TO_CAPTAIN_BY_CAPTAIN_ACTION_CONST);

                    // 4.2 create order timeline record
                    $this->createOrderLogViaOrderEntity($orderUpdateResultArray[0]);

                    // 5. Create notifications
                    // Local notifications
                    // for store
                    $this->createLocalNotificationForStore($orderUpdateResultArray[0]->getStoreOwner()->getStoreOwnerId(),
                        NotificationConstant::UN_ACCEPT_ORDER_BY_CAPTAIN_TITLE_CONST, NotificationConstant::ORDER_RETURNED_PENDING_BY_CAPTAIN_TEXT,
                        $orderUpdateResultArray[0]->getId());

                    // for captain
                    $this->createLocalNotificationForCaptain($orderUpdateResultArray[1]->getCaptainId(), NotificationConstant::UN_ACCEPT_ORDER_BY_CAPTAIN_TITLE_CONST,
                        NotificationConstant::UN_ACCEPT_ORDER_BY_CAPTAIN_TEXT_CONST, $orderUpdateResultArray[0]->getId());

                    // for dashboard
                    $this->createDashboardLocalNotificationByCaptain(DashboardLocalNotificationTitleConstant::UN_ACCEPT_ORDER_BY_CAPTAIN_TITLE_CONST,
                        ["text" => DashboardLocalNotificationMessageConstant::UN_ACCEPT_ORDER_BY_CAPTAIN_TEXT_CONST . $orderUpdateResultArray[0]->getId()],
                        null, $orderUpdateResultArray[0]->getId());

                    // ... commit the transaction
                    $this->entityManager->getConnection()->commit();

                    // Firebase notifications
                    // for store
                    $this->sendFirebaseNotificationAboutOrderStateForUser($orderUpdateResultArray[0]->getStoreOwner()->getStoreOwnerId(),
                        $orderUpdateResultArray[0]->getId(), $orderUpdateResultArray[0]->getState(), NotificationConstant::STORE);

                    // for captain
                    $this->sendFirebaseNotificationAboutOrderStateForUser($orderUpdateResultArray[1]->getCaptainId(),
                        $orderUpdateResultArray[0]->getId(), $orderUpdateResultArray[0]->getState(), NotificationConstant::CAPTAIN);

                    // for dashboard
                    $this->sendFirebaseNotificationToAdminAboutOrder($orderUpdateResultArray[0]->getId(),
                        NotificationFirebaseConstant::UN_ACCEPT_ORDER_BY_CAPTAIN_CONST);

                    return $this->autoMapping->map(OrderEntity::class, RePendingOrderByCaptainResponse::class, $orderUpdateResultArray[0]);
                }

                // rollback the started transaction
                $this->entityManager->getConnection()->rollBack();

                return OrderResultConstant::ORDER_RETURNING_TO_PENDING_HAS_PROBLEM;

            } catch (\Exception $e) {
                // rollback the started transaction
                $this->entityManager->getConnection()->rollBack();

                throw $e;
            }
        }

        return OrderResultConstant::ORDER_STATE_NOT_CORRECT_CONST;
    }

    /**
     * Creates order log message by order entity, a specific user, user type, action, and other optional parameters
     */
    public function createOrderLogMessageByOrderEntityAndUser(OrderEntity $orderEntity, int $createdByUser, int $userType, int $action, array $details, int $storeOwnerBranchId = null, int $supplierProfileId = null)
    {
        $this->orderLogService->createOrderLogMessage($orderEntity, $createdByUser, $userType, $action, $details,
            $storeOwnerBranchId, $supplierProfileId);
    }

    /**
     * Updates isHide field of the passed order
     */
    public function updateOrderIsHideByOrderEntity(OrderEntity $orderEntity, int $isHide): OrderEntity|string
    {
        $orderUpdateResult = $this->orderManager->updateIsHide($orderEntity, $isHide);

        if (! $orderUpdateResult) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        return $orderUpdateResult;
    }

    /**
     * Check ongoing orders count and package's car count and updates remaining cars field according to them and
     * according to captain offer subscription (if it is available) (and activates it)
     */
    public function checkRemainingCarsByOrderId(int $orderId): string
    {
        return $this->subscriptionService->checkRemainingCarsByOrderId($orderId);
    }

    /**
     * Get visible pending orders which aren't sub orders
     */
    public function findVisiblePendingOrders(): array
    {
        return $this->orderManager->findVisiblePendingOrders();
    }

    /**
     * Hides pending orders if the remaining cars of each store subscription are finished
     */
    public function hidePendingOrderIfStoreSubscriptionRemainingCarsAreFinished(int $userId, int $userType): array
    {
        //Get pending orders which aren't hidden nor sub orders
        $pendingOrders = $this->findVisiblePendingOrders();

        if (count($pendingOrders) > 0) {
            foreach ($pendingOrders as $pendingOrder) {
                // Check if remaining cars of the subscription of the store of the order are finished or not
                $checkStoreSubscriptionResult = $this->checkRemainingCarsByOrderId($pendingOrder->getId());

                if ($checkStoreSubscriptionResult === SubscriptionConstant::CARS_FINISHED) {
                    // start transaction commit ...
                    $this->entityManager->getConnection()->beginTransaction();

                    try {
                        // While remaining cars are finished, do the following
                        // 1. update isHide field of the order
                        $orderUpdateResult = $this->updateOrderIsHideByOrderEntity($pendingOrder, OrderIsHideConstant::ORDER_HIDE_TEMPORARILY);

                        if ($orderUpdateResult !== OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
                            // 2. create order log
                            // 4.1 create order log record
                            $this->createOrderLogMessageByOrderEntityAndUser($pendingOrder, $userId, $userType,
                                OrderLogActionTypeConstant::HIDE_ORDER_DUE_TO_UNAVAILABLE_CARS, [], null, null);

                            // 4.2 create order timeline record
                            $this->createOrderLogViaOrderEntity($pendingOrder);

                            // 3. create notification to the store
                            // Local notifications
                            $this->createNotificationLocalForOrderState($pendingOrder->getStoreOwner()->getStoreOwnerId(),
                                NotificationConstant::HIDE_ORDER_DUE_TO_UNAVAILABLE_CARS_TITLE_CONST, $pendingOrder->getState(),
                                NotificationConstant::STORE, $pendingOrder->getId());

                            // ... commit the transaction
                            $this->entityManager->getConnection()->commit();

                            // Firebase notifications
                            $this->sendFirebaseNotificationAboutOrderStateForUser($pendingOrder->getStoreOwner()->getStoreOwnerId(),
                                $pendingOrder->getId(), $pendingOrder->getState(), NotificationConstant::STORE);
                        }

                    } catch (\Exception $e) {
                        // rollback the started transaction
                        $this->entityManager->getConnection()->rollBack();

                        throw $e;
                    }
                }
            }
        }

        return $pendingOrders;
    }

    /**
     * Creates local notification for specific user who defined by userId, and includes order state within the notification
     */
    public function createNotificationLocalForOrderState(int $userId, string $title, string $state, string $userType, int $orderId = null, int $captainProfileId = null)
    {
        $this->notificationLocalService->createNotificationLocalForOrderState($userId, $title, $state, $userType,
            $orderId, $captainProfileId);
    }

    public function getStoreOrderDetailsEntityByOrderId(int $orderId): ?StoreOrderDetailsEntity
    {
        return $this->storeOrderDetailsService->getStoreOrderDetailsEntityByOrderId($orderId);
    }

    public function sendOrderToExternalDeliveryCompany(OrderEntity $orderEntity): ExternallyDeliveredOrderEntity|int
    {
        $storeOrderDetailsEntity = $this->getStoreOrderDetailsEntityByOrderId($orderEntity->getId());

        return $this->externallyDeliveredOrderHandleService->handleSendingOrderToExternalDeliveryCompany($orderEntity,
            $storeOrderDetailsEntity);
    }
}
