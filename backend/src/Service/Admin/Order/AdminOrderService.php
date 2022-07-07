<?php

namespace App\Service\Admin\Order;

use App\AutoMapping;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Constant\Subscription\SubscriptionConstant;
use App\Entity\BidDetailsEntity;
use App\Entity\OrderEntity;
use App\Manager\Admin\Order\AdminOrderManager;
use App\Request\Admin\Order\CaptainNotArrivedOrderFilterByAdminRequest;
use App\Request\Admin\Order\OrderCreateByAdminRequest;
use App\Request\Admin\Order\OrderFilterByAdminRequest;
use App\Request\Admin\Order\RePendingAcceptedOrderByAdminRequest;
use App\Response\Admin\Order\BidDetailsGetForAdminResponse;
use App\Response\Admin\Order\BidOrderGetForAdminResponse;
use App\Response\Admin\Order\CaptainNotArrivedOrderFilterResponse;
use App\Response\Admin\Order\OrderByIdGetForAdminResponse;
use App\Response\Admin\Order\OrderCancelByAdminResponse;
use App\Response\Admin\Order\OrderCreateByAdminResponse;
use App\Response\Admin\Order\OrderGetForAdminResponse;
use App\Response\Order\BidOrderByIdGetForAdminResponse;
use App\Response\Subscription\CanCreateOrderResponse;
use App\Service\ChatRoom\OrderChatRoomService;
use App\Service\FileUpload\UploadFileHelperService;
use App\Service\Notification\NotificationFirebaseService;
use App\Service\Notification\NotificationLocalService;
use App\Service\Order\StoreOrderDetailsService;
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

class AdminOrderService
{
    private AutoMapping $autoMapping;
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

    public function __construct(AutoMapping $autoMapping, AdminOrderManager $adminStoreOwnerManager, UploadFileHelperService $uploadFileHelperService, OrderTimeLineService $orderTimeLineService,
                                OrderService $orderService, OrderChatRoomService $orderChatRoomService, StoreOrderDetailsService $storeOrderDetailsService, NotificationFirebaseService $notificationFirebaseService,
                                NotificationLocalService $notificationLocalService, StoreOwnerProfileService $storeOwnerProfileService, SubscriptionService $subscriptionService, StoreOwnerBranchService $storeOwnerBranchService, CaptainFinancialDuesService $captainFinancialDuesService, CaptainAmountFromOrderCashService $captainAmountFromOrderCashService, StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService, CaptainService $captainService)
    {
        $this->autoMapping = $autoMapping;
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

    public function getSpecificOrderByIdForAdmin(int $id)
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
                $order['captain'] = $this->captainService->getCaptain($order['captainUserId']);
            }
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
        
    public function getPendingOrdersForAdmin(): array
    {
        $response = [];

        $this->orderService->showSubOrderIfCarIsAvailable();
        $this->orderService->hideOrderExceededDeliveryTimeByHour();

        $response['pendingOrders'] = $this->prepareOrderResponseObject($this->adminOrderManager->getPendingOrdersForAdmin());
        $response['hiddenOrders'] = $this->prepareOrderResponseObject($this->adminOrderManager->getHiddenOrdersForAdmin());
        $response['notDeliveredOrders'] = $this->prepareOrderResponseObject($this->adminOrderManager->getNotDeliveredOrdersForAdmin());

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
    public function rePendingAcceptedOrderByAdmin(RePendingAcceptedOrderByAdminRequest $request): string|null|OrderByIdGetForAdminResponse
    {
        // First, check order status if we can return it to pending
        $orderEntity = $this->adminOrderManager->getOrderByIdForAdmin($request->getOrderId());

        if ($orderEntity !== null) {
            // we need captain id for deleting related order chat room
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

                // *** send notifications (local and firebase) *** //
                $this->notificationLocalService->createNotificationLocal($orderResult->getStoreOwner()->getStoreOwnerId(), NotificationConstant::ORDER_RETURNED_PENDING_TITLE,
                    NotificationConstant::ORDER_RETURNED_PENDING, $orderResult->getId());

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

                return $this->autoMapping->map(OrderEntity::class, OrderByIdGetForAdminResponse::class, $orderResult);
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

    public function updateOrderToHidden(int $id): OrderUpdateToHiddenResponse|string
    {
       $orderEntity = $this->adminOrderManager->updateOrderToHidden($id);
       if($orderEntity === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
           return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

       return $this->autoMapping->map(OrderEntity::class, OrderUpdateToHiddenResponse::class, $orderEntity);
    }  

    public function orderUpdateByAdmin(UpdateOrderByAdminRequest $request): string|null|OrderByIdGetForAdminResponse
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

            $order = $this->adminOrderManager->orderUpdateByAdmin($request);

            if ($order) {
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
      
        return $this->autoMapping->map(OrderEntity::class, OrderByIdGetForAdminResponse::class, $order);
      }

    public function createOrderByAdmin(OrderCreateByAdminRequest $request): string|CanCreateOrderResponse|OrderCreateByAdminResponse
    {
        $storeOwnerProfile = $this->storeOwnerProfileService->getStoreOwnerProfileEntityByIdForAdmin($request->getStoreOwner());

        if ($storeOwnerProfile === null) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $canCreateOrder = $this->subscriptionService->canCreateOrder($storeOwnerProfile->getStoreOwnerId());

        if ($canCreateOrder === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS || $canCreateOrder->canCreateOrder === SubscriptionConstant::CAN_NOT_CREATE_ORDER) {
            return $canCreateOrder;
        }

        $request->setStoreOwner($storeOwnerProfile);

        $branch = $this->storeOwnerBranchService->getBranchEntityById($request->getBranch());

        if ($branch === null) {
            return StoreOwnerBranch::BRANCH_NOT_FOUND;
        }

        $request->setBranch($branch);

        $order = $this->adminOrderManager->createOrderByAdmin($request);

        if ($order) {
            $this->subscriptionService->updateRemainingOrders($request->getStoreOwner()->getStoreOwnerId(), SubscriptionConstant::OPERATION_TYPE_SUBTRACTION);

            $this->notificationLocalService->createNotificationLocal($request->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NEW_ORDER_TITLE, NotificationConstant::CREATE_ORDER_SUCCESS,
                $order->getId());

            $this->orderTimeLineService->createOrderLogsRequest($order);
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

    public function assignOrderToCaptain(OrderAssignToCaptainByAdminRequest $request): null|OrderUpdateToHiddenResponse|int
    {
        $orderEntity = $this->adminOrderManager->getOrderById($request->getOrderId());
        if ($orderEntity) {
            if($orderEntity->getState() !==  OrderStateConstant::ORDER_STATE_PENDING) {
                return OrderStateConstant::ORDER_STATE_PENDING_INT;
            }

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
    public function orderCancelByAdmin(int $id): string|OrderCancelByAdminResponse
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

                //create local notification to store
                $this->notificationLocalService->createNotificationLocal($newUpdatedOrder->getStoreOwner()->getStoreOwnerId(), NotificationConstant::CANCEL_ORDER_TITLE,
                    NotificationConstant::CANCEL_ORDER_SUCCESS, $newUpdatedOrder->getId());

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

    public function updateOrderStateByAdmin(OrderStateUpdateByAdminRequest $request): int|OrderByIdGetForAdminResponse|null
    {
        $order = $this->adminOrderManager->updateOrderStateByAdmin($request);

        if ($order === OrderResultConstant::ORDER_IS_BEING_DELIVERED) {
            return OrderResultConstant::ORDER_IS_BEING_DELIVERED;
        }
       
        if($order) {
            if($order->getCaptainId()) {

                if( $order->getState() === OrderStateConstant::ORDER_STATE_DELIVERED) {
                    //create or update captainFinancialDues
                    $this->captainFinancialDuesService->captainFinancialDues($order->getCaptainId()->getCaptainId());
                  
                    //save the price of the order in cash in case the captain does not pay the store
                    if( $order->getPayment() === OrderTypeConstant::ORDER_PAYMENT_CASH && $order->getPaidToProvider() === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                        $this->captainAmountFromOrderCashService->createCaptainAmountFromOrderCash($order);
                        $this->storeOwnerDuesFromCashOrdersService->createStoreOwnerDuesFromCashOrders($order);
                    }
                }

                // create firebase notification to captain
                try{
                    $this->notificationFirebaseService->notificationOrderStateForUserByAdmin($order->getCaptainId()->getCaptainId(), $order->getId(), $order->getState(), NotificationConstant::CAPTAIN);
                }
                catch (\Exception $e){
                    error_log($e);
                }
            }
            // insert new order log
            $this->orderTimeLineService->createOrderLogsRequest($order, $this->storeOrderDetailsService->getStoreBranchByOrderId($order->getId()));
        }

        return $this->autoMapping->map(OrderEntity::class, OrderByIdGetForAdminResponse::class, $order);
      }
}
