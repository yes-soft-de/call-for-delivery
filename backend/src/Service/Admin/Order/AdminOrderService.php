<?php

namespace App\Service\Admin\Order;

use App\AutoMapping;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Notification\NotificationTokenConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Constant\OrderLog\OrderLogActionTypeConstant;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Constant\Subscription\SubscriptionConstant;
use App\Entity\BidDetailsEntity;
use App\Entity\OrderEntity;
use App\Manager\Admin\Order\AdminOrderManager;
use App\Request\Admin\Order\CaptainNotArrivedOrderFilterByAdminRequest;
use App\Request\Admin\Order\FilterDifferentlyAnsweredCashOrdersByAdminRequest;
use App\Request\Admin\Order\OrderCreateByAdminRequest;
use App\Request\Admin\Order\OrderFilterByAdminRequest;
use App\Request\Admin\Order\OrderHasPayConflictAnswersUpdateByAdminRequest;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceAdditionByAdminRequest;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceUpdateByAddAdditionalDistanceByAdminRequest;
use App\Request\Admin\Order\RePendingAcceptedOrderByAdminRequest;
use App\Request\Admin\Order\SubOrderCreateByAdminRequest;
use App\Response\Admin\Order\BidDetailsGetForAdminResponse;
use App\Response\Admin\Order\BidOrderGetForAdminResponse;
use App\Response\Admin\Order\CaptainNotArrivedOrderFilterResponse;
use App\Response\Admin\Order\FilterDifferentlyAnsweredCashOrdersByAdminResponse;
use App\Response\Admin\Order\OrderByIdGetForAdminResponse;
use App\Response\Admin\Order\OrderCancelByAdminResponse;
use App\Response\Admin\Order\OrderCreateByAdminResponse;
use App\Response\Admin\Order\OrderDestinationUpdateByAdminResponse;
use App\Response\Admin\Order\OrderGetForAdminResponse;
use App\Response\Admin\Order\OrderHasPayConflictAnswersUpdateByAdminResponse;
use App\Response\Admin\Order\OrderStateUpdateByAdminResponse;
use App\Response\Admin\Order\OrderStoreBranchToClientDistanceUpdateByAdminResponse;
use App\Response\Admin\Order\OrderStoreToBranchDistanceAndDestinationUpdateByAdminResponse;
use App\Response\Admin\Order\OrderUpdateByAdminResponse;
use App\Response\GeoDistance\GeoDistanceInfoGetResponse;
use App\Response\Order\BidOrderByIdGetForAdminResponse;
use App\Response\Subscription\CanCreateOrderResponse;
use App\Service\ChatRoom\OrderChatRoomService;
use App\Service\FileUpload\UploadFileHelperService;
use App\Service\GeoDistance\GeoDistanceService;
use App\Service\Notification\NotificationFirebaseService;
use App\Service\Notification\NotificationLocalService;
use App\Service\Order\StoreOrderDetailsService;
use App\Service\OrderLog\OrderLogService;
use App\Service\OrderTimeLine\OrderTimeLineService;
use App\Response\Admin\Order\OrderPendingResponse;
use App\Service\Order\OrderService;
use DateTime;
use App\Response\Admin\Order\OrderUpdateToHiddenResponse;
use App\Request\Admin\Order\UpdateOrderByAdminRequest;
use App\Constant\Notification\NotificationFirebaseConstant;
use App\Service\StoreOwner\StoreOwnerProfileService;
use App\Service\StoreOwnerBranch\StoreOwnerBranchService;
use App\Service\Subscription\SubscriptionService;
use App\Request\Admin\Order\OrderAssignToCaptainByAdminRequest;
use App\Request\Admin\Order\OrderStateUpdateByAdminRequest;
use App\Service\CaptainFinancialSystem\CaptainFinancialDuesService;
use App\Service\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashService;
use App\Service\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersService;
use App\Service\Captain\CaptainService;
use App\Constant\Captain\CaptainConstant;
use App\Request\Admin\Order\OrderCaptainFilterByAdminRequest;
use App\Request\Admin\Order\FilterOrdersPaidOrNotPaidByAdminRequest;
use App\Response\Admin\Order\FilterOrdersPaidOrNotPaidByAdminResponse;
use App\Request\Admin\Subscription\AdminCalculateCostDeliveryOrderRequest;
use App\Response\Subscription\CalculateCostDeliveryOrderResponse;
use App\Service\Admin\StoreOwnerSubscription\AdminStoreSubscriptionService;
use App\Request\Admin\Order\FilterOrdersWhoseHasNotDistanceHasCalculatedRequest;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceByAdminRequest;
use App\Constant\GeoDistance\GeoDistanceResultConstant;
use App\Constant\Order\OrderIsHideConstant;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceAndDestinationByAdminRequest;
use App\Request\Admin\Order\OrderUpdateIsCashPaymentConfirmedByStoreByAdminRequest;
use App\Response\Admin\Order\OrderUpdateIsCashPaymentConfirmedByStoreForAdminResponse;
use Doctrine\ORM\EntityManagerInterface;

class AdminOrderService
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private AdminOrderManager $adminOrderManager;
    private UploadFileHelperService $uploadFileHelperService;
    private OrderTimeLineService $orderTimeLineService;
    private OrderService $orderService;
    private OrderChatRoomService $orderChatRoomService;
    private StoreOrderDetailsService $storeOrderDetailsService;
    private NotificationFirebaseService $notificationFirebaseService;
    private NotificationLocalService $notificationLocalService;
    private StoreOwnerProfileService $storeOwnerProfileService;
    private SubscriptionService $subscriptionService;
    private StoreOwnerBranchService $storeOwnerBranchService;
    private CaptainFinancialDuesService $captainFinancialDuesService;
    private CaptainAmountFromOrderCashService $captainAmountFromOrderCashService;
    private StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService;
    private CaptainService $captainService;
    private OrderLogService $orderLogService;
    private AdminStoreSubscriptionService $adminStoreSubscriptionService;
    private GeoDistanceService $geoDistanceService;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, AdminOrderManager $adminStoreOwnerManager, UploadFileHelperService $uploadFileHelperService, OrderTimeLineService $orderTimeLineService,
                                OrderService $orderService, OrderChatRoomService $orderChatRoomService, StoreOrderDetailsService $storeOrderDetailsService, NotificationFirebaseService $notificationFirebaseService,
                                NotificationLocalService $notificationLocalService, StoreOwnerProfileService $storeOwnerProfileService, SubscriptionService $subscriptionService,
                                StoreOwnerBranchService $storeOwnerBranchService, CaptainFinancialDuesService $captainFinancialDuesService, CaptainAmountFromOrderCashService $captainAmountFromOrderCashService,
                                StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService, CaptainService $captainService,
                                OrderLogService $orderLogService, AdminStoreSubscriptionService $adminStoreSubscriptionService, GeoDistanceService $geoDistanceService)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->adminOrderManager = $adminStoreOwnerManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
        $this->orderTimeLineService = $orderTimeLineService;
        $this->orderService = $orderService;
        $this->orderChatRoomService = $orderChatRoomService;
        $this->storeOrderDetailsService = $storeOrderDetailsService;
        $this->notificationFirebaseService = $notificationFirebaseService;
        $this->notificationLocalService = $notificationLocalService;
        $this->storeOwnerProfileService = $storeOwnerProfileService;
        $this->subscriptionService = $subscriptionService;
        $this->storeOwnerBranchService = $storeOwnerBranchService;
        $this->captainFinancialDuesService = $captainFinancialDuesService;
        $this->captainAmountFromOrderCashService = $captainAmountFromOrderCashService;
        $this->storeOwnerDuesFromCashOrdersService = $storeOwnerDuesFromCashOrdersService;
        $this->captainService = $captainService;
        $this->orderLogService = $orderLogService;
        $this->adminStoreSubscriptionService = $adminStoreSubscriptionService;
        $this->geoDistanceService = $geoDistanceService;
    }

    public function getCountOrderOngoingForAdmin(): int
    {
        return $this->adminOrderManager->getCountOrderOngoingForAdmin();
    }

    public function getAllOrdersCountForAdmin(): int
    {
        return $this->adminOrderManager->getAllOrdersCountForAdmin();
    }

    public function filterStoreOrdersByAdmin(OrderFilterByAdminRequest $request): ?array
    {
        $response = [];

        $orders = $this->adminOrderManager->filterStoreOrdersByAdmin($request);

        foreach ($orders as $order) {
            $order['images'] = $this->uploadFileHelperService->getImageParams($order['images']);

            $response[] = $this->autoMapping->map("array", OrderGetForAdminResponse::class, $order);
        }

        return $response;
    }

    public function getSpecificOrderByIdForAdmin(int $id): ?OrderByIdGetForAdminResponse
    {
        $order = $this->adminOrderManager->getSpecificOrderByIdForAdmin($id);

        if ($order) {
            $order['orderImage'] = $this->uploadFileHelperService->getImageParams($order['orderImage']);
            $order['filePdf'] = $this->uploadFileHelperService->getFileParams($order['filePdf']);

            if (empty($order['location'])) {
                $order['location'] = null;
            }
          
            $order['orderLogs'] = $this->orderTimeLineService->getOrderLogsByOrderIdForAdmin($id);
           
            $order['captain'] = null;

            if($order['captainUserId']) {
                $order['captain'] = $this->captainService->getCaptainInfoForAdmin($order['captainUserId']);
            }

            $order['subOrder'] = $this->adminOrderManager->getSubOrdersByPrimaryOrderIdForAdmin($order['id']);
        }

        return $this->autoMapping->map("array", OrderByIdGetForAdminResponse::class, $order);
    }

    // This function filters only orders in which the captain does not arrive the store yet
    public function filterCaptainNotArrivedOrdersByAdmin(CaptainNotArrivedOrderFilterByAdminRequest $request): array
    {
        $response = [];

        $orders = $this->adminOrderManager->filterCaptainNotArrivedOrdersByAdmin($request);

        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map("array", CaptainNotArrivedOrderFilterResponse::class, $order);
        }

        return $response;
    }

    public function filterStoreBidOrdersByAdmin(OrderFilterByAdminRequest $request): ?array
    {
        $response = [];

        $orders = $this->adminOrderManager->filterStoreBidOrdersByAdmin($request);

        foreach ($orders as $key=>$value) {
            $response[$key] = $this->autoMapping->map("array", BidOrderGetForAdminResponse::class, $value);

            if ($value['bidOrderDetails']) {
                // get bid details info
                $response[$key]->bidDetailsId = $value['bidOrderDetails']->getId();
                $response[$key]->openToPriceOffer = $value['bidOrderDetails']->getOpenToPriceOffer();

                // get branch info
                if ($value['bidOrderDetails']->getBranch()) {
                    $response[$key]->storeOwnerBranchId = $value['bidOrderDetails']->getBranch()->getId();
                    $response[$key]->storeOwnerBranchName = $value['bidOrderDetails']->getBranch()->getName();
                    $response[$key]->storeOwnerBranchPhone = $value['bidOrderDetails']->getBranch()->getBranchPhone();

                    // get store info
                    $response[$key]->storeOwnerProfileId = $value['bidOrderDetails']->getBranch()->getStoreOwner()->getId();
                    $response[$key]->storeOwnerId = $value['bidOrderDetails']->getBranch()->getStoreOwner()->getStoreOwnerId();
                    $response[$key]->storeOwnerName = $value['bidOrderDetails']->getBranch()->getStoreOwner()->getStoreOwnerName();
                    $response[$key]->storeOwnerPhone = $value['bidOrderDetails']->getBranch()->getStoreOwner()->getPhone();
                }
            }
        }

        return $response;
    }

    public function getSpecificBidOrderByIdForAdmin(int $id): ?BidOrderByIdGetForAdminResponse
    {
        $order = $this->adminOrderManager->getSpecificBidOrderByIdForAdmin($id);

        if ($order) {
            $order['orderLogs'] = $this->orderTimeLineService->getOrderLogsByOrderIdForAdmin($id);

            // get bid details info
            $order['bidDetails'] = $this->autoMapping->map(BidDetailsEntity::class, BidDetailsGetForAdminResponse::class, $order['bidOrderDetails']);

            $order['bidDetails']->supplierCategoryId = $order['bidOrderDetails']->getSupplierCategory()->getId();
            $order['bidDetails']->supplierCategoryName = $order['bidOrderDetails']->getSupplierCategory()->getName();

            // handle images
            $order['bidDetails']->images = $this->customizeBidOrderImages($order['bidDetails']->images->ToArray());

            // get branch info
            $order['storeOwnerBranchId'] = $order['bidOrderDetails']->getBranch()->getId();
            $order['storeOwnerBranchName'] = $order['bidOrderDetails']->getBranch()->getName();
            $order['storeOwnerBranchPhone'] = $order['bidOrderDetails']->getBranch()->getBranchPhone();
            $order['storeOwnerBranchLocation'] = $order['bidOrderDetails']->getBranch()->getLocation();

            // get store info
            $order['storeOwnerProfileId'] = $order['bidOrderDetails']->getBranch()->getStoreOwner()->getId();
            $order['storeOwnerId'] = $order['bidOrderDetails']->getBranch()->getStoreOwner()->getStoreOwnerId();
            $order['storeOwnerName'] = $order['bidOrderDetails']->getBranch()->getStoreOwner()->getStoreOwnerName();
            $order['storeOwnerPhone'] = $order['bidOrderDetails']->getBranch()->getStoreOwner()->getPhone();
        }

        return $this->autoMapping->map("array", BidOrderByIdGetForAdminResponse::class, $order);
    }

    public function customizeBidOrderImages(array $imagesArray): ?array
    {
        $response = [];

        if (! empty($imagesArray)) {
            foreach ($imagesArray as $image) {
                $response[] = $this->uploadFileHelperService->getImageParams($image->getImagePath());
            }

            return $response;

        } else {
            return null;
        }
    }
        
    public function getPendingOrdersForAdmin(int $userId): array
    {
        $response = [];

        $this->orderService->showSubOrderIfCarIsAvailable($userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST);
        $this->orderService->hideOrderExceededDeliveryTimeByHour($userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST);

        $response['pendingOrders'] = $this->prepareOrderResponseObject($this->adminOrderManager->getPendingOrdersForAdmin());
        $response['hiddenOrders'] = $this->prepareOrderResponseObject($this->adminOrderManager->getHiddenOrdersForAdmin());
        $response['notDeliveredOrders'] = $this->prepareOrderResponseObject($this->adminOrderManager->getNotDeliveredOrdersForAdmin());

        $response['pendingOrdersCount'] = count($response['pendingOrders']);
        $response['hiddenOrdersCount'] = count($response['hiddenOrders']);
        $response['notDeliveredOrdersCount'] = count($response['notDeliveredOrders']);

        $response['totalOrderCount'] = $response['pendingOrdersCount'] + $response['hiddenOrdersCount'] + $response['notDeliveredOrdersCount'];

        return $response;
    }

    public function prepareOrderResponseObject(array $orders): array
    {
        $response = [];

        if (! empty($orders)) {
            foreach ($orders as $key=>$value) {
                $value['subOrder'] = $this->orderService->getSubOrdersByPrimaryOrderId($value['id']);

                $response[$key] = $this->autoMapping->map('array', OrderPendingResponse::class, $value);

                if ($value['bidDetailsInfo'] !== null) {
                    if ($value['bidDetailsInfo']->getBranch() !== null) {
                        $response[$key]->branchName = $value['bidDetailsInfo']->getBranch()->getName();
                        $response[$key]->location = $value['bidDetailsInfo']->getBranch()->getLocation();
                    }

                    $response[$key]->sourceDestination = $value['bidDetailsInfo']->getSourceDestination();
                }
            }
        }

        return $response;
    }

    // This function for returning order which being accepted by captain to pending status under certain circumstances
    public function rePendingAcceptedOrderByAdmin(RePendingAcceptedOrderByAdminRequest $request, int $userId): string|null|OrderStateUpdateByAdminResponse|int
    {
        // First, check order status if we can return it to pending
        $orderEntity = $this->adminOrderManager->getOrderByIdForAdmin($request->getOrderId());

        if ($orderEntity !== null) {
            // Before doing anything, check if order is hidden - for any reason - or not
            if (($orderEntity->getIsHide() === OrderIsHideConstant::ORDER_HIDE_TEMPORARILY) || ($orderEntity->getIsHide() === OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE)) {
                return OrderResultConstant::ORDER_IS_HIDDEN_CONST;
            }

            // we need captain id for deleting related order chat room + create local notification for the captain
            $captainId = $orderEntity->getCaptainId()->getId();

            // we need also the user id of the captain in order to send a firebase notification later after updating the order
            $captainUserId = $orderEntity->getCaptainId()->getCaptainId();

            if ($orderEntity->getState() !== OrderStateConstant::ORDER_STATE_ON_WAY && $orderEntity->getState() !== OrderStateConstant::ORDER_STATE_IN_STORE) {
                // captain took the order and on going to deliver it to the client
                return OrderResultConstant::ORDER_ACCEPTED_BY_CAPTAIN;
            }

            // ***** reaching here means we can return the order to the pending state ***** //
            // update order status to pending
            $orderResult = $this->adminOrderManager->returnOrderToPendingStatus($orderEntity);

            if ($orderResult) {
                // delete the order chat room of the order that created with the captain
                $this->orderChatRoomService->deleteChatRoomByOrderIdAndCaptainId($orderResult->getId(), $captainId);

                // insert new order log of the new status
                $this->orderTimeLineService->createOrderLogsRequest($orderResult, $this->storeOrderDetailsService->getStoreBranchByOrderId($orderResult->getId()));

                // save log of the action on order
                $this->orderLogService->createOrderLogMessage($orderResult, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::UN_ASSIGN_ORDER_TO_CAPTAIN_BY_ADMIN_ACTION_CONST, null, null);

                // *** send notifications (local and firebase) *** //
                $this->notificationLocalService->createNotificationLocal($orderResult->getStoreOwner()->getStoreOwnerId(), NotificationConstant::ORDER_RETURNED_PENDING_TITLE,
                    NotificationConstant::ORDER_RETURNED_PENDING, NotificationTokenConstant::APP_TYPE_STORE, $orderResult->getId());

                $this->notificationLocalService->createNotificationLocal($captainUserId, NotificationConstant::ORDER_RETURNED_PENDING_TITLE,
                    NotificationConstant::ORDER_UNASSIGNED_TO_CAPTAIN.$orderResult->getId(), NotificationTokenConstant::APP_TYPE_CAPTAIN,
                    $orderResult->getId());

                //create firebase notification to store
                try {
                    $this->notificationFirebaseService->notificationOrderStateForUser($orderResult->getStoreOwner()->getStoreOwnerId(), $orderResult->getId(),
                        $orderResult->getState(), NotificationConstant::STORE);

                } catch (\Exception $e) {
                    error_log($e);
                }
                //create firebase notification to captains
                try {
                    $this->notificationFirebaseService->notificationToUser($captainUserId, $orderResult->getId(), NotificationFirebaseConstant::CANCEL_ASSIGN_BY_ADMIN);

                    $this->notificationFirebaseService->notificationToCaptains($orderResult->getId());

                } catch (\Exception $e) {
                    error_log($e);
                }

                return $this->autoMapping->map(OrderEntity::class, OrderStateUpdateByAdminResponse::class, $orderResult);
            }

            return OrderResultConstant::ORDER_RETURNING_TO_PENDING_HAS_PROBLEM;
        }

        return $orderEntity;
    }

    public function getPendingOrdersCountForAdmin(): int
    {
        return $this->adminOrderManager->getPendingOrdersCountForAdmin();
    }

    public function getDeliveredOrdersCountBetweenTwoDatesForAdmin(DateTime $fromDate, DateTime $toDate): int
    {
        return $this->adminOrderManager->getDeliveredOrdersCountBetweenTwoDatesForAdmin($fromDate, $toDate);
    }

    public function updateOrderToHidden(int $id, int $userId): OrderUpdateToHiddenResponse|string
    {
       $orderEntity = $this->adminOrderManager->updateOrderToHidden($id);
       if($orderEntity === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
           return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($orderEntity, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::HIDE_ORDER_WHILE_UPDATING_BY_ADMIN_ACTION_CONST, null, null);

       return $this->autoMapping->map(OrderEntity::class, OrderUpdateToHiddenResponse::class, $orderEntity);
    }  

    public function orderUpdateByAdmin(UpdateOrderByAdminRequest $request, int $userId): string|null|OrderUpdateByAdminResponse
    {
        $order = $this->adminOrderManager->getOrderByIdWithStoreOrderDetailForAdmin($request->getId());

        if($order) {
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

            if (new DateTime($request->getDeliveryDate()) < new DateTime('now')) {
                // we set the delivery date equals to current datetime + 3 minutes just for affording the late in persisting the order
                // to the database if it is happened
                $request->setDeliveryDate((new DateTime('+ 3 minutes'))->format('Y-m-d H:i:s'));
            }

            // Check if there are any remaining cars in order to hide or show order
//            $request->setIsHide($order['isHide']);
//
//            $checkRemainingCarsResult = $this->subscriptionService->checkRemainingCarsOnlyByOrderId($request->getId());
//
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

            $order = $this->adminOrderManager->orderUpdateByAdmin($request);

            if ($order) {
                // save log of the action on order
                $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::UPDATE_ORDER_BY_ADMIN_ACTION_CONST, null, null);

                if ($order->getCaptainId()) {
                    // create firebase notification to captain
                    try {
                        $this->notificationFirebaseService->notificationToUser($order->getCaptainId()->getCaptainId(), $order->getId(), NotificationFirebaseConstant::ORDER_UPDATE_BY_ADMIN);
                    } catch (\Exception $e) {
                        error_log($e);
                }
              }
            }
        }
      
        return $this->autoMapping->map(OrderEntity::class, OrderUpdateByAdminResponse::class, $order);
      }

    public function createOrderByAdmin(OrderCreateByAdminRequest $request, int $userId): string|CanCreateOrderResponse|OrderCreateByAdminResponse
    {
        $storeOwnerProfile = $this->storeOwnerProfileService->getStoreOwnerProfileEntityByIdForAdmin($request->getStoreOwner());

        if ($storeOwnerProfile === null) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $canCreateOrder = $this->subscriptionService->canCreateOrder($storeOwnerProfile->getStoreOwnerId());

        if ($canCreateOrder === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS || $canCreateOrder->canCreateOrder === SubscriptionConstant::CAN_NOT_CREATE_ORDER) {
            return $canCreateOrder;
        }
       
        $request->setIsHide(OrderIsHideConstant::ORDER_SHOW);

        if ($canCreateOrder->subscriptionStatus === SubscriptionConstant::CARS_FINISHED) {

            $request->setIsHide(OrderIsHideConstant::ORDER_HIDE_TEMPORARILY);
        }

        $request->setStoreOwner($storeOwnerProfile);

        $branch = $this->storeOwnerBranchService->getBranchEntityById($request->getBranch());

        if ($branch === null) {
            return StoreOwnerBranch::BRANCH_NOT_FOUND;
        }

        $request->setBranch($branch);

        if (new DateTime($request->getDeliveryDate()) < new DateTime('now')) {
            // we set the delivery date equals to current datetime + 3 minutes just for affording the late in persisting the order
            // to the database if it is happened
            $request->setDeliveryDate((new DateTime('+ 3 minutes'))->format('Y-m-d H:i:s'));
        }

        $order = $this->adminOrderManager->createOrderByAdmin($request);

        if ($order) {
            $this->subscriptionService->updateRemainingOrders($request->getStoreOwner()->getStoreOwnerId(), SubscriptionConstant::OPERATION_TYPE_SUBTRACTION);

            $this->notificationLocalService->createNotificationLocal($request->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NEW_ORDER_TITLE, NotificationConstant::CREATE_ORDER_SUCCESS,
                NotificationTokenConstant::APP_TYPE_STORE, $order->getId());

            $this->orderTimeLineService->createOrderLogsRequest($order);

            // save log of the action on order
            $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                OrderLogActionTypeConstant::CREATE_ORDER_BY_ADMIN_ACTION_CONST, $branch->getId(), null);

            //create firebase notification to store
            try{
                $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), $order->getState(), NotificationConstant::STORE);
            }
            catch (\Exception $e){
                error_log($e);
            }
            //create firebase notification to captains
            try{
                $this->notificationFirebaseService->notificationToCaptains($order->getId());
            }
            catch (\Exception $e){
                error_log($e);
            }
        }

        return $this->autoMapping->map(OrderEntity::class, OrderCreateByAdminResponse::class, $order);
    }

    public function getOrdersOngoingCountByCaptainIdForAdmin(int $captainId): int
    {
        return $this->adminOrderManager->getOrdersOngoingCountByCaptainIdForAdmin($captainId);
    }

    public function assignOrderToCaptain(OrderAssignToCaptainByAdminRequest $request, int $userId): null|OrderUpdateToHiddenResponse|int
    {
        $orderEntity = $this->adminOrderManager->getOrderById($request->getOrderId());

        if ($orderEntity) {
            // Before doing anything, check if order is hidden - for any reason - or not
            if (($orderEntity->getIsHide() === OrderIsHideConstant::ORDER_HIDE_TEMPORARILY) || ($orderEntity->getIsHide() === OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE)) {
                return OrderResultConstant::ORDER_IS_HIDDEN_CONST;
            }

            //Check the order if it is pending
            if($orderEntity->getState() !==  OrderStateConstant::ORDER_STATE_PENDING) {
                return OrderStateConstant::ORDER_STATE_PENDING_INT;
            }

            // Check whether the captain has received an order for a specific store
            // $checkCaptainReceivedOrder = $this->checkWhetherCaptainReceivedOrderForSpecificStore($request->getId(), $orderEntity->getStoreOwner()->getId(), $orderEntity->getPrimaryOrder()?->getId());
            // if ($checkCaptainReceivedOrder === OrderResultConstant::CAPTAIN_RECEIVED_ORDER_FOR_THIS_STORE_INT) {
            //    return OrderResultConstant::CAPTAIN_RECEIVED_ORDER_FOR_THIS_STORE_INT_FOR_ADMIN;
            // }

            //Check availability of cars for the store
            $checkRemainingCars = $this->subscriptionService->checkRemainingCarsByOrderId($request->getOrderId());

            if ($checkRemainingCars === SubscriptionConstant::CARS_FINISHED) {
                return SubscriptionConstant::CARS_FINISHED_INT;
            }

            $order = $this->adminOrderManager->assignOrderToCaptain($request, $orderEntity);    
              
            if($order === CaptainConstant::CAPTAIN_NOT_FOUND) {
                return CaptainConstant::CAPTAIN_NOT_FOUND;
            }
            if($order) {
                //create order chatRoom
                $this->orderChatRoomService->createOrderChatRoomOrUpdateCurrent($order);

                //create Notification Local for store
                $this->notificationLocalService->createNotificationLocalForOrderState($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::STATE_TITLE, $order->getState(), $order->getId(), NotificationConstant::STORE, $order->getCaptainId()->getId()); 
                //create Notification Local for captain
                $this->notificationLocalService->createNotificationLocalForOrderState($order->getCaptainId()->getCaptainId(), NotificationConstant::STATE_TITLE, $order->getState(), $order->getId(), NotificationConstant::CAPTAIN);

                //create order log
                $this->orderTimeLineService->createOrderLogsRequest($order);

                // save log of the action on order
                $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::ASSIGN_ORDER_TO_CAPTAIN_BY_ADMIN_ACTION_CONST, null, null);

                //create firebase notification to store
                try{
                    $this->notificationFirebaseService->notificationOrderStateForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), $order->getState(), NotificationConstant::STORE);
                }
                catch (\Exception $e){
                    error_log($e);
                }
                // create firebase notification to captain
                try{
                    $this->notificationFirebaseService->notificationToUser($order->getCaptainId()->getCaptainId(), $order->getId(), NotificationFirebaseConstant::ORDER_ASSIGN_BY_ADMIN);

                }
                catch (\Exception $e){
                    error_log($e);
                }
            }
        }
        return $this->autoMapping->map(OrderEntity::class, OrderUpdateToHiddenResponse::class, $orderEntity);
    }

    // This function currently cancel NORMAL order exclusively (not a bid order)
    public function orderCancelByAdmin(int $id, int $userId): string|OrderCancelByAdminResponse
    {
        $orderEntity = $this->adminOrderManager->getOrderByIdForAdmin($id);

        if ($orderEntity !== null) {
            // if order of type bid, then use another api in order to cancel it
            if ($orderEntity->getOrderType() === OrderTypeConstant::ORDER_TYPE_BID) {
                return OrderResultConstant::ORDER_TYPE_BID;
            }

            if ($orderEntity->getState() !== OrderStateConstant::ORDER_STATE_PENDING) {
                // we can not cancel the order, because it may received by a captain and delivered or will be delivered to client
                return OrderResultConstant::ORDER_ALREADY_IS_BEING_ACCEPTED;
            }

            $newUpdatedOrder = $this->adminOrderManager->updateOrderStatusToCancelled($orderEntity);

            if ($newUpdatedOrder) {
                $this->orderTimeLineService->createOrderLogsRequest($newUpdatedOrder);

                // save log of the action on order
                $this->orderLogService->createOrderLogMessage($newUpdatedOrder, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::CANCEL_ORDER_BY_ADMIN_ACTION_CONST, null, null);

                //create local notification to store
                $this->notificationLocalService->createNotificationLocal($newUpdatedOrder->getStoreOwner()->getStoreOwnerId(), NotificationConstant::CANCEL_ORDER_TITLE,
                    NotificationConstant::CANCEL_ORDER_SUCCESS, NotificationTokenConstant::APP_TYPE_STORE, $newUpdatedOrder->getId());

                //create firebase notification to store
                try {
                    $this->notificationFirebaseService->notificationOrderStateForUser($newUpdatedOrder->getStoreOwner()->getStoreOwnerId(), $newUpdatedOrder->getId(), NotificationConstant::CANCEL_ORDER_SUCCESS,
                        NotificationConstant::STORE);

                } catch (\Exception $e) {
                    error_log($e);
                }

                $this->subscriptionService->updateRemainingOrders($newUpdatedOrder->getStoreOwner()->getStoreOwnerId(), SubscriptionConstant::OPERATION_TYPE_ADDITION);

                return $this->autoMapping->map(OrderEntity::class, OrderCancelByAdminResponse::class, $newUpdatedOrder);
            }

            return OrderResultConstant::ORDER_UPDATE_PROBLEM;
        }

        return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
    }

    public function updateOrderStateByAdmin(OrderStateUpdateByAdminRequest $request, int $userId): int|OrderStateUpdateByAdminResponse|null
    {
        // Check order visibility before updating its status
        $visibility = $this->getOrderIsHideByOrderId($request->getId());

        if (($visibility === OrderIsHideConstant::ORDER_HIDE_TEMPORARILY) || ($visibility === OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE)) {
            return OrderResultConstant::ORDER_IS_HIDDEN_CONST;
        }

        $orderResult = $this->adminOrderManager->updateOrderStateByAdmin($request);

        if (! $orderResult) {
            return $orderResult;
        }

        if ($orderResult === OrderResultConstant::ORDER_IS_BEING_DELIVERED) {
            return OrderResultConstant::ORDER_IS_BEING_DELIVERED;
        }

        if (count($orderResult) > 0) {
            if ($orderResult[0]) {
                if ($orderResult[0]->getCaptainId()) {
                    if ($orderResult[0]->getState() === OrderStateConstant::ORDER_STATE_DELIVERED) {
                        //create or update captainFinancialDues
                        $this->captainFinancialDuesService->captainFinancialDues($orderResult[0]->getCaptainId()->getCaptainId());

                        //save the price of the order in cash in case the captain does not pay the store
                        if ($orderResult[0]->getPayment() === OrderTypeConstant::ORDER_PAYMENT_CASH && $orderResult[0]->getPaidToProvider() === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                            $this->captainAmountFromOrderCashService->createCaptainAmountFromOrderCash($orderResult[0],
                                OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO, $orderResult[0]->getOrderCost());

                            $this->storeOwnerDuesFromCashOrdersService->createStoreOwnerDuesFromCashOrders($orderResult[0],
                                OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO, $orderResult[0]->getOrderCost());
                        }
                    }

                    // create firebase notification to captain
                    try {
                        $this->notificationFirebaseService->notificationOrderStateForUserByAdmin($orderResult[0]->getCaptainId()->getCaptainId(),
                            $orderResult[0]->getId(), $orderResult[0]->getState(), NotificationConstant::CAPTAIN);

                    } catch (\Exception $e) {
                        error_log($e);
                    }

                } else {
                    if ($request->getState() === OrderStateConstant::ORDER_STATE_PENDING) {
                        // order returned to pending status, so create a local notification for the captain
                        $this->notificationLocalService->createNotificationLocal($orderResult[1], NotificationConstant::ORDER_RETURNED_PENDING_TITLE,
                            NotificationConstant::ORDER_UNASSIGNED_TO_CAPTAIN.$orderResult[0]->getId(),
                            NotificationTokenConstant::APP_TYPE_CAPTAIN, $orderResult[0]->getId());
                    }
                }
                // insert new order log
                $this->orderTimeLineService->createOrderLogsRequest($orderResult[0], $this->storeOrderDetailsService->getStoreBranchByOrderId($orderResult[0]->getId()));

                // save log of the action on order
                $this->orderLogService->createOrderLogMessage($orderResult[0], $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::UPDATE_ORDER_STATE_BY_ADMIN_ACTION_CONST, null, null);
            }
        }

        return $this->autoMapping->map(OrderEntity::class, OrderStateUpdateByAdminResponse::class, $orderResult[0]);
      }
      
    public function filterCaptainOrdersByAdmin(OrderCaptainFilterByAdminRequest $request): array
    {
        $response = [];
        $result = [];
        // holds the sum of captainOrderCost of returned cash orders
        $response['totalCashOrdersCost'] = 0;

        $orders = $this->adminOrderManager->filterCaptainOrdersByAdmin($request);
        // $countOrders = count($orders);
      
        foreach ($orders as $order) {
            // note: when an order is not a cash one, then captainOrderCost = 0
            $response['totalCashOrdersCost'] = $response['totalCashOrdersCost'] + $order['captainOrderCost'];

            $order['images'] = $this->uploadFileHelperService->getImageParams($order['images']);

            $result[] = $this->autoMapping->map("array", OrderGetForAdminResponse::class, $order);
        }

        $response['orders'] = $result;
        $response['countOrders'] = count($orders);

        return $response;
    }

    // filter orders in which the store's answer differs from that of the captain (paid or not paid)
    public function filterOrdersPaidOrNotPaidByAdmin(FilterOrdersPaidOrNotPaidByAdminRequest $request): array
    {
        $response = [];

        $orders = $this->adminOrderManager->filterOrdersPaidOrNotPaidByAdmin($request);

        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map("array", FilterOrdersPaidOrNotPaidByAdminResponse::class, $order);
        }

        return $response;
    }
    
    public function calculateCostDeliveryOrder(AdminCalculateCostDeliveryOrderRequest $request): CalculateCostDeliveryOrderResponse
    {
        return $this->adminStoreSubscriptionService->calculateCostDeliveryOrderForAdmin($request);
    }

    // filter orders whose has not distance  has calculated 
    public function filterOrdersWhoseHasNotDistanceHasCalculated(FilterOrdersWhoseHasNotDistanceHasCalculatedRequest $request): array
    {
        $items = [];
 
        $items['orderWithOutDistance'] = $this->adminOrderManager->filterOrdersWhoseHasNotDistanceHasCalculated($request);
        $items['orders'] = $this->adminOrderManager->filterOrders($request);
 
        return $items;
     }
   
    // filter orders whose has not distance  has calculated 
    public function filterOrdersWithOutDistance(FilterOrdersWhoseHasNotDistanceHasCalculatedRequest $request): array
    {
        return $this->adminOrderManager->filterOrdersWhoseHasNotDistanceHasCalculated($request);  
    }
   
    public function filterOrders(FilterOrdersWhoseHasNotDistanceHasCalculatedRequest $request): array
    {
        return $this->adminOrderManager->filterOrders($request);  
    }
     
    public function updateStoreBranchToClientDistanceByAdmin(OrderStoreBranchToClientDistanceByAdminRequest $request, int $userId): OrderStoreToBranchDistanceAndDestinationUpdateByAdminResponse
    {
        $order = $this->adminOrderManager->updateStoreBranchToClientDistanceByAdmin($request);

        if ($order) {
            if ($order->getCaptainId()?->getCaptainId()) {
                $this->captainFinancialDuesService->captainFinancialDues($order->getCaptainId()->getCaptainId(), $order->getId(), $order->getCreatedAt());
            }

            // save log of the action on order
            $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                OrderLogActionTypeConstant::UPDATE_STORE_BRANCH_TO_CLIENT_DISTANCE_BY_ADMIN_ACTION_CONST, null, null);
        }

        return $this->autoMapping->map(OrderEntity::class, OrderStoreToBranchDistanceAndDestinationUpdateByAdminResponse::class, $order);
    }

    public function createSubOrderByAdmin(SubOrderCreateByAdminRequest $request, int $userId): string|OrderCreateByAdminResponse
    {
        $storeOwnerProfile = $this->storeOwnerProfileService->getStoreOwnerProfileEntityByIdForAdmin($request->getStoreOwner());

        if (! $storeOwnerProfile) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $request->setStoreOwner($storeOwnerProfile);

        $branch = $this->storeOwnerBranchService->getBranchEntityById($request->getBranch());

        if (! $branch) {
            return StoreOwnerBranch::BRANCH_NOT_FOUND;
        }

        $request->setBranch($branch);

        $packageBalance = $this->adminStoreSubscriptionService->packageBalanceForAdminByStoreOwnerId($storeOwnerProfile->getStoreOwnerId());

        if ($packageBalance->remainingOrders <= 0) {
            return SubscriptionConstant::CAN_NOT_CREATE_SUB_ORDER;
        }

        $primaryOrder = $this->adminOrderManager->getOrderById($request->getPrimaryOrder());

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

        $order = $this->adminOrderManager->createSubOrderByAdmin($request);

        if ($order) {
            // update remaining orders
            $this->subscriptionService->updateRemainingOrders($request->getStoreOwner()->getStoreOwnerId(),
                SubscriptionConstant::OPERATION_TYPE_SUBTRACTION);

            // notification to store
            $this->notificationLocalService->createNotificationLocal($request->getStoreOwner()->getStoreOwnerId(),
                NotificationConstant::NEW_SUB_ORDER_TITLE, NotificationConstant::CREATE_SUB_ORDER_SUCCESS,
                NotificationTokenConstant::APP_TYPE_STORE, $order->getId());

            // notification to captain
            if ($primaryOrder->getCaptainId()) {
                $this->notificationLocalService->createNotificationLocal($primaryOrder->getCaptainId()->getCaptainId(),
                    NotificationConstant::NEW_SUB_ORDER_TITLE, NotificationConstant::ADD_SUB_ORDER,
                    NotificationTokenConstant::APP_TYPE_STORE, $request->getPrimaryOrder()->getId());
            }

            $this->orderTimeLineService->createOrderLogsRequest($order);

            // save log of the action on order
            $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                OrderLogActionTypeConstant::CREATE_SUB_ORDER_BY_ADMIN_ACTION_CONST, null, null);

            try {
                // create firebase notification to store
                $this->notificationFirebaseService->notificationSubOrderForUser($order->getStoreOwner()->getStoreOwnerId(), $order->getId(), NotificationFirebaseConstant::CREATE_SUB_ORDER_SUCCESS);

                // create firebase notification to captain
                if ($primaryOrder->getCaptainId()) {
                    $this->notificationFirebaseService->notificationSubOrderForUser($primaryOrder->getCaptainId()->getCaptainId(), $order->getId(), NotificationFirebaseConstant::ADD_SUB_ORDER);
                }

            } catch (\Exception $e) {
                error_log($e);
            }
        }

        return $this->autoMapping->map(OrderEntity::class, OrderCreateByAdminResponse::class, $order);
    }
    
    // filter Orders not answered by the store (paid or not paid)
    public function filterOrdersNotAnsweredByTheStore(FilterOrdersPaidOrNotPaidByAdminRequest $request): array
    {
        $response = [];

        $orders = $this->adminOrderManager->filterOrdersNotAnsweredByTheStore($request);

        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map("array", FilterOrdersPaidOrNotPaidByAdminResponse::class, $order);
        }

        return $response;
    }

    /** Following function check if captain has ongoing orders from specific store **/
//    public function checkWhetherCaptainReceivedOrderForSpecificStore(int $captainProfileId, int $storeId, int|null $primaryOrderId): int
//    {
//        $orderEntity = $this->adminOrderManager->checkWhetherCaptainReceivedOrderForSpecificStore($captainProfileId, $storeId);
//
//        if ($orderEntity) {
//            //if the order not main
//            if ($orderEntity->getOrderIsMain() !== true) {
//                return OrderResultConstant::CAPTAIN_RECEIVED_ORDER_FOR_THIS_STORE_INT;
//            }
//            //if the order main and (request order) related
//            if ($primaryOrderId === $orderEntity->getId()) {
//
//                return OrderResultConstant::CAPTAIN_NOT_RECEIVED_ORDER_FOR_THIS_STORE_INT;
//            }
//            //if the order main and (request order) not related
//            return OrderResultConstant::CAPTAIN_RECEIVED_ORDER_FOR_THIS_STORE_INT;
//        }
//
//        return OrderResultConstant::CAPTAIN_NOT_RECEIVED_ORDER_FOR_THIS_STORE_INT;
//    }

    // filter cash orders which have different answers for cash payment
    public function filterDifferentAnsweredCashOrdersByAdmin(FilterDifferentlyAnsweredCashOrdersByAdminRequest $request): array
    {
        $response = [];

        $orders = $this->adminOrderManager->filterDifferentAnsweredCashOrdersByAdmin($request);

        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map("array", FilterDifferentlyAnsweredCashOrdersByAdminResponse::class, $order);
        }

        return $response;
    }

    // Get orders which accepted by captains and their created date is above 8/19/2022
    public function getOrders(): array
    {
       return $this->adminOrderManager->getOrders();
    } 
     
    public function updateStoreBranchToClientDistanceAndDestinationByAdmin(OrderStoreBranchToClientDistanceAndDestinationByAdminRequest $request,
                                                                           int $userId): ?OrderStoreToBranchDistanceAndDestinationUpdateByAdminResponse
    {
        $order = $this->adminOrderManager->updateStoreBranchToClientDistanceAndDestinationByAdmin($request);

        if (! $order) {
            return $order;
        }

        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::UPDATE_STORE_BRANCH_TO_CLIENT_DISTANCE_AND_DESTINATION_BY_ADMIN_ACTION_CONST, null, null);

        return $this->autoMapping->map(OrderEntity::class, OrderStoreToBranchDistanceAndDestinationUpdateByAdminResponse::class, $order);
    }

    /**
     * This function resolves a conflict answers (between captain and store about cash payment) for one order or multi orders.
     * Resolving the conflict is done by deciding the correct answer + updating the contrast one + mark that the conflict
     * is being resolved, and that's done via the API.
     *
     * Note: hasPayConflictAnswers to 2 (which means there is no conflict between the store's answer and the captain answer
     */
    public function resolveOrderHasPayConflictAnswersByAdmin(OrderHasPayConflictAnswersUpdateByAdminRequest $request, int $userId): array
    {
        $response = [];

        $ordersResult = $this->adminOrderManager->resolveOrderHasPayConflictAnswersByAdmin($request);

        if (count($ordersResult) > 0) {
            foreach ($ordersResult as $orderEntity) {
                $response[] = $this->autoMapping->map(OrderEntity::class, OrderHasPayConflictAnswersUpdateByAdminResponse::class,
                    $orderEntity);

                // save log of the action on order
                $this->orderLogService->createOrderLogMessage($orderEntity, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::ORDER_CONFLICTED_ANSWERS_RESOLVED_BY_ADMIN_CONST, null, null);
            }
        }

        return $response;
    }

    // Update isCashPaymentConfirmedByStore by admin
    public function updateIsCashPaymentConfirmedByStoreByAdmin(OrderUpdateIsCashPaymentConfirmedByStoreByAdminRequest $request, int $userId): ?OrderUpdateIsCashPaymentConfirmedByStoreForAdminResponse
    {
        $order = $this->adminOrderManager->updateIsCashPaymentConfirmedByStoreByAdmin($request);

        if ($order) {
            // create order log in order time line
            $this->orderTimeLineService->createOrderLogsRequest($order);

            // save log of the action on order
            $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                OrderLogActionTypeConstant::CONFIRM_CAPTAIN_PAID_TO_PROVIDER_BY_STORE_VIA_DASHBOARD_CONST, null, null);

            // send firebase notification to admin if the captain’s answer differs from that of the store, regarding the field (paidToProvider and isCashPaymentConfirmedByStore)
            if ($order->getIsCashPaymentConfirmedByStore() !== $order->getPaidToProvider()) {

                $this->notificationFirebaseService->notificationToAdmin($order->getId(), NotificationFirebaseConstant::CAPTAIN_ANSWER_DIFFERS_FROM_THAT_OF_STORE);
            }

            return $this->autoMapping->map(OrderEntity::class, OrderUpdateIsCashPaymentConfirmedByStoreForAdminResponse::class, $order);
        }

        return $order;
    }

    // Add additional distance to storeBranchToClientDistance via new destination by admin
    public function addDistanceToStoreBranchToClientDistanceViaLocationByAdmin(OrderStoreBranchToClientDistanceAdditionByAdminRequest $request, int $userId)
    {
        // 1. Calculate the new distance by the new destination
        $currentDestination = $this->getCurrentDestinationByOrderIdForAdmin($request->getOrderId());

        if (($currentDestination !== OrderResultConstant::ORDER_TYPE_BID) &&
            ($currentDestination !== OrderResultConstant::ORDER_NOT_FOUND_RESULT)) {
            $distance = $this->getDistanceBetweenTwoLocations($currentDestination, $request->getDestination());

            if ($distance === GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED) {
                return GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED;
            }

            // start transaction commit ...
            $this->entityManager->getConnection()->beginTransaction();

            try {
                // 2. Update the destination
                $orderResult = $this->updateNormalOrderDestinationViaOrderIdAndDestinationArrayByAdmin($request->getOrderId(), $request->getDestination(),
                    $userId);

                if ($orderResult) {
                    // 3. Add the new distance to the existing one
                    $this->updateOrderStoreBranchToClientDistanceViaAddingNewDistanceByAdmin($request->getOrderId(), $distance, $userId);

                    $this->entityManager->getConnection()->commit();

                    return $orderResult;
                }

            } catch (\Exception $e) {
                $this->entityManager->getConnection()->rollBack();
                throw $e;
            }
        }

        return $currentDestination;
    }

    // Get ONLY the order type and destination (from StoreOrderDetails exclusively) for admin
    public function getOrderTypeAndDestinationFromStoreOrderDetailsByOrderIdForAdmin(int $orderId): ?array
    {
        return $this->adminOrderManager->getOrderTypeAndDestinationFromStoreOrderDetailsByOrderIdForAdmin($orderId);
    }

    // Get client destination of an order by order id for admin
    public function getCurrentDestinationByOrderIdForAdmin(int $orderId): array|string
    {
        // In order to get destination of an order, we have to know its type, either normal or bid order
        $order = $this->getOrderTypeAndDestinationFromStoreOrderDetailsByOrderIdForAdmin($orderId);

        if ($order) {
            if ($order['orderType'] === OrderTypeConstant::ORDER_TYPE_NORMAL) {
                return $order['destination'];
            }

            return OrderResultConstant::ORDER_TYPE_BID;
        }

        return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
    }

    // Get the distance between two locations of type array for admin
    public function getDistanceBetweenTwoLocations(array $fromLocation, array $toLocation): float|int
    {
        $result = $this->geoDistanceService->getGeoDistanceBetweenTwoLocations($fromLocation['lat'], $fromLocation['lon'],
            $toLocation['lat'], $toLocation['lon']);

        if (($result === GeoDistanceResultConstant::BAD_REQUEST_CONST) ||
            ($result === GeoDistanceResultConstant::CONTENT_CAN_NOT_BE_DECODED)) {
            return GeoDistanceResultConstant::DESTINATION_COULD_NOT_BE_CALCULATED;
        }

        // get the distance value from the resulted response
        return (float) $result->distance;
    }

    // Update the destination of normal order (normal order only because bid order has different approach)
    public function updateNormalOrderDestinationViaOrderIdAndDestinationArrayByAdmin(int $orderId, array $newDestination, int $userId): ?OrderDestinationUpdateByAdminResponse
    {
        $order = $this->adminOrderManager->updateNormalOrderDestinationViaOrderIdAndDestinationArrayByAdmin($orderId, $newDestination);

        if (! $order) {
            return $order;
        }

        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::UPDATE_ORDER_DESTINATION_BY_ADMIN_ACTION_CONST,
            null, null);

        return $this->autoMapping->map(OrderEntity::class, OrderDestinationUpdateByAdminResponse::class, $order);
    }

    // Add distance to the existing one (in storeBranchToClientDistance field)
    public function updateOrderStoreBranchToClientDistanceViaAddingNewDistanceByAdmin(int $orderId, float $distance, int $userId): ?OrderDestinationUpdateByAdminResponse
    {
        $order = $this->adminOrderManager->updateOrderStoreBranchToClientDistanceViaAddingNewDistanceByAdmin($orderId, $distance);

        if (! $order) {
            return $order;
        }

        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::UPDATE_STORE_BRANCH_TO_CLIENT_DISTANCE_VIA_ADDING_DISTANCE_BY_ADMIN_ACTION_CONST,
            null, null);

        return $this->autoMapping->map(OrderEntity::class, OrderDestinationUpdateByAdminResponse::class, $order);
    }

    // Just add additional distance to storeBranchToClientDistance via new destination by admin
    public function addAdditionalDistanceToStoreBranchToClientDistanceByAdmin(OrderStoreBranchToClientDistanceUpdateByAddAdditionalDistanceByAdminRequest $request, int $userId): ?OrderStoreBranchToClientDistanceUpdateByAdminResponse
    {
        $order = $this->adminOrderManager->updateOrderStoreBranchToClientDistanceViaAddingNewDistanceByAdmin($request->getOrderId(),
            $request->getAdditionalDistance());

        if (! $order) {
            return $order;
        }

        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::UPDATE_STORE_BRANCH_TO_CLIENT_DISTANCE_VIA_ADD_ADDITIONAL_DISTANCE_BY_ADMIN_ACTION_CONST,
            null, null);

        return $this->autoMapping->map(OrderEntity::class, OrderStoreBranchToClientDistanceUpdateByAdminResponse::class, $order);
    }

    public function getOrderIsHideByOrderId(int $orderId): int|string
    {
        $arrayResult = $this->adminOrderManager->getOrderIsHideByOrderId($orderId);

        if (count($arrayResult) > 0) {
            return (int) $arrayResult[0];
        }

        return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
    }
}
