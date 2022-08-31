<?php

namespace App\Service\Order;

use App\AutoMapping;
use App\Constant\Eraser\EraserResultConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Constant\OrderLog\OrderLogActionTypeConstant;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Constant\PriceOffer\PriceOfferStatusConstant;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Entity\BidDetailsEntity;
use App\Entity\OrderEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Manager\Order\OrderManager;
use App\Request\Order\BidOrderFilterBySupplierRequest;
use App\Request\Order\BidDetailsCreateRequest;
use App\Request\Order\CashOrdersPaidOrNotFilterByStoreRequest;
use App\Request\Order\OrderFilterByCaptainRequest;
use App\Request\Order\OrderFilterRequest;
use App\Request\Order\OrderCreateRequest;
use App\Request\Order\OrderUpdateByCaptainRequest;
use App\Response\BidDetails\BidDetailsGetForCaptainResponse;
use App\Response\Order\BidOrderByIdGetForCaptainResponse;
use App\Response\Order\BidOrderForStoreOwnerGetResponse;
use App\Response\Order\CashOrdersPaidOrNotFilterByStoreResponse;
use App\Response\Order\FilterBidOrderByStoreOwnerResponse;
use App\Response\Order\OrderByIdForSupplierGetResponse;
use App\Response\Order\BidOrderFilterBySupplierResponse;
use App\Response\Order\FilterOrdersByCaptainResponse;
use App\Response\Order\OrderResponse;
use App\Response\Order\OrdersResponse;
use App\Response\Order\OrderClosestResponse;
use App\Response\Order\OrderUpdateByCaptainResponse;
use App\Response\Subscription\CanCreateOrderResponse;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Subscription\SubscriptionConstant;
use App\Service\OrderLog\OrderLogToMySqlService;
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
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Constant\Order\OrderAmountCashConstant;
use App\Request\Subscription\CalculateCostDeliveryOrderRequest;
use App\Response\Subscription\CalculateCostDeliveryOrderResponse;

class OrderService
{
    private AutoMapping $autoMapping;
    private OrderManager $orderManager;
    private SubscriptionService $subscriptionService;
    private NotificationLocalService $notificationLocalService;
    private UploadFileHelperService $uploadFileHelperService;
    private CaptainService $captainService;
    private OrderChatRoomService $orderChatRoomService;
    private OrderTimeLineService $orderTimeLineService;
    private NotificationFirebaseService $notificationFirebaseService;
    private CaptainFinancialDuesService $captainFinancialDuesService;
    private CaptainAmountFromOrderCashService $captainAmountFromOrderCashService;
    private StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService;
    private BidOrderFinancialService $bidOrderFinancialService;
    private OrderLogToMySqlService $orderLogToMySqlService;

    public function __construct(AutoMapping $autoMapping, OrderManager $orderManager, SubscriptionService $subscriptionService, NotificationLocalService $notificationLocalService, UploadFileHelperService $uploadFileHelperService,
                                CaptainService $captainService, OrderChatRoomService $orderChatRoomService, OrderTimeLineService $orderTimeLineService, NotificationFirebaseService $notificationFirebaseService,
                                CaptainFinancialDuesService $captainFinancialDuesService, CaptainAmountFromOrderCashService $captainAmountFromOrderCashService, StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService,
                                BidOrderFinancialService $bidOrderFinancialService, OrderLogToMySqlService $orderLogToMySqlService)
    {
        $this->autoMapping = $autoMapping;
        $this->orderManager = $orderManager;
        $this->subscriptionService = $subscriptionService;
        $this->notificationLocalService = $notificationLocalService;
        $this->uploadFileHelperService = $uploadFileHelperService;
        $this->captainService = $captainService;
        $this->orderChatRoomService = $orderChatRoomService;
        $this->orderTimeLineService = $orderTimeLineService;
        $this->notificationFirebaseService = $notificationFirebaseService;
        $this->captainFinancialDuesService = $captainFinancialDuesService;
        $this->captainAmountFromOrderCashService = $captainAmountFromOrderCashService;
        $this->storeOwnerDuesFromCashOrdersService = $storeOwnerDuesFromCashOrdersService;
        $this->bidOrderFinancialService = $bidOrderFinancialService;
        $this->orderLogToMySqlService = $orderLogToMySqlService;
    }

    /**
     * @param OrderCreateRequest $request
     * @return OrderResponse|CanCreateOrderResponse
     */
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

            $this->notificationLocalService->createNotificationLocal($request->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NEW_ORDER_TITLE, NotificationConstant::CREATE_ORDER_SUCCESS, $order->getId());

            $this->orderTimeLineService->createOrderLogsRequest($order);

            // save log of the action on order
            $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                OrderLogActionTypeConstant::CREATE_ORDER_BY_STORE_ACTION_CONST, null, null);
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
            $this->checkIfReceiverLocationIsValid($order->getId(), $request->getDestination());
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
                NotificationConstant::CREATE_BID_ORDER_SUCCESS, $orderAndBidDetailsEntities[0]->getId());

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

    /**
     * @param $userId
     * @return array
     */
    public function getStoreOrders(int $userId): ?array
    {
        $response = [];

        $this->showSubOrderIfCarIsAvailable($userId, OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST);

        $this->hideOrderExceededDeliveryTimeByHour($userId, OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST);

        $orders = $this->orderManager->getStoreOrders($userId);

        foreach ($orders as $order) {

            $order['subOrder'] = $this->orderManager->getSubOrdersByPrimaryOrderIdForStore($order['id']);

            $response[] = $this->autoMapping->map("array", OrdersResponse::class, $order);
        }

        return $response;
    }

    /**
     * @param $id
     * @return OrdersResponse
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

            $order['orderLogs'] = $this->orderTimeLineService->getOrderLogsByOrderId($id);

            $order['captain'] = null;

            if ($order['captainUserId']) {
                $order['captain'] = $this->captainService->getCaptain($order['captainUserId']);
            }

            $order['subOrder'] = $this->orderManager->getSubOrdersByPrimaryOrderIdForStore($order['id']);
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

        $response = [];
        //get closest orders half an hour in advance
        $date = date_modify(new DateTime('now'), '+30 minutes');

        $orders = $this->orderManager->closestOrders($userId, $date);

        foreach ($orders as $key => $value) {

            $value['subOrder'] = $this->orderManager->getSubOrdersByPrimaryOrderId($value['id']);

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
            }

            if ($order->getState() === OrderStateConstant::ORDER_STATE_DELIVERED) {

                $this->captainFinancialDuesService->captainFinancialDues($request->getCaptainId()->getCaptainId());

                //Save the price of the order in cash in case the captain does not pay the store
                if ($order->getPayment() === OrderTypeConstant::ORDER_PAYMENT_CASH && $order->getPaidToProvider() === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                    $this->captainAmountFromOrderCashService->createCaptainAmountFromOrderCash($order, OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO, $order->getOrderCost());
                    $this->storeOwnerDuesFromCashOrdersService->createStoreOwnerDuesFromCashOrders($order, OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO, $order->getOrderCost());
                }
            }

            // save log of the action on order
            $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $request->getCaptainId()->getCaptainId(), OrderLogCreatedByUserTypeConstant::CAPTAIN_USER_TYPE_CONST,
                OrderLogActionTypeConstant::UPDATE_ORDER_STATE_BY_CAPTAIN_ACTION_CONST, null, null);

            //create Notification Local for store
            $this->notificationLocalService->createNotificationLocalForOrderState($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::STATE_TITLE, $order->getState(), $order->getId(), NotificationConstant::STORE, $order->getCaptainId()->getId());
            //create Notification Local for captain
            $this->notificationLocalService->createNotificationLocalForOrderState($order->getCaptainId()->getCaptainId(), NotificationConstant::STATE_TITLE, $order->getState(), $order->getId(), NotificationConstant::CAPTAIN);

            if ($order->getOrderType() === OrderTypeConstant::ORDER_TYPE_BID) {
                //create Notification Local for supplier
                $this->notificationLocalService->createNotificationLocalForOrderState($order->getBidDetailsEntity()->getSupplierProfile()->getUser()->getId(), NotificationConstant::STATE_TITLE, $order->getState(), $order->getId(),
                    NotificationConstant::SUPPLIER);
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
            $response->attention = OrderAttentionConstant::ATTENTION;

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
            $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                OrderLogActionTypeConstant::CONFIRM_CAPTAIN_ARRIVAL_BY_STORE_ACTION_CONST, null, null);

            // send firebase notification to admin if isCaptainArrived = false
            if ($order->getIsCaptainArrived() === false) {
                $this->notificationFirebaseService->notificationCaptainNotArrivedStoreToAdmin($order->getId());
            }
        }

        return $this->autoMapping->map(OrderEntity::class, OrderUpdateCaptainArrivedResponse::class, $order);
    }

    public function orderCancel(int $id): string|OrderCancelResponse|null
    {
        $order = $this->orderManager->getOrderById($id);

        // if order of type bid, then use another api in order to cancel it
        if ($order->getOrderType() === OrderTypeConstant::ORDER_TYPE_BID) {
            return OrderResultConstant::ORDER_TYPE_BID;
        }

        if ($order) {
            $halfHourLaterTime = date_modify($order->getCreatedAt(), '+30 minutes');

            $nowDate = new DateTime('now');

            if ($halfHourLaterTime < $nowDate) {
                //create local notification to store
                $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::CANCEL_ORDER_TITLE, NotificationConstant::CANCEL_ORDER_ERROR_TIME, $order->getId());

                //create firebase notification to store
                try {
                    $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), NotificationConstant::CANCEL_ORDER_ERROR_TIME, NotificationConstant::STORE);
                } catch (\Exception $e) {
                    error_log($e);
                }

                $order->statusError = OrderResultConstant::ORDER_NOT_REMOVE_TIME;

                return $this->autoMapping->map(OrderEntity::class, OrderCancelResponse::class, $order);
            } elseif ($order->getState() != OrderStateConstant::ORDER_STATE_PENDING) {

                //create local notification to store
                $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::CANCEL_ORDER_TITLE, NotificationConstant::CANCEL_ORDER_ERROR_ACCEPTED, $order->getId());

                //create firebase notification to store
                try {
                    $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), NotificationConstant::CANCEL_ORDER_ERROR_ACCEPTED, NotificationConstant::STORE);
                } catch (\Exception $e) {
                    error_log($e);
                }

                $order->statusError = OrderResultConstant::ORDER_NOT_REMOVE_CAPTAIN_RECEIVED;

                return $this->autoMapping->map(OrderEntity::class, OrderCancelResponse::class, $order);
            }

            $order = $this->orderManager->orderCancel($order);

            if ($order) {

                $this->orderTimeLineService->createOrderLogsRequest($order);

                // save log of the action on order
                $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::CANCEL_ORDER_BY_STORE_ACTION_CONST, null, null);

                //create local notification to store
                $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::CANCEL_ORDER_TITLE, NotificationConstant::CANCEL_ORDER_SUCCESS, $order->getId());

                //create firebase notification to store
                try {
                    $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), NotificationConstant::CANCEL_ORDER_SUCCESS, NotificationConstant::STORE);
                } catch (\Exception $e) {
                    error_log($e);
                }

                $this->subscriptionService->updateRemainingOrders($order->getStoreOwner()->getStoreOwnerId(), SubscriptionConstant::OPERATION_TYPE_ADDITION);
            }
        }

        return $this->autoMapping->map(OrderEntity::class, OrderCancelResponse::class, $order);
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

    public function getCountOrdersByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): array
    {
        return $this->orderManager->getCountOrdersByFinancialSystemThree($captainId, $fromDate, $toDate, $countKilometersFrom, $countKilometersTo);
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

    //Hide the order that exceeded the delivery time by an hour
    public function hideOrderExceededDeliveryTimeByHour(int $userId, int $userType)
    {
        //get orders pending and  not hidden due to exceeding delivery time
        $pendingOrders = $this->orderManager->getOrdersPending();
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
                    $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $userId, $userType,
                        OrderLogActionTypeConstant::HIDE_ORDER_EXCEEDED_DELIVERY_TIME_ACTION_CONST, null, null);

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
        $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $userId, OrderLogCreatedByUserTypeConstant::CAPTAIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::UPDATE_PAID_TO_PROVIDER_BY_CAPTAIN_ACTION_CONST, null, null);

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
            $this->notificationLocalService->createNotificationLocal($request->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NEW_SUB_ORDER_TITLE, NotificationConstant::CREATE_SUB_ORDER_SUCCESS, $order->getId());
            if ($primaryOrder->getCaptainId()) {
                //notification to captain
                $this->notificationLocalService->createNotificationLocal($primaryOrder->getCaptainId()->getCaptainId(), NotificationConstant::NEW_SUB_ORDER_TITLE, NotificationConstant::ADD_SUB_ORDER, $request->getPrimaryOrder()->getId());
            }

            $this->orderTimeLineService->createOrderLogsRequest($order);

            // save log of the action on order
            $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                OrderLogActionTypeConstant::CREATE_SUB_ORDER_BY_STORE_ACTION_CONST, null, null);

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

    public function orderNonSub(int $orderId, $userId): ?OrderUpdatePaidToProviderResponse
    {
        $checkRemainingCars = $this->subscriptionService->checkRemainingCarsByOrderId($orderId);

        $isHide = OrderIsHideConstant::ORDER_SHOW;

        if ($checkRemainingCars === SubscriptionConstant::CARS_FINISHED) {
            $isHide = OrderIsHideConstant::ORDER_HIDE_TEMPORARILY;
        }

        $order = $this->orderManager->updateIsHideByOrderId($orderId, $isHide);

        // save log of the action on order
        $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $userId, OrderLogCreatedByUserTypeConstant::CAPTAIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::UN_LINK_SUB_ORDER_BY_CAPTAIN_ACTION_CONST, null, null);

        //notification to store
        $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NON_SUB_ORDER_TITLE, NotificationConstant::NON_SUB_ORDER_BY_CAPTAIN, $order->getId());
        if ($isHide === OrderIsHideConstant::ORDER_HIDE_TEMPORARILY) {
            $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::SUB_ORDER_ATTENTION, NotificationConstant::SUB_ORDER_HIDE_TEMPORARILY, $order->getId());
        }

        //notification to captain
        $this->notificationLocalService->createNotificationLocal($userId, NotificationConstant::NON_SUB_ORDER_TITLE, NotificationConstant::NON_SUB_ORDER, $order->getId());

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

    public function isHideShow()
    {
        $order = $this->orderManager->isHideShow();

        return $this->autoMapping->map(OrderEntity::class, OrderUpdatePaidToProviderResponse::class, $order);
    }

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
                $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $userId, $userType, OrderLogActionTypeConstant::SHOW_SUB_ORDER_IF_CAR_AVAILABLE_ACTION_CONST,
                    null, null);

                //notification to store
                $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::SUB_ORDER_ATTENTION, NotificationConstant::SUB_ORDER_SHOW, $order->getId());
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
                    $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                        OrderLogActionTypeConstant::CANCEL_ORDER_BY_STORE_ACTION_CONST, null, null);

                    //create local notification to store
                    $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::CANCEL_ORDER_TITLE, NotificationConstant::CANCEL_ORDER_SUCCESS, $order->getId());

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
                $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::RECYCLE_ORDER_BY_STORE_ACTION_CONST, null, null);

                $this->notificationLocalService->createNotificationLocal($orderEntity->getStoreOwner()->getStoreOwnerId(), NotificationConstant::RECYCLING_ORDER_TITLE, NotificationConstant::RECYCLING_ORDER_SUCCESS, $order->getId());

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
        $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
            OrderLogActionTypeConstant::UN_LINK_SUB_ORDER_BY_STORE_ACTION_CONST, null, null);

        //notification to store
        $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NON_SUB_ORDER_TITLE, NotificationConstant::NON_SUB_ORDER, $order->getId());

        if ($isHide === OrderIsHideConstant::ORDER_HIDE_TEMPORARILY) {
            $this->notificationLocalService->createNotificationLocal($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::SUB_ORDER_ATTENTION, NotificationConstant::SUB_ORDER_HIDE_TEMPORARILY, $order->getId());
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

            $order = $this->orderManager->orderUpdate($request, $order);

            if ($order) {

                // save log of the action on order
                $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::UPDATE_ORDER_BY_STORE_ACTION_CONST, null, null);

                if ($order->getCaptainId()) {
                    // create firebase notification to captain
                    try {
                        $this->notificationFirebaseService->notificationToUser($order->getCaptainId()->getCaptainId(), $order->getId(), NotificationFirebaseConstant::ORDER_UPDATE_BY_STORE);
                    } catch (\Exception $e) {
                        error_log($e);
                    }
                }
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
        $this->orderLogToMySqlService->initializeCreateOrderLogRequest($orderEntity, $orderEntity->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
            OrderLogActionTypeConstant::HIDE_ORDER_WHILE_UPDATING_BY_STORE_ACTION_CONST, null, null);

        return $this->autoMapping->map(OrderEntity::class, OrderUpdateToHiddenResponse::class, $orderEntity);
    }

//    public function checkWhetherCaptainReceivedOrderForSpecificStore(int $captainId, int $storeId, int|null $primaryOrderId): int
//    {
//        $orderEntity = $this->orderManager->checkWhetherCaptainReceivedOrderForSpecificStore($captainId, $storeId);
//        if (!empty($orderEntity)) {
//            //if the order not main
//            if ($orderEntity->getOrderIsMain() !== true) {
//                return OrderResultConstant::CAPTAIN_RECEIVED_ORDER_FOR_THIS_STORE_INT;
//            }
//            //if the order main and (request order) related
//        }
//    }

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
            $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $order->getStoreOwner()->getStoreOwnerId(), OrderLogCreatedByUserTypeConstant::STORE_OWNER_USER_TYPE_CONST,
                OrderLogActionTypeConstant::CONFIRM_CAPTAIN_PAID_TO_PROVIDER_BY_STORE_ACTION_CONST, null, null);

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

    public function checkIfReceiverLocationIsValid(int $orderId, array $destination): void
    {
        if (count($destination) > 0) {
            if ((! $destination['lat']) || (! $destination['lon'])) {
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
}
