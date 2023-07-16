<?php

namespace App\Service\Admin\Order;

use App\AutoMapping;
use App\Constant\Admin\AdminProfileConstant;
use App\Constant\Admin\Report\Statistics\StatisticsConstant;
use App\Constant\AppFeature\AppFeatureResultConstant;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Constant\ExternalDeliveryCompany\Mrsool\MrsoolCompanyConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaResultConstant;
use App\Constant\ExternallyDeliveredOrder\ExternallyDeliveredOrderConstant;
use App\Constant\HTTP\HttpResponseConstant;
use App\Constant\Notification\DashboardLocalNotification\DashboardLocalNotificationAppTypeConstant;
use App\Constant\Notification\DashboardLocalNotification\DashboardLocalNotificationMessageConstant;
use App\Constant\Notification\DashboardLocalNotification\DashboardLocalNotificationTitleConstant;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Notification\NotificationTokenConstant;
use App\Constant\Order\OrderCancelledByUserAndAtStateConstant;
use App\Constant\Order\OrderCostTypeConstant;
use App\Constant\Order\OrderHasPayConflictAnswersConstant;
use App\Constant\Order\OrderIsCancelConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Constant\OrderDistanceConflict\OrderDistanceConflictResolveTypeConstant;
use App\Constant\OrderLog\OrderLogActionTypeConstant;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Constant\Payment\PaymentConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\StoreOwnerBranch\StoreOwnerBranch;
use App\Constant\Subscription\SubscriptionConstant;
use App\Entity\BidDetailsEntity;
use App\Entity\CaptainEntity;
use App\Entity\CaptainFinancialDuesEntity;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Entity\OrderEntity;
use App\Entity\PackageEntity;
use App\Entity\StoreOrderDetailsEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\SubscriptionEntity;
use App\Manager\Admin\Order\AdminOrderManager;
use App\Request\Admin\Order\CaptainNotArrivedOrderFilterByAdminRequest;
use App\Request\Admin\Order\FilterDifferentlyAnsweredCashOrdersByAdminRequest;
use App\Request\Admin\Order\NormalOrderCancelByAdminRequest;
use App\Request\Admin\Order\OrderCreateByAdminRequest;
use App\Request\Admin\Order\OrderDeliveryCostUpdateByAdminRequest;
use App\Request\Admin\Order\OrderDifferentDestinationFilterByAdminRequest;
use App\Request\Admin\Order\OrderFilterByAdminRequest;
use App\Request\Admin\Order\OrderHasPayConflictAnswersUpdateByAdminRequest;
use App\Request\Admin\Order\OrderRecycleOrCancelByAdminRequest;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceAdditionByAdminRequest;
use App\Request\Admin\Order\OrderStoreBranchToClientDistanceUpdateByAddAdditionalDistanceByAdminRequest;
use App\Request\Admin\Order\RePendingAcceptedOrderByAdminRequest;
use App\Request\Admin\Order\SubOrderCreateByAdminRequest;
use App\Request\Admin\OrderDistanceConflict\OrderDistanceConflictUpdateByAdminRequest;
use App\Request\ExternallyDeliveredOrder\ExternallyDeliveredOrderStatusUpdateRequest;
use App\Response\Admin\Order\BidDetailsGetForAdminResponse;
use App\Response\Admin\Order\BidOrderGetForAdminResponse;
use App\Response\Admin\Order\CaptainNotArrivedOrderFilterResponse;
use App\Response\Admin\Order\FilterDifferentlyAnsweredCashOrdersByAdminResponse;
use App\Response\Admin\Order\OrderByIdGetForAdminResponse;
use App\Response\Admin\Order\OrderCancelByAdminResponse;
use App\Response\Admin\Order\OrderCreateByAdminResponse;
use App\Response\Admin\Order\OrderCurrentFinancialCycleByCaptainProfileIdForAdminGetResponse;
use App\Response\Admin\Order\OrderDestinationUpdateByAdminResponse;
use App\Response\Admin\Order\OrderDifferentDestinationFilterByAdminResponse;
use App\Response\Admin\Order\OrderGetForAdminResponse;
use App\Response\Admin\Order\OrderHasPayConflictAnswersUpdateByAdminResponse;
use App\Response\Admin\Order\OrderRecycleByAdminResponse;
use App\Response\Admin\Order\OrderStateUpdateByAdminResponse;
use App\Response\Admin\Order\OrderStoreBranchToClientDistanceUpdateByAdminResponse;
use App\Response\Admin\Order\OrderStoreToBranchDistanceAndDestinationUpdateByAdminResponse;
use App\Response\Admin\Order\OrderUpdateByAdminResponse;
use App\Response\Admin\OrderDistanceConflict\OrderDistanceConflictUpdateByAdminResponse;
use App\Response\Order\BidOrderByIdGetForAdminResponse;
use App\Response\OrderTimeLine\OrderLogsResponse;
use App\Response\Subscription\CanCreateOrderResponse;
use App\Service\Admin\AdminProfile\AdminProfileGetService;
use App\Service\Admin\CaptainCashOrder\AdminCaptainCashOrderService;
use App\Service\Admin\ChatRoom\OrderChatRoom\AdminOrderChatRoomService;
use App\Service\Admin\OrderDistanceConflict\AdminOrderDistanceConflictService;
use App\Service\Admin\StoreCashOrder\AdminStoreCashOrderService;
use App\Service\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyService;
use App\Service\ChatRoom\OrderChatRoomService;
use App\Service\ExternallyDeliveredOrder\ExternallyDeliveredOrderGetService;
use App\Service\ExternallyDeliveredOrder\ExternallyDeliveredOrderService;
use App\Service\ExternallyDeliveredOrderHandle\ExternallyDeliveredOrderHandleService;
use App\Service\ExternalOrderGetHandler\ExternalOrderGetHandlerService;
use App\Service\FileUpload\UploadFileHelperService;
use App\Service\GeoDistance\GeoDistanceService;
use App\Service\Notification\DashboardLocalNotification\DashboardLocalNotificationService;
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
use DateTimeInterface;
use Doctrine\ORM\EntityManagerInterface;

class AdminOrderService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private AdminOrderManager $adminOrderManager,
        private UploadFileHelperService $uploadFileHelperService,
        private OrderTimeLineService $orderTimeLineService,
        private OrderService $orderService,
        private OrderChatRoomService $orderChatRoomService,
        private StoreOrderDetailsService $storeOrderDetailsService,
        private NotificationFirebaseService $notificationFirebaseService,
        private NotificationLocalService $notificationLocalService,
        private StoreOwnerProfileService $storeOwnerProfileService,
        private SubscriptionService $subscriptionService,
        private StoreOwnerBranchService $storeOwnerBranchService,
        private CaptainFinancialDuesService $captainFinancialDuesService,
        private CaptainAmountFromOrderCashService $captainAmountFromOrderCashService,
        private StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService,
        private CaptainService $captainService,
        private OrderLogService $orderLogService,
        private AdminStoreSubscriptionService $adminStoreSubscriptionService,
        private GeoDistanceService $geoDistanceService,
        private AdminCaptainCashOrderService $adminCaptainCashOrderService,
        private AdminStoreCashOrderService $adminStoreCashOrderService,
        private AdminOrderChatRoomService $adminOrderChatRoomService,
        private DashboardLocalNotificationService $dashboardLocalNotificationService,
        private CaptainFinancialDailyService $captainFinancialDailyService,
        private AdminProfileGetService $adminProfileGetService,
        private AdminOrderDistanceConflictService $adminOrderDistanceConflictService,
        private ExternallyDeliveredOrderHandleService $externallyDeliveredOrderHandleService,
        private ExternalOrderGetHandlerService $externalOrderGetHandlerService,
        private ExternallyDeliveredOrderService $externallyDeliveredOrderService,
        private ExternallyDeliveredOrderGetService $externallyDeliveredOrderGetService
    )
    {
    }

    /**
     * Updates delivery cost of an order by order id
     */
    public function updateOrderDeliveryCost(OrderDeliveryCostUpdateByAdminRequest $request): OrderEntity|string
    {
        $orderEntity = $this->adminOrderManager->updateOrderDeliveryCost($request);

        if (! $orderEntity) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        return $orderEntity;
    }

    /**
     * Get admin profile id if admin profile exists
     */
    public function getAdminProfileIdByAdminUserId(int $adminUserId): int|string
    {
        return $this->adminProfileGetService->getAdminProfileIdByAdminUserId($adminUserId);
    }

    public function getCountOrderOngoingForAdmin(): int
    {
        return $this->adminOrderManager->getCountOrderOngoingForAdmin();
    }

    public function getAllOrdersCountForAdmin(): int
    {
        return $this->adminOrderManager->getAllOrdersCountForAdmin();
    }

    public function filterStoreOrdersByAdmin(OrderFilterByAdminRequest $request, int $adminUserId): ?array
    {
        $response = [];
        // 1 Get uncancelled and undelivered external orders from OrderEntity
        $orders = $this->getNotCancelledNorDeliveredNorExpiredExternalOrdersOnly($request->getExternalCompanyId());

        if (count($orders) > 0) {
            foreach ($orders as $order) {
                // 2 Get external order new info from their related external company
                $externallyDeliveredOrders = $order->getExternallyDeliveredOrderEntities()->toArray();

                if (count($externallyDeliveredOrders) > 0) {
                    foreach ($externallyDeliveredOrders as $externallyDeliveredOrder) {
                        if (in_array($externallyDeliveredOrder->getStatus(), MrsoolCompanyConstant::NOT_CANCELLED_OR_DELIVERED_OR_EXPIRED_CONST)) {
                            $externalOrderInfo = $this->getExternalOrderByOrderIdAndExternalDeliveryCompanyId($externallyDeliveredOrder->getExternalOrderId(),
                                $externallyDeliveredOrder->getExternalDeliveryCompany()->getId());

                            if (($externalOrderInfo !== HttpResponseConstant::INVALID_CREDENTIALS_RESULT_CONST)
                                && ($externalOrderInfo !== HttpResponseConstant::ORDER_NOT_FOUND_RESULT_CONST)
                                && ($externalOrderInfo !== HttpResponseConstant::UN_RECOGNIZED_STATUS_CODE_RESULT_CONST)) {
                                // 3 Update external orders status (both in ExternallyDeliveredOrderEntity and OrderEntity)
                                $this->updateExternallyDeliveredOrderStatus($externallyDeliveredOrder->getId(),
                                    $externalOrderInfo['data']['status']);
                                // Update order status in OrderEntity
                                $this->compareAndUpdateOrderState($order, $externalOrderInfo['data']['status']);

                                // save log of the action on order
                                $this->createOrderLogMessageViaOrderEntityAndByAdmin($order, $adminUserId,
                                    OrderLogActionTypeConstant::NORMAL_ORDER_STATUS_UPDATE_BY_FETCHING_IT_FROM_EXTERNAL_COMPANY_CONST,
                                    ['externalCompanyName' => $externallyDeliveredOrder->getExternalDeliveryCompany()->getCompanyName()]);
                            }
                        }
                    }
                }
            }
        }

        $orders = $this->adminOrderManager->filterStoreOrdersByAdmin($request);

        foreach ($orders as $key => $value) {
            $value['images'] = $this->uploadFileHelperService->getImageParams($value['images']);

            $response[$key] = $this->autoMapping->map(OrderEntity::class, OrderGetForAdminResponse::class, $value[0]);

            $response[$key]->storeOrderDetailsId = $value['storeOrderDetailsId'];
            $response[$key]->destination = $value['destination'];
            $response[$key]->recipientName = $value['recipientName'];
            $response[$key]->recipientPhone = $value['recipientPhone'];
            $response[$key]->branchName = $value['branchName'];
            $response[$key]->location = $value['location'];
            $response[$key]->storeOwnerBranchId = $value['storeOwnerBranchId'];
            $response[$key]->detail = $value['detail'];
            $response[$key]->imageId = $value['imageId'];
            $response[$key]->captainProfileId = $value['captainProfileId'];

            $externallyDeliveredOrders = $value[0]->getExternallyDeliveredOrderEntities()->toArray();

            $externalOrdersArrayLength = count($externallyDeliveredOrders);

            if ($externalOrdersArrayLength > 0) {
                $lastOrder = $externallyDeliveredOrders[$externalOrdersArrayLength-1];

                //foreach ($externallyDeliveredOrders as $key2 => $value2) {
                $response[$key]->externalDeliveredOrders = [];

                $response[$key]->externalDeliveredOrders[0]['id'] = $lastOrder->getId();
                $response[$key]->externalDeliveredOrders[0]['companyName'] = $lastOrder->getExternalDeliveryCompany()->getCompanyName();
                $response[$key]->externalDeliveredOrders[0]['externalOrderId'] = $lastOrder->getExternalOrderId();
                //}
            }
        }

        return $response;
    }

    public function getAllExternallyDeliveredOrdersByOrderId(int $orderId): int|array
    {
        $externallyDeliveredOrders = $this->externallyDeliveredOrderGetService->getAllExternallyDeliveredOrdersByOrderId($orderId);

        if (count($externallyDeliveredOrders) === 0) {
            return ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST;
        }

        return $externallyDeliveredOrders;
    }

    /**
     * Gets specific order details with store and captain info by order id for admin
     */
    public function getSpecificOrderByIdForAdmin(int $id, ?string $timeZone = null): ?OrderByIdGetForAdminResponse
    {
        if (($timeZone) && ($timeZone !== "")) {
            $timeZone = str_replace("-", "/", $timeZone);
        }

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

            if ($order['storeSubscription']) {
                if ($order['storeSubscription']->getPackage() instanceof PackageEntity) {
                    $order['packageId'] = $order['storeSubscription']->getPackage()->getId();
                    $order['packageType'] = $order['storeSubscription']->getPackage()->getType();
                }
            }

            $externallyDeliveredOrders = $this->getAllExternallyDeliveredOrdersByOrderId($order['id']);

            if ($externallyDeliveredOrders !== ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST) {
                foreach ($externallyDeliveredOrders as $key => $value) {
                    $order['externalDeliveredOrders'][$key]['id'] = $value->getId();
                    $order['externalDeliveredOrders'][$key]['companyName'] = $value->getExternalDeliveryCompany()->getCompanyName();
                    $order['externalDeliveredOrders'][$key]['externalOrderId'] = $value->getExternalOrderId();
                }
            }

            $order['deliveryDate']->setTimeZone(new \DateTimeZone($timeZone ? : 'Asia/Riyadh'));
            $order['createdAt']->setTimeZone(new \DateTimeZone($timeZone ? : 'Asia/Riyadh'));
            $order['updatedAt']->setTimeZone(new \DateTimeZone($timeZone ? : 'Asia/Riyadh'));
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

    public function getExternalOrderByOrderIdAndExternalDeliveryCompanyId(int $orderId, int $externalDeliveryCompanyId): int|array
    {
        return $this->externalOrderGetHandlerService->getExternalOrderByOrderIdAndExternalDeliveryCompanyId($orderId,
            $externalDeliveryCompanyId);
    }

    /**
     * Get uncancelled, undelivered, and not expired external orders from OrderEntity
     */
    public function getNotCancelledNorDeliveredNorExpiredExternalOrdersOnly(?int $externalCompanyId): array
    {
        return $this->adminOrderManager->getNotCancelledNorDeliveredNorExpiredExternalOrdersOnly($externalCompanyId);
    }

    /**
     * Updates the status of the order in ExternallyDeliveredOrderEntity
     */
    public function updateExternallyDeliveredOrderStatus(int $externallyDeliveredOrderId, string $status): int|ExternallyDeliveredOrderEntity
    {
        $externallyDeliveredOrderStatusUpdateRequest = new ExternallyDeliveredOrderStatusUpdateRequest();

        $externallyDeliveredOrderStatusUpdateRequest->setId($externallyDeliveredOrderId);
        $externallyDeliveredOrderStatusUpdateRequest->setStatus($status);

        return $this->externallyDeliveredOrderService->updateExternallyDeliveredOrderStatus($externallyDeliveredOrderStatusUpdateRequest);
    }

    public function getExternallyDeliveredOrdersByStatus(string $status): array
    {
        return $this->externallyDeliveredOrderGetService->getExternallyDeliveredOrdersByStatus($status);
    }

    public function getOnGoingExternallyDeliveredOrders(): array
    {
        return $this->externallyDeliveredOrderGetService->getOnGoingExternallyDeliveredOrders();
    }

    public function prepareOrderResponseObjectFromExternallyDeliveredOrders(array $orders, ?string $timeZone = null): array
    {
        $response = [];

        if (! empty($orders)) {
            foreach ($orders as $key => $value) {
                $orderEntity = $value->getOrderId();
                $storeOrderDetails = $value->getOrderId()->getStoreOrderDetailsEntity();

                $response[$key] = $this->autoMapping->map(OrderEntity::class, OrderPendingResponse::class,
                    $orderEntity);

                $response[$key]->deliveryDate->setTimeZone(new \DateTimeZone($timeZone ? : 'Asia/Riyadh'));
                $response[$key]->createdAt->setTimeZone(new \DateTimeZone($timeZone ? : 'Asia/Riyadh'));
                //$response[$key]->state = $value->getStatus();
                $response[$key]->location = $storeOrderDetails->getBranch()->getLocation();
                $response[$key]->storeOwnerBranchId = $storeOrderDetails->getBranch()->getId();
                $response[$key]->branchName = $storeOrderDetails->getBranch()->getName();
                $response[$key]->storeOwnerName = $orderEntity->getStoreOwner()->getStoreOwnerName();

                if ($orderEntity->getCaptainId()) {
                    $response[$key]->captainName = $orderEntity->getCaptainId()->getCaptainName();
                    $response[$key]->captainProfileId = $orderEntity->getCaptainId()->getId();
                }

                $bidOrderDetailsEntity = $orderEntity->getBidDetailsEntity();

                if ($bidOrderDetailsEntity) {
                    if ($bidOrderDetailsEntity->getBranch()) {
                        $response[$key]->branchName = $bidOrderDetailsEntity->getBranch()->getName();
                        $response[$key]->location = $bidOrderDetailsEntity->getBranch()->getLocation();
                    }

                    $response[$key]->sourceDestination = $value->getBidDetailsEntity()->getSourceDestination();
                }

                $externallyDeliveredOrders = $orderEntity->getExternallyDeliveredOrderEntities()->toArray();

//                if (count($externallyDeliveredOrders) > 0) {
//                    foreach ($externallyDeliveredOrders as $key2 => $value2) {
//                        $response[$key]->externalDeliveredOrders[$key2]['id'] = $value2->getId();
//                        $response[$key]->externalDeliveredOrders[$key2]['companyName'] = $value2->getExternalDeliveryCompany()->getCompanyName();
//                        $response[$key]->externalDeliveredOrders[$key2]['externalOrderId'] = $value2->getExternalOrderId();
//                    }
//                }

                $externalOrdersArrayLength = count($externallyDeliveredOrders);

                if ($externalOrdersArrayLength > 0) {
                    $lastOrder = $externallyDeliveredOrders[$externalOrdersArrayLength-1];

                    //foreach ($externallyDeliveredOrders as $key2 => $value2) {
                    $response[$key]->externalDeliveredOrders = [];

                    $response[$key]->externalDeliveredOrders[0]['id'] = $lastOrder->getId();
                    $response[$key]->externalDeliveredOrders[0]['companyName'] = $lastOrder->getExternalDeliveryCompany()->getCompanyName();
                    $response[$key]->externalDeliveredOrders[0]['externalOrderId'] = $lastOrder->getExternalOrderId();
                    //}
                }
            }
        }

        return $response;
    }

    public function updateOrderStatusByOrderEntityAndNewStatus(OrderEntity $orderEntity, string $status): OrderEntity
    {
        return $this->adminOrderManager->updateOrderStatusByOrderEntityAndNewStatus($orderEntity, $status);
    }

    public function compareAndUpdateOrderState(OrderEntity $orderEntity, string $externalStatus): OrderEntity
    {
        // 1 compare status
        $orderStatus = $orderEntity->getState();

        if (($externalStatus === MrsoolCompanyConstant::COURIER_PENDING_ORDER_STATUS_CONST)
            || ($externalStatus === MrsoolCompanyConstant::EXPIRED_ORDER_STATUS_CONST)) {
            $orderStatus = OrderStateConstant::ORDER_STATE_PENDING;

        } elseif ($externalStatus === MrsoolCompanyConstant::COLLECTING_ORDER_STATUS_CONST) {
            $orderStatus = OrderStateConstant::ORDER_STATE_ON_WAY;

        } elseif (($externalStatus === MrsoolCompanyConstant::DELIVERING_ORDER_STATUS_CONST)
            || ($externalStatus === MrsoolCompanyConstant::DROPOFF_ARRIVED_ORDER_STATUS_CONST)) {
            $orderStatus = OrderStateConstant::ORDER_STATE_ONGOING;

        } elseif ($externalStatus === MrsoolCompanyConstant::CANCELED_ORDER_STATUS_CONST) {
            $orderStatus = OrderStateConstant::ORDER_STATE_CANCEL;

        } elseif ($externalStatus === MrsoolCompanyConstant::DELIVERED_ORDER_STATUS_CONST) {
            $orderStatus = OrderStateConstant::ORDER_STATE_DELIVERED;
        }

        // 2 update order status
        return $this->updateOrderStatusByOrderEntityAndNewStatus($orderEntity, $orderStatus);
    }
        
    public function getPendingOrdersForAdmin(int $userId, int $externalOrder, ?int $externalCompanyId, ?string $timeZone = null): array
    {
        if (($timeZone) && ($timeZone !== "")) {
            $timeZone = str_replace("-", "/", $timeZone);
        }

        $response = [];
        $response['pendingOrders'] = [];
        $response['notDeliveredOrders'] = [];

        // 1 Get external orders (which are not cancelled nor delivered)
        $orders = $this->getNotCancelledNorDeliveredNorExpiredExternalOrdersOnly($externalCompanyId);

        if (count($orders) > 0) {
            foreach ($orders as $order) {
                // 2 Foreach order get its external status
                $externallyDeliveredOrders = $order->getExternallyDeliveredOrderEntities()->toArray();

                if (count($externallyDeliveredOrders) > 0) {
                    foreach ($externallyDeliveredOrders as $externallyDeliveredOrder) {
                        if (in_array($externallyDeliveredOrder->getStatus(), MrsoolCompanyConstant::NOT_CANCELLED_OR_DELIVERED_OR_EXPIRED_CONST)) {
                            $externalOrderInfo = $this->getExternalOrderByOrderIdAndExternalDeliveryCompanyId($externallyDeliveredOrder->getExternalOrderId(),
                                $externallyDeliveredOrder->getExternalDeliveryCompany()->getId());

                            if (($externalOrderInfo !== HttpResponseConstant::INVALID_CREDENTIALS_RESULT_CONST)
                                && ($externalOrderInfo !== HttpResponseConstant::ORDER_NOT_FOUND_RESULT_CONST)
                                && ($externalOrderInfo !== HttpResponseConstant::UN_RECOGNIZED_STATUS_CODE_RESULT_CONST)) {

                                // 3 Update order status in ExternallyDeliveredOrderEntity
                                $this->updateExternallyDeliveredOrderStatus($externallyDeliveredOrder->getId(),
                                    $externalOrderInfo['data']['status']);
                                // 4 Update order status in OrderEntity
                                $this->compareAndUpdateOrderState($order, $externalOrderInfo['data']['status']);

                                // save log of the action on order
                                $this->createOrderLogMessageViaOrderEntityAndByAdmin($order, $userId,
                                    OrderLogActionTypeConstant::NORMAL_ORDER_STATUS_UPDATE_BY_FETCHING_IT_FROM_EXTERNAL_COMPANY_CONST,
                                    ['externalCompanyName' => $externallyDeliveredOrder->getExternalDeliveryCompany()->getCompanyName()]);
                            }
                        }
                    }
                }
            }
            // 4 Return external orders according to their external status
            $response['pendingOrders'] = $this->prepareOrderResponseObjectFromExternallyDeliveredOrders($this->getExternallyDeliveredOrdersByStatus(MrsoolCompanyConstant::COURIER_PENDING_ORDER_STATUS_CONST),
                $timeZone);
            $response['notDeliveredOrders'] = $this->prepareOrderResponseObjectFromExternallyDeliveredOrders($this->getOnGoingExternallyDeliveredOrders(),
                $timeZone);
        }

        $response['pendingOrdersCount'] = count($response['pendingOrders']);
        $response['notDeliveredOrdersCount'] = count($response['notDeliveredOrders']);

        $response['totalOrderCount'] = $response['pendingOrdersCount'] + $response['notDeliveredOrdersCount'];

        if ($externalOrder === 0) {
            $this->orderService->showSubOrderIfCarIsAvailable($userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST);
            $this->orderService->hideOrderExceededDeliveryTimeByHour($userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST);

            $response['pendingOrders'] = array_merge($response['pendingOrders'],
                $this->prepareOrderResponseObject($this->adminOrderManager->getPendingOrdersForAdmin($externalOrder),
                    $timeZone));

            $response['hiddenOrders'] = $this->prepareOrderResponseObject($this->adminOrderManager->getHiddenOrdersForAdmin($externalOrder),
                $timeZone);

            $response['notDeliveredOrders'] = array_merge($response['notDeliveredOrders'],
                $this->prepareOrderResponseObject($this->adminOrderManager->getNotDeliveredOrdersForAdmin($externalOrder),
                    $timeZone));

            $response['pendingOrdersCount'] = count($response['pendingOrders']);
            $response['hiddenOrdersCount'] = count($response['hiddenOrders']);
            $response['notDeliveredOrdersCount'] = count($response['notDeliveredOrders']);

            $response['totalOrderCount'] = $response['pendingOrdersCount'] + $response['hiddenOrdersCount'] + $response['notDeliveredOrdersCount'];
        }

        return $response;
    }

    public function prepareOrderResponseObject(array $orders, ?string $timeZone = null): array
    {
        $response = [];

        if (! empty($orders)) {
            foreach ($orders as $key => $value) {
                $value['subOrder'] = $this->orderService->getSubOrdersByPrimaryOrderId($value[0]->getId());

                $response[$key] = $this->autoMapping->map(OrderEntity::class, OrderPendingResponse::class, $value[0]);

                $response[$key]->deliveryDate->setTimeZone(new \DateTimeZone($timeZone ? : 'Asia/Riyadh'));
                $response[$key]->createdAt->setTimeZone(new \DateTimeZone($timeZone ? : 'Asia/Riyadh'));

                $response[$key]->location = $value['location'];
                $response[$key]->storeOwnerBranchId = $value['storeOwnerBranchId'];
                $response[$key]->branchName = $value['branchName'];
                $response[$key]->storeOwnerName = $value[0]->getStoreOwner()->getStoreOwnerName();

                if ($value[0]->getCaptainId()) {
                    $response[$key]->captainName = $value[0]->getCaptainId()->getCaptainName();
                    $response[$key]->captainProfileId = $value[0]->getCaptainId()->getId();
                }

                $bidOrderDetailsEntity = $value[0]->getBidDetailsEntity();

                if ($bidOrderDetailsEntity) {
                    if ($bidOrderDetailsEntity->getBranch()) {
                        $response[$key]->branchName = $bidOrderDetailsEntity->getBranch()->getName();
                        $response[$key]->location = $bidOrderDetailsEntity->getBranch()->getLocation();
                    }

                    $response[$key]->sourceDestination = $value->getBidDetailsEntity()->getSourceDestination();
                }

                $externallyDeliveredOrders = $value[0]->getExternallyDeliveredOrderEntities()->toArray();

//                if (count($externallyDeliveredOrders) > 0) {
//                    foreach ($externallyDeliveredOrders as $key2 => $value2) {
//                        $response[$key]->externalDeliveredOrders[$key2]['id'] = $value2->getId();
//                        $response[$key]->externalDeliveredOrders[$key2]['companyName'] = $value2->getExternalDeliveryCompany()->getCompanyName();
//                        $response[$key]->externalDeliveredOrders[$key2]['externalOrderId'] = $value2->getExternalOrderId();
//                    }
//                }

                $externalOrdersArrayLength = count($externallyDeliveredOrders);

                if ($externalOrdersArrayLength > 0) {
                    $lastOrder = $externallyDeliveredOrders[$externalOrdersArrayLength-1];

                    //foreach ($externallyDeliveredOrders as $key2 => $value2) {
                    $response[$key]->externalDeliveredOrders = [];

                    $response[$key]->externalDeliveredOrders[0]['id'] = $lastOrder->getId();
                    $response[$key]->externalDeliveredOrders[0]['companyName'] = $lastOrder->getExternalDeliveryCompany()->getCompanyName();
                    $response[$key]->externalDeliveredOrders[0]['externalOrderId'] = $lastOrder->getExternalOrderId();
                    //}
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
                    OrderLogActionTypeConstant::UN_ASSIGN_ORDER_TO_CAPTAIN_BY_ADMIN_ACTION_CONST, [], null,
                    null);

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

    /**
     * Get the count of delivered orders between two dates
     */
    public function getDeliveredOrdersCountBetweenTwoDatesForAdmin(DateTime $fromDate, DateTime $toDate, string $customizedTimezone = null): int
    {
        $result = $this->adminOrderManager->getDeliveredOrdersBetweenTwoDatesForAdmin($fromDate, $toDate, $customizedTimezone);

        if (is_array($result)) {
            return count($result);
        }

        return StatisticsConstant::ZERO_VALUE_CONST;
    }

    public function updateOrderToHidden(int $id, int $userId): OrderUpdateToHiddenResponse|string
    {
       $orderEntity = $this->adminOrderManager->updateOrderToHidden($id);

       if($orderEntity === OrderResultConstant::ORDER_NOT_FOUND_RESULT) {
           return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($orderEntity, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::HIDE_ORDER_WHILE_UPDATING_BY_ADMIN_ACTION_CONST, [], null,
            null);

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
                    OrderLogActionTypeConstant::UPDATE_ORDER_BY_ADMIN_ACTION_CONST, [], null,
                    null);

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
                OrderLogActionTypeConstant::CREATE_ORDER_BY_ADMIN_ACTION_CONST, [], $branch->getId(),
                null);

            // send order to external delivery company
            $externalOrder = $this->sendOrderToExternalDeliveryCompany($order);

            if (($externalOrder !== AppFeatureResultConstant::APP_FEATURE_NOT_FOUND_CONST)
                && ($externalOrder !== AppFeatureResultConstant::APP_FEATURE_NOT_ACTIVATED_CONST)
                && ($externalOrder !== ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST)
                && ($externalOrder !== ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST)
                && ($externalOrder !== ExternalDeliveryCompanyCriteriaResultConstant::ORDER_DOES_NOT_MATCH_CRITERIA_RESULT)
                && ($externalOrder !== ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_IS_NOT_REGISTERED_CONST)
                && ($externalOrder !== HttpResponseConstant::INVALID_CREDENTIALS_RESULT_CONST)
                && ($externalOrder !== HttpResponseConstant::INVALID_INPUT_RESULT_CODE_CONST)
                && ($externalOrder !== HttpResponseConstant::UN_RECOGNIZED_STATUS_CODE_RESULT_CONST)) {
                // save log of the action on order
                $this->createOrderLogMessageViaOrderEntityAndByAdmin($order, $userId,
                    OrderLogActionTypeConstant::AUTOMATIC_SENDING_NORMAL_ORDER_EXTERNALLY_CONST,
                    ['externalCompanyName' => $externalOrder->getExternalDeliveryCompany()->getCompanyName()]);
            }

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
                $this->notificationLocalService->createNotificationLocalForOrderState($order->getStoreOwner()->getStoreOwnerId(),
                    NotificationConstant::STATE_TITLE, $order->getState(), NotificationConstant::STORE, $order->getId(),
                    $order->getCaptainId()->getId());

                //create Notification Local for captain
                $this->notificationLocalService->createNotificationLocalForOrderState($order->getCaptainId()->getCaptainId(),
                    NotificationConstant::STATE_TITLE, $order->getState(), NotificationConstant::CAPTAIN, $order->getId());

                //create order log
                $this->orderTimeLineService->createOrderLogsRequest($order);

                // save log of the action on order
                $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::ASSIGN_ORDER_TO_CAPTAIN_BY_ADMIN_ACTION_CONST, [], null ,
                    null);

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

    /**
     * This function currently cancel NORMAL order exclusively (not a bid order)
     * (2nd version)
     */
    public function cancelNormalOrderByAdmin(NormalOrderCancelByAdminRequest $request, int $userId): string|OrderCancelByAdminResponse|int
    {
        $orderEntity = $this->adminOrderManager->getOrderByIdForAdmin($request->getId());

        if (! $orderEntity) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        // if order of type bid, then use another api in order to cancel it
        if ($orderEntity->getOrderType() === OrderTypeConstant::ORDER_TYPE_BID) {
            return OrderResultConstant::ORDER_TYPE_BID;
        }

        // start transaction commit ...
        $this->entityManager->getConnection()->beginTransaction();

        try {
            if ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_PENDING) {
                // 1. Update order state
                $newUpdatedOrder = $this->adminOrderManager->updateOrderStatusToCancelled($orderEntity);

                // 2. Update store subscription (remaining orders), if order relate
                if ($newUpdatedOrder) {
                    $this->updateRemainingOrdersOfStoreSubscriptionByAdmin($newUpdatedOrder->getStoreOwner()->getId(),
                        $newUpdatedOrder->getCreatedAt(), SubscriptionConstant::OPERATION_TYPE_ADDITION, 1);

                    // 3. Create log
                    $this->createOrderLogViaOrderEntity($newUpdatedOrder);

                    $this->createOrderLogMessageAboutOrderCancelViaOrderEntityAndByAdmin($newUpdatedOrder, $userId, []);

                    // 4. Send notifications
                    // local notification to store
                    $this->createLocalNotificationForStore($newUpdatedOrder->getStoreOwner()->getStoreOwnerId(), NotificationConstant::CANCEL_ORDER_TITLE,
                        NotificationConstant::CANCEL_ORDER_SUCCESS, $newUpdatedOrder->getId());

                    // Create local notification for admin
                    $this->createDashboardLocalNotification(DashboardLocalNotificationTitleConstant::CANCEL_ORDER_BY_ADMIN_TITLE_CONST,
                        ['text' => DashboardLocalNotificationMessageConstant::CANCEL_ORDER_BY_ADMIN_TEXT_CONST . $newUpdatedOrder->getId()],
                        $userId, $newUpdatedOrder->getId());

                    // ... commit the transaction
                    $this->entityManager->getConnection()->commit();

                    // firebase notification to store
                    $this->sendFirebaseNotificationAboutOrderStateForUserByAdmin($newUpdatedOrder->getStoreOwner()->getStoreOwnerId(), $newUpdatedOrder->getId(), $newUpdatedOrder->getState(),
                        NotificationConstant::STORE);

                    return $this->autoMapping->map(OrderEntity::class, OrderCancelByAdminResponse::class, $newUpdatedOrder);
                }

                return OrderResultConstant::ORDER_UPDATE_PROBLEM;

            } elseif ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_ON_WAY) {
                // 1. Update order state and other info
                $arrayResult = $this->adminOrderManager->updateOngoingOrderToCancelled($orderEntity);

                if ($arrayResult[0]) {
                    // 2. Delete the chat room of the order
                    $this->deleteChatRoomByOrderId($arrayResult[0]->getId());

                    // 3. Update store subscription (remaining orders + remaining cars), if order relate
                    $this->updateRemainingOrdersOfStoreSubscriptionByAdmin($arrayResult[0]->getStoreOwner()->getId(), $arrayResult[0]->getCreatedAt(),
                        SubscriptionConstant::OPERATION_TYPE_ADDITION, 1);

                    $this->updateRemainingCarsOfStoreSubscriptionByAdmin($arrayResult[0]->getStoreOwner()->getId(), $arrayResult[0]->getCreatedAt(),
                        SubscriptionConstant::OPERATION_TYPE_ADDITION, 1);

                    // 4. Create log
                    $this->createOrderLogViaOrderEntity($arrayResult[0]);

                    $this->createOrderLogMessageAboutOrderCancelViaOrderEntityAndByAdmin($arrayResult[0], $userId, []);

                    // 5. Send notifications
                    // local notification to store
                    $this->createLocalNotificationForStore($arrayResult[0]->getStoreOwner()->getStoreOwnerId(), NotificationConstant::CANCEL_ORDER_TITLE,
                        NotificationConstant::CANCEL_ORDER_SUCCESS, $arrayResult[0]->getId());

                    // local notification to captain
                    $this->createLocalNotificationForCaptain($arrayResult[1]->getCaptainId(), NotificationConstant::CANCEL_ORDER_TITLE,
                        NotificationConstant::CANCEL_ORDER_SUCCESS, $arrayResult[0]->getId());

                    // Create local notification for admin
                    $this->createDashboardLocalNotification(DashboardLocalNotificationTitleConstant::CANCEL_ORDER_BY_ADMIN_TITLE_CONST,
                        ['text' => DashboardLocalNotificationMessageConstant::CANCEL_ORDER_BY_ADMIN_TEXT_CONST . $arrayResult[0]->getId()],
                        $userId, $arrayResult[0]->getId());

                    // ... commit the transaction
                    $this->entityManager->getConnection()->commit();

                    // firebase notification to store
                    $this->sendFirebaseNotificationAboutOrderStateForUserByAdmin($arrayResult[0]->getStoreOwner()->getStoreOwnerId(),
                        $arrayResult[0]->getId(), $arrayResult[0]->getState(), NotificationConstant::STORE);

                    // firebase notification to captain
                    $this->sendFirebaseNotificationAboutOrderStateForUserByAdmin($arrayResult[1]->getCaptainId(), $arrayResult[0]->getId(),
                        $arrayResult[0]->getState(), NotificationConstant::CAPTAIN);

                    return $this->autoMapping->map(OrderEntity::class, OrderCancelByAdminResponse::class, $arrayResult[0]);
                }

                return OrderResultConstant::ORDER_UPDATE_PROBLEM;

            } elseif (in_array($orderEntity->getState(), OrderStateConstant::ORDER_STATE_ONGOING_TILL_DELIVERED_ARRAY)) {
                // 1. Update order state and other info
                if ($request->getAddHalfOrderValueToCaptainFinancialDue() === true) {
                    // As long as it required to add half financial value of the order to captain due
                    // then, we won't remove captain from order record.
                    // Also, we have to know at which state the admin cancelled the order
                    $orderCancelledByAdminAndAtState = OrderCancelledByUserAndAtStateConstant::ORDER_CANCEL_USER_AND_STATE_ARRAY['ORDER_CANCELLED_BY_ADMIN_AND_AT_IN_STORE_STATE_CONST'];

                    if ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_ONGOING) {
                        $orderCancelledByAdminAndAtState = OrderCancelledByUserAndAtStateConstant::ORDER_CANCEL_USER_AND_STATE_ARRAY['ORDER_CANCELLED_BY_ADMIN_AND_AT_ONGOING_STATE_CONST'];

                    } elseif ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_DELIVERED) {
                        $orderCancelledByAdminAndAtState = OrderCancelledByUserAndAtStateConstant::ORDER_CANCEL_USER_AND_STATE_ARRAY['ORDER_CANCELLED_BY_ADMIN_AND_AT_DELIVERED_STATE_CONST'];
                    }

                    $arrayResult = $this->adminOrderManager->updateOngoingOrderToCancelledWithoutRemovingCaptain($orderEntity,
                        $orderCancelledByAdminAndAtState);

                } else {
                    // while it isn't required to add half financial value of the order to captain due
                    // then, we can update order state and remove the captain as well from the order record
                    $arrayResult = $this->adminOrderManager->updateOngoingOrderToCancelled($orderEntity);
                }

                if ($arrayResult[0]) {
                    // 2. Delete the chat room of the order
                    $this->deleteChatRoomByOrderId($arrayResult[0]->getId());

                    // 3. Check if admin requested to cut the order from the store subscription or not
                    if ($request->getCutOrderFromStoreSubscription() !== true) {
                        // Update store subscription (remaining orders + remaining cars), if order relate
                        $this->updateRemainingOrdersOfStoreSubscriptionByAdmin($arrayResult[0]->getStoreOwner()->getId(),
                            $arrayResult[0]->getCreatedAt(), SubscriptionConstant::OPERATION_TYPE_ADDITION, 1);

                        if ($orderEntity->getState() === OrderStateConstant::ORDER_STATE_DELIVERED) {
                            // Delete cash dues and update payments - if exist/s - of the store
                            $this->deleteStoreDuesFromCashOrderAndUpdatePaymentByStoreOwnerProfileIdAndOrderId($arrayResult[0]->getStoreOwner()->getId(),
                                $arrayResult[0]->getId(), $arrayResult[0]->getPayment());

                            // Delete cash amount and update payments - if exist/s - of the captain
                            // note: here we pass the order id and creation date just for updating the exact financial cycle
                            // that the order belongs to
                            $this->deleteCaptainAmountFromCashOrderAndUpdatePaymentByCaptainProfileIdAndOrderId($arrayResult[1]->getId(),
                                $arrayResult[0]->getId(), $arrayResult[0]->getPayment());
                        }
                    }

                    // 4. If order isn't delivered yet, then update the remaining cars (because the captain returned available)
                    if ($orderEntity->getState() !== OrderStateConstant::ORDER_STATE_DELIVERED) {
                        $this->updateRemainingCarsOfStoreSubscriptionByAdmin($arrayResult[0]->getStoreOwner()->getId(),
                            $arrayResult[0]->getCreatedAt(), SubscriptionConstant::OPERATION_TYPE_ADDITION, 1);
                    }

                    // 5. Update captain financial dues (re-calculate them actually)
                    $this->createOrUpdateCaptainFinancialDues($arrayResult[1]->getCaptainId(), $arrayResult[0]->getId(),
                        $arrayResult[0]->getCreatedAt());

                    // 6. Update daily captain financial amount
                    $this->createOrUpdateCaptainFinancialDaily($arrayResult[0]->getId(), $arrayResult[1]);

                    // 7. Create log
                    $this->createOrderLogViaOrderEntity($arrayResult[0]);

                    $this->createOrderLogMessageAboutOrderCancelViaOrderEntityAndByAdmin($arrayResult[0], $userId, []);

                    // 8. Send notifications
                    // local notification to store
                    $this->createLocalNotificationForStore($arrayResult[0]->getStoreOwner()->getStoreOwnerId(), NotificationConstant::CANCEL_ORDER_TITLE,
                        NotificationConstant::CANCEL_ORDER_SUCCESS, $arrayResult[0]->getId());

                    // local notification to captain
                    $this->createLocalNotificationForCaptain($arrayResult[1]->getCaptainId(), NotificationConstant::CANCEL_ORDER_TITLE,
                        NotificationConstant::CANCEL_ORDER_SUCCESS, $arrayResult[0]->getId());

                    // Create local notification for admin
                    $this->createDashboardLocalNotification(DashboardLocalNotificationTitleConstant::CANCEL_ORDER_BY_ADMIN_TITLE_CONST,
                        ['text' => DashboardLocalNotificationMessageConstant::CANCEL_ORDER_BY_ADMIN_TEXT_CONST . $arrayResult[0]->getId()],
                        $userId, $arrayResult[0]->getId());

                    // ... commit the transaction
                    $this->entityManager->getConnection()->commit();

                    // firebase notification to store
                    $this->sendFirebaseNotificationAboutOrderStateForUserByAdmin($arrayResult[0]->getStoreOwner()->getStoreOwnerId(),
                        $arrayResult[0]->getId(), $arrayResult[0]->getState(), NotificationConstant::STORE);

                    // firebase notification to captain
                    $this->sendFirebaseNotificationAboutOrderStateForUserByAdmin($arrayResult[1]->getCaptainId(), $arrayResult[0]->getId(),
                        $arrayResult[0]->getState(), NotificationConstant::CAPTAIN);

                    return $this->autoMapping->map(OrderEntity::class, OrderCancelByAdminResponse::class, $arrayResult[0]);
                }

                return OrderResultConstant::ORDER_UPDATE_PROBLEM;

            } else {
                // Order is already being cancelled
                return OrderResultConstant::ORDER_ALREADY_BEING_CANCELLED;
            }

        } catch (\Exception $e) {
            // ... roll back the started transaction
            $this->entityManager->getConnection()->rollBack();

            throw $e;
        }
    }

    public function updateOrderStateByAdmin(OrderStateUpdateByAdminRequest $request, int $userId): int|OrderStateUpdateByAdminResponse|null
    {
        // Check if cancelling the order is what required, if it is, prevent it
        if ($request->getState() === OrderStateConstant::ORDER_STATE_CANCEL) {
            return OrderResultConstant::ORDER_CANCEL_NOT_ALLOWED_DUE_TO_WRONG_API;
        }

        // Check order visibility before updating its status
        $visibility = $this->getOrderIsHideByOrderId($request->getId());

        if (($visibility === OrderIsHideConstant::ORDER_HIDE_TEMPORARILY) || ($visibility === OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE)) {
            return OrderResultConstant::ORDER_IS_HIDDEN_CONST;
        }

        $orderResult = $this->adminOrderManager->updateOrderStateByAdmin($request);

        if (!$orderResult) {
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
                        if ($this->checkCashOrderCostPaidToStoreOrNotByOrderEntity($orderResult[0])) {
                            $this->captainAmountFromOrderCashService->createCaptainAmountFromOrderCash($orderResult[0],
                                OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO, $orderResult[0]->getOrderCost());

                            $this->storeOwnerDuesFromCashOrdersService->createStoreOwnerDuesFromCashOrders($orderResult[0],
                                OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO, $orderResult[0]->getOrderCost());
                        }

                        // Create or update daily captain financial amount
                        $this->createOrUpdateCaptainFinancialDaily($orderResult[0]->getId());
                        // Update subscription cost of the store's subscription
                        $this->handleUpdatingStoreSubscriptionCost($orderResult[0]->getStoreOwner()->getId(),
                            $orderResult[0]->getDeliveryCost(), $orderResult[0]->getCreatedAt());
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
                            NotificationConstant::ORDER_UNASSIGNED_TO_CAPTAIN . $orderResult[0]->getId(),
                            NotificationTokenConstant::APP_TYPE_CAPTAIN, $orderResult[0]->getId());
                    }
                }
                // insert new order log
                $this->orderTimeLineService->createOrderLogsRequest($orderResult[0], $this->storeOrderDetailsService->getStoreBranchByOrderId($orderResult[0]->getId()));

                // save log of the action on order
                $this->orderLogService->createOrderLogMessage($orderResult[0], $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::UPDATE_ORDER_STATE_BY_ADMIN_ACTION_CONST, [], null,
                    null);
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
     
//    public function updateStoreBranchToClientDistanceByAdmin(OrderStoreBranchToClientDistanceByAdminRequest $request, int $userId): OrderStoreToBranchDistanceAndDestinationUpdateByAdminResponse
//    {
//        $order = $this->adminOrderManager->updateStoreBranchToClientDistanceByAdmin($request);
//
//        if ($order) {
//            if ($order->getCaptainId()?->getCaptainId()) {
//                $this->captainFinancialDuesService->captainFinancialDues($order->getCaptainId()->getCaptainId(), $order->getId(), $order->getCreatedAt());
//
//                // Create or update daily captain financial amount
//                $this->createOrUpdateCaptainFinancialDaily($order->getId());
//            }
//
//            // save log of the action on order
//            $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
//                OrderLogActionTypeConstant::UPDATE_STORE_BRANCH_TO_CLIENT_DISTANCE_BY_ADMIN_ACTION_CONST, [], null,
//                null);
//        }
//
//        return $this->autoMapping->map(OrderEntity::class, OrderStoreToBranchDistanceAndDestinationUpdateByAdminResponse::class, $order);
//    }

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
                OrderLogActionTypeConstant::CREATE_SUB_ORDER_BY_ADMIN_ACTION_CONST, [], null,
                null);

            // send order to external delivery company
            $this->sendOrderToExternalDeliveryCompany($order);

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
            OrderLogActionTypeConstant::UPDATE_STORE_BRANCH_TO_CLIENT_DISTANCE_AND_DESTINATION_BY_ADMIN_ACTION_CONST, [], null,
            null);

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
                    OrderLogActionTypeConstant::ORDER_CONFLICTED_ANSWERS_RESOLVED_BY_ADMIN_CONST, [], null,
                    null);
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
                OrderLogActionTypeConstant::CONFIRM_CAPTAIN_PAID_TO_PROVIDER_BY_STORE_VIA_DASHBOARD_CONST, [], null,
                null);

            // send firebase notification to admin if the captain’s answer differs from that of the store, regarding the field (paidToProvider and isCashPaymentConfirmedByStore)
            if ($order->getIsCashPaymentConfirmedByStore() !== $order->getPaidToProvider()) {

                $this->notificationFirebaseService->notificationToAdmin($order->getId(), NotificationFirebaseConstant::CAPTAIN_ANSWER_DIFFERS_FROM_THAT_OF_STORE);
            }

            return $this->autoMapping->map(OrderEntity::class, OrderUpdateIsCashPaymentConfirmedByStoreForAdminResponse::class, $order);
        }

        return $order;
    }

    /**
     * return new object of AdminCalculateCostDeliveryOrderRequest
     */
    public function getNewAdminCalculateCostDeliveryOrderRequestObject(): AdminCalculateCostDeliveryOrderRequest
    {
        return new AdminCalculateCostDeliveryOrderRequest();
    }

    /**
     * return new object of OrderDeliveryCostUpdateByAdminRequest
     */
    public function getNewOrderDeliveryCostUpdateByAdminRequestObject(): OrderDeliveryCostUpdateByAdminRequest
    {
        return new OrderDeliveryCostUpdateByAdminRequest();
    }

    /**
     * Calculates delivery cost of an order and updates it with the new value
     */
    public function calculateAndUpdateOrderDeliveryCostByOrderIdAndStoreOwnerProfileIdAndDistance(OrderEntity $orderEntity, int $adminUserId, int $action): OrderEntity|string
    {
        $orderLogDetails = [];
        $orderLogDetails['oldDeliverCost'] = $orderEntity->getDeliveryCost();

        // 1 calculate delivery cost
        $deliveryCostCalculateRequest = $this->getNewAdminCalculateCostDeliveryOrderRequestObject();

        $deliveryCostCalculateRequest->setStoreOwnerProfileId($orderEntity->getStoreOwner()->getId());
        $deliveryCostCalculateRequest->setStoreBranchToClientDistance($orderEntity->getStoreBranchToClientDistance());

        $deliveryCost = $this->calculateCostDeliveryOrder($deliveryCostCalculateRequest);

        // 2 update order delivery cost
        $orderDeliveryCostUpdateRequest = $this->getNewOrderDeliveryCostUpdateByAdminRequestObject();

        $orderDeliveryCostUpdateRequest->setId($orderEntity->getId());
        $orderDeliveryCostUpdateRequest->setDeliveryCost($deliveryCost->total);

        // save log of the action on order
        $this->createOrderLogMessageViaOrderEntityAndByAdmin($orderEntity, $adminUserId, $action, $orderLogDetails);

        return $this->updateOrderDeliveryCost($orderDeliveryCostUpdateRequest);
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
                $orderResult = $this->updateNormalOrderDestinationViaOrderIdAndDestinationArrayByAdmin($request->getOrderId(),
                    $currentDestination, $request->getDestination(), $userId);

                if ($orderResult) {
                    // 3. Add the new distance to the existing one
                    $orderEntity = $this->updateOrderStoreBranchToClientDistanceViaAddingNewDistanceByAdmin($request->getOrderId(),
                        $distance, $userId, $request->getStoreBranchToClientDistanceAdditionExplanation());

                    if ($orderEntity) {
                        // 4. Update related OrderDistanceConflict
                        $this->handleUpdateOrderDistanceConflictByNewDestinationResolveByAdmin($request, $orderEntity, $userId,
                            $request->getDestination());

                        // 5. Update delivery cost
                        $orderDeliveryCostUpdateResult = $this->calculateAndUpdateOrderDeliveryCostByOrderIdAndStoreOwnerProfileIdAndDistance($orderEntity,
                            $userId, OrderLogActionTypeConstant::ORDER_DELIVERY_COST_UPDATED_BY_NEW_DESTINATION_BY_ADMIN_CONST);

                        if ($orderDeliveryCostUpdateResult instanceof OrderEntity) {
                            $this->entityManager->getConnection()->commit();

                            // 6. Send notifications
                            // local notification to store
                            $this->createLocalNotificationForStore($orderEntity->getStoreOwner()->getStoreOwnerId(),
                                NotificationConstant::ORDER_NEW_DESTINATION_ADDED_BY_ADMIN_TITLE_CONST, NotificationConstant::ORDER_NEW_DESTINATION_ADDED_BY_ADMIN_MESSAGE_CONST,
                                $orderEntity->getId());
                            // firebase notification to store
                            $this->sendFirebaseNotificationToUserByAdmin($orderEntity->getStoreOwner()->getStoreOwnerId(),
                                $orderEntity->getId(), NotificationConstant::ORDER_NEW_DESTINATION_ADDED_BY_ADMIN_MESSAGE_CONST);
                        }
                    }

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
                if ((! $order['destination']['lat']) || (! $order['destination']['lon'])) {
                    // no destination of client are exist, get store branch location instead
                    return $order['location'];
                }

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
    public function updateNormalOrderDestinationViaOrderIdAndDestinationArrayByAdmin(int $orderId, array $currentDestination, array $newDestination, int $userId): ?OrderDestinationUpdateByAdminResponse
    {
        $order = $this->adminOrderManager->updateNormalOrderDestinationViaOrderIdAndDestinationArrayByAdmin($orderId, $newDestination);

        if (! $order) {
            return $order;
        }

        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::UPDATE_ORDER_DESTINATION_BY_ADMIN_ACTION_CONST, ['oldReceiverDestination' => $currentDestination], null,
            null);

        return $this->autoMapping->map(OrderEntity::class, OrderDestinationUpdateByAdminResponse::class, $order);
    }

    // Add distance to the existing one (in storeBranchToClientDistance field)
    public function updateOrderStoreBranchToClientDistanceViaAddingNewDistanceByAdmin(int $orderId, float $distance, int $userId, string $storeBranchToClientDistanceAdditionExplanation): ?OrderEntity
    {
        $order = $this->adminOrderManager->updateOrderStoreBranchToClientDistanceViaAddingNewDistanceByAdmin($orderId, $distance, $storeBranchToClientDistanceAdditionExplanation);

        if (! $order) {
            return $order;
        }

        // Re-calculate the financial dues of the captain who has the order (if exists)
        if ($order->getCaptainId()?->getCaptainId()) {
            $this->captainFinancialDuesService->captainFinancialDues($order->getCaptainId()->getCaptainId(), $order->getId(), $order->getCreatedAt());

            // Create or update daily captain financial amount
            $this->createOrUpdateCaptainFinancialDaily($order->getId());
        }

        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::UPDATE_STORE_BRANCH_TO_CLIENT_DISTANCE_VIA_ADDING_DISTANCE_BY_ADMIN_ACTION_CONST,
            [], null, null);

        //return $this->autoMapping->map(OrderEntity::class, OrderDestinationUpdateByAdminResponse::class, $order);
        return $order;
    }

    /**
     * Updates order distance conflict by admin after either new destination is used or a distance is added
     */
    public function updateOrderDistanceConflictByAdmin(OrderDistanceConflictUpdateByAdminRequest $request): OrderDistanceConflictUpdateByAdminResponse|int
    {
        return $this->adminOrderDistanceConflictService->updateOrderDistanceConflictByAdmin($request);
    }

    /**
     * handles the update of the OrderDistanceConflict object after additional distance added by admin
     */
    public function handleUpdateOrderDistanceConflictByAdminAfterDistanceAddition(OrderStoreBranchToClientDistanceUpdateByAddAdditionalDistanceByAdminRequest $request, OrderEntity $orderEntity, int $userId): OrderDistanceConflictUpdateByAdminResponse|int|string
    {
        // initialize and prepare update order distance conflict request
        $orderDistanceConflictUpdateByAdminRequest = $this->autoMapping->map(OrderStoreBranchToClientDistanceUpdateByAddAdditionalDistanceByAdminRequest::class,
            OrderDistanceConflictUpdateByAdminRequest::class, $request);

        // Get and set admin profile id
        $adminProfileId = $this->getAdminProfileIdByAdminUserId($userId);

        if ($adminProfileId === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;
        }

        $orderDistanceConflictUpdateByAdminRequest->setOrderId($orderEntity);
        $orderDistanceConflictUpdateByAdminRequest->setConflictResolvedBy($adminProfileId);
        $orderDistanceConflictUpdateByAdminRequest->setNewDistance($orderEntity->getStoreBranchToClientDistance());
        $orderDistanceConflictUpdateByAdminRequest->setResolveType(OrderDistanceConflictResolveTypeConstant::CONFLICT_RESOLVED_BY_DISTANCE_ADDITION_BY_ADMIN_CONST);
        $orderDistanceConflictUpdateByAdminRequest->setResolvedAt(new DateTime('now'));

        return $this->updateOrderDistanceConflictByAdmin($orderDistanceConflictUpdateByAdminRequest);
    }

    /**
     * handles the update  of the OrderDistanceConflict object after new destination added by admin
     */
    public function handleUpdateOrderDistanceConflictByNewDestinationResolveByAdmin(OrderStoreBranchToClientDistanceAdditionByAdminRequest $request, OrderEntity $orderEntity, int $userId, array $newDestination): OrderDistanceConflictUpdateByAdminResponse|int|string
    {
        // initialize and prepare update order distance conflict request
        $orderDistanceConflictUpdateByAdminRequest = $this->autoMapping->map(OrderStoreBranchToClientDistanceAdditionByAdminRequest::class,
            OrderDistanceConflictUpdateByAdminRequest::class, $request);

        // Get and set admin profile id
        $adminProfileId = $this->getAdminProfileIdByAdminUserId($userId);

        if ($adminProfileId === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;
        }

        $orderDistanceConflictUpdateByAdminRequest->setOrderId($orderEntity);
        $orderDistanceConflictUpdateByAdminRequest->setConflictResolvedBy($adminProfileId);
        $orderDistanceConflictUpdateByAdminRequest->setNewDistance($orderEntity->getStoreBranchToClientDistance());
        $orderDistanceConflictUpdateByAdminRequest->setResolveType(OrderDistanceConflictResolveTypeConstant::CONFLICT_RESOLVED_BY_DESTINATION_UPDATE_BY_ADMIN_CONST);
        $orderDistanceConflictUpdateByAdminRequest->setResolvedAt(new DateTime('now'));
        $orderDistanceConflictUpdateByAdminRequest->setNewDestination($newDestination);

        return $this->updateOrderDistanceConflictByAdmin($orderDistanceConflictUpdateByAdminRequest);
    }

    /**
     * Just add additional distance to storeBranchToClientDistance via new destination by admin
     */
    public function addAdditionalDistanceToStoreBranchToClientDistanceByAdmin(OrderStoreBranchToClientDistanceUpdateByAddAdditionalDistanceByAdminRequest $request, int $userId): int|OrderStoreBranchToClientDistanceUpdateByAdminResponse
    {
        // start transaction commit ...
        $this->entityManager->getConnection()->beginTransaction();

        try {
            // 1 update store branch to client distance
            $order = $this->adminOrderManager->updateOrderStoreBranchToClientDistanceViaAddingNewDistanceByAdmin($request->getOrderId(),
                $request->getAdditionalDistance(), $request->getStoreBranchToClientDistanceAdditionExplanation());

            if ($order) {
                // 2 Update related OrderDistanceConflict
                $this->handleUpdateOrderDistanceConflictByAdminAfterDistanceAddition($request, $order, $userId);

                // 3 Update delivery cost
                $orderDeliveryCostUpdateResult = $this->calculateAndUpdateOrderDeliveryCostByOrderIdAndStoreOwnerProfileIdAndDistance($order,
                    $userId, OrderLogActionTypeConstant::ORDER_DELIVERY_COST_UPDATED_BY_NEW_DISTANCE_BY_ADMIN_CONST);

                if ($orderDeliveryCostUpdateResult instanceof OrderEntity) {
                    // 4 Re-calculate the financial dues of the captain who has the order (if exists)
                    if ($order->getCaptainId()?->getCaptainId()) {
                        $this->captainFinancialDuesService->captainFinancialDues($order->getCaptainId()->getCaptainId(), $order->getId(), $order->getCreatedAt());

                        // Re-calculate daily captain financial due
                        $this->createOrUpdateCaptainFinancialDaily($order->getId());
                    }

                    $this->entityManager->getConnection()->commit();

                    // 5 Send notifications
                    // local notification to store
                    $this->createLocalNotificationForStore($order->getStoreOwner()->getStoreOwnerId(), NotificationConstant::ORDER_DISTANCE_ADDITION_BY_ADMIN_TITLE_CONST,
                        NotificationConstant::ORDER_DISTANCE_ADDITION_BY_ADMIN_MESSAGE_CONST, $order->getId());

                    // save log of the action on order
                    $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                        OrderLogActionTypeConstant::UPDATE_STORE_BRANCH_TO_CLIENT_DISTANCE_VIA_ADD_ADDITIONAL_DISTANCE_BY_ADMIN_ACTION_CONST,
                        [], null, null);

                    // firebase notification to store
                    $this->sendFirebaseNotificationToUserByAdmin($order->getStoreOwner()->getStoreOwnerId(), $order->getId(),
                        NotificationConstant::ORDER_DISTANCE_ADDITION_BY_ADMIN_MESSAGE_CONST);
                }
            }

            return $this->autoMapping->map(OrderEntity::class, OrderStoreBranchToClientDistanceUpdateByAdminResponse::class, $order);

        } catch (\Exception $e) {
            $this->entityManager->getConnection()->rollBack();
            throw $e;
        }
    }

    public function getOrderIsHideByOrderId(int $orderId): int|string
    {
        $arrayResult = $this->adminOrderManager->getOrderIsHideByOrderId($orderId);

        if (count($arrayResult) > 0) {
            return (int) $arrayResult[0];
        }

        return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
    }

    public function createLocalNotificationForStore(int $storeOwnerUserId, string $title, string $text, int $orderId)
    {
        $this->notificationLocalService->createNotificationLocal($storeOwnerUserId, $title, $text, NotificationTokenConstant::APP_TYPE_STORE, $orderId);
    }

    public function sendFirebaseNotificationToUserByAdmin(int $userId, int $orderId, string $text)
    {
        $this->notificationFirebaseService->notificationToUser($userId, $orderId, $text);
    }

    public function recycleOrCancelOrderByAdmin(OrderRecycleOrCancelByAdminRequest $request, int $userId): string|OrderRecycleByAdminResponse|CanCreateOrderResponse
    {
        $orderEntity = $this->adminOrderManager->getOrderByOrderIdAndHideStateForAdmin($request->getId(), OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE);

        if ($orderEntity) {
            // First, check if it requires to cancel the order
            if ($request->getCancel() === OrderIsCancelConstant::ORDER_CANCEL) {
                // update order state
                $updatedOrder = $this->adminOrderManager->updateOrderStatusToCancelled($orderEntity);

                if ($updatedOrder) {
                    // create record in order timeline for the action
                    $this->orderTimeLineService->createOrderLogsRequest($updatedOrder);

                    // save log of the action on order
                    $this->orderLogService->createOrderLogMessage($updatedOrder, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                        OrderLogActionTypeConstant::CANCEL_ORDER_BY_ADMIN_ACTION_CONST, [], null,
                        null);

                    //create local notification to store
                    $this->createLocalNotificationForStore($updatedOrder->getStoreOwner()->getStoreOwnerId(), NotificationConstant::CANCEL_ORDER_TITLE,
                        NotificationConstant::CANCEL_ORDER_SUCCESS, $updatedOrder->getId());

                    // create firebase notification to store
                    $this->sendFirebaseNotificationAboutOrderStateForUserByAdmin($updatedOrder->getStoreOwner()->getStoreOwnerId(),
                        $updatedOrder->getId(), NotificationConstant::CANCEL_ORDER_SUCCESS, NotificationConstant::STORE);
                }

                return $this->autoMapping->map(OrderEntity::class, OrderRecycleByAdminResponse::class, $updatedOrder);
            }

            // Isn't required to cancel the order, instead recycle it
            if (new DateTime($request->getDeliveryDate()) < new DateTime('now')) {
                // we set the delivery date equals to current datetime + 3 minutes just for affording the late in persisting the order
                // to the database if it is happened
                $request->setDeliveryDate((new DateTime('+ 3 minutes'))->format('Y-m-d H:i:s'));
            }

            // check store subscription
            $canCreateOrder = $this->subscriptionService->canCreateOrder($orderEntity->getStoreOwner()->getStoreOwnerId());

            if ($canCreateOrder->canCreateOrder === SubscriptionConstant::CAN_NOT_CREATE_ORDER) {
                return $canCreateOrder;
            }

            // update isHide for showing the order
            $request->setIsHide(OrderIsHideConstant::ORDER_SHOW);

            // check if cars available or not
            if ($canCreateOrder->subscriptionStatus === SubscriptionConstant::CARS_FINISHED) {
                $request->setIsHide(OrderIsHideConstant::ORDER_HIDE_TEMPORARILY);
            }

            $order = $this->adminOrderManager->recyclingOrderByAdmin($orderEntity, $request);

            if ($order) {
                // after order had been recycled, update remaining orders of the subscription of the store
                $this->subscriptionService->updateRemainingOrders($orderEntity->getStoreOwner()->getStoreOwnerId(),
                    SubscriptionConstant::OPERATION_TYPE_SUBTRACTION);

                // save log of the action on order
                $this->orderLogService->createOrderLogMessage($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::RECYCLE_ORDER_BY_ADMIN_ACTION_CONST, [], null, null);

                $this->notificationLocalService->createNotificationLocal($orderEntity->getStoreOwner()->getStoreOwnerId(), NotificationConstant::RECYCLING_ORDER_TITLE,
                    NotificationConstant::RECYCLING_ORDER_SUCCESS, NotificationTokenConstant::APP_TYPE_STORE, $order->getId());

                // create firebase notification to store
                $this->sendFirebaseNotificationAboutOrderStateForUserByAdmin($order->getStoreOwner()->getStoreOwnerId(),
                    $order->getId(), $order->getState(), NotificationConstant::STORE);

                // create firebase notification to captains
                $this->sendFirebaseNotificationToAllCaptainsByAdmin($order->getId());
            }

            return $this->autoMapping->map(OrderEntity::class, OrderRecycleByAdminResponse::class, $order);
        }

        return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
    }

    public function sendFirebaseNotificationAboutOrderStateForUserByAdmin(int $userId, int $orderId, string $orderState, string $userType)
    {
        try {
            $this->notificationFirebaseService->notificationOrderStateForUser($userId, $orderId, $orderState, $userType);

        } catch (\Exception $exception) {
            error_log($exception);
        }
    }

    public function sendFirebaseNotificationToAllCaptainsByAdmin(int $orderId)
    {
        try {
            $this->notificationFirebaseService->notificationToCaptains($orderId);

        } catch (\Exception $exception) {
            error_log($exception);
        }
    }

    // Get delivered orders during current active financial cycle of a captain by admin
    public function getOrdersByCaptainProfileIdAndCaptainFinancialCycle(int $captainProfileId): array
    {
        $response = [];

        $orders = $this->adminOrderManager->getOrdersByCaptainProfileIdAndCaptainFinancialCycle($captainProfileId);

        if (count($orders) > 0) {
            foreach ($orders as $order) {
                $response[] = $this->autoMapping->map('array', OrderCurrentFinancialCycleByCaptainProfileIdForAdminGetResponse::class, $order);
            }
        }

        return $response;
    }

    public function createLocalNotificationForCaptain(int $captainUserId, string $title, string $text, int $orderId)
    {
        $this->notificationLocalService->createNotificationLocal($captainUserId, $title, $text, NotificationTokenConstant::APP_TYPE_CAPTAIN, $orderId);
    }

    // Note: factor is the parameter that we want to subtract/add from/to remaining cars field
    public function updateRemainingOrdersOfStoreSubscriptionByAdmin(int $storeOwnerProfileId, DateTimeInterface $orderCreationDate, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        return $this->adminStoreSubscriptionService->handleUpdatingRemainingOrdersOfStoreSubscriptionByAdmin($storeOwnerProfileId,
            $orderCreationDate, $operationType, $factor);
    }

    // Note: factor is the parameter that we want to subtract/add from/to remaining cars field
    public function updateRemainingCarsOfStoreSubscriptionByAdmin(int $storeOwnerProfileId, DateTimeInterface $orderCreationDate, string $operationType, int $factor): SubscriptionDetailsEntity|int
    {
        return $this->adminStoreSubscriptionService->handleUpdatingRemainingCarsOfStoreSubscriptionViaStoreOwnerProfileIdAndOrderCreationDateByAdmin($storeOwnerProfileId,
            $orderCreationDate, $operationType, $factor);
    }

    public function createOrderLogViaOrderEntity(OrderEntity $orderEntity): OrderLogsResponse
    {
        return $this->orderTimeLineService->createOrderLogsRequest($orderEntity);
    }

    public function createOrderLogMessageAboutOrderCancelViaOrderEntityAndByAdmin(OrderEntity $orderEntity, int $userId, array $details)
    {
        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($orderEntity, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
            OrderLogActionTypeConstant::CANCEL_ORDER_BY_ADMIN_ACTION_CONST, $details, null, null);
    }

    /**
     * Create or update captain financial dues
     */
    public function createOrUpdateCaptainFinancialDues(int $userId, $orderId = null, $orderCreatedAt = null): CaptainFinancialDuesEntity|int|string
    {
        return $this->captainFinancialDuesService->captainFinancialDues($userId, $orderId, $orderCreatedAt);
    }

    /**
     * Deletes all related records to a specific cash order of a captain and update related payment
     */
    public function deleteCaptainAmountFromCashOrderAndUpdatePaymentByCaptainProfileIdAndOrderId(int $captainProfileId, int $orderId, string $orderPayment): void
    {
        if ($orderPayment === PaymentConstant::CASH_PAYMENT_METHOD_CONST) {
            // Delete captain amount from the CASH order only
            $this->adminCaptainCashOrderService->deleteCaptainAmountFromCashOrderAndUpdatePaymentByCaptainProfileIdAndOrderId($captainProfileId, $orderId);
        }
    }

    /**
     * Deletes all related records to a specific cash order of a store and update related payment
     */
    public function deleteStoreDuesFromCashOrderAndUpdatePaymentByStoreOwnerProfileIdAndOrderId(int $storeOwnerProfileId, int $orderId, string $orderPayment): void
    {
        if ($orderPayment === PaymentConstant::CASH_PAYMENT_METHOD_CONST) {
            // Delete store owner dues from the CASH order only
            $this->adminStoreCashOrderService->deleteStoreDuesFromCashOrderAndUpdatePaymentByStoreOwnerProfileIdAndOrderId($storeOwnerProfileId, $orderId);
        }
    }

    public function deleteChatRoomByOrderId(int $orderId): void
    {
        $this->adminOrderChatRoomService->deleteChatRoomByOrderId($orderId);
    }

    /**
     * filter orders which have different destination
     */
    public function filterDifferentDestinationOrdersByAdmin(OrderDifferentDestinationFilterByAdminRequest $request): array
    {
        $response = [];

        $orders = $this->adminOrderManager->filterDifferentDestinationOrdersByAdmin($request);

        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map("array", OrderDifferentDestinationFilterByAdminResponse::class, $order);
        }

        return $response;
    }

    public function createDashboardLocalNotification(string $title, array $message, int $adminUserId, int $orderId = null)
    {
        $this->dashboardLocalNotificationService->createOrderLogMessage($title, $message,
            DashboardLocalNotificationAppTypeConstant::DASHBOARD_APP_TYPE_CONST, $adminUserId, $orderId);
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
     * Gets last five created orders
     */
    public function getLastFiveCreatedOrders(): array
    {
        return $this->adminOrderManager->getLastFiveCreatedOrders();
    }

    /**
     * Gets last five delivered orders with captains' images
     */
    public function getLastFiveDeliveredOrdersWithCaptainsProfilesImages(): array
    {
        return $this->adminOrderManager->getLastFiveDeliveredOrdersWithCaptainsProfilesImages();
    }

    /**
     * Gets last five stores which created orders
     */
    public function getStoresWhichCreatedLastFiveOrders(): array
    {
        $response = [];

        $orders = $this->getLastFiveCreatedOrders();

        if (count($orders) > 0) {
            foreach ($orders as $key => $value) {
                $response[$key]['id'] = $value->getStoreOwner()->getId();
                $response[$key]['storeOwnerName'] = $value->getStoreOwner()->getStoreOwnerName();
                $response[$key]['images'] = $this->uploadFileHelperService->getImageParams($value->getStoreOwner()->getImages());
                $response[$key]['createdAt'] = $value->getStoreOwner()->getCreatedAt();
                $response[$key]['orderId'] = $value->getId();
                $response[$key]['orderCreatedAt'] = $value->getCreatedAt();
            }
        }

        return $response;
    }

    /**
     * Get the creation date of the order log record which state is delivered
     */
    public function getDeliveredStateOrderLogCreatedAtForAdminByOrderId(int $orderId): DateTime|int
    {
        return $this->orderLogService->getDeliveredStateOrderLogCreatedAtForAdminByOrderId($orderId);
    }

    /**
     * Gets last five captains who delivered orders
     */
    public function getCaptainsWhoDeliveredLastFiveOrders(): array
    {
        $response = [];

        $orders = $this->getLastFiveDeliveredOrdersWithCaptainsProfilesImages();

        if (count($orders) > 0) {
            foreach ($orders as $key => $value) {
                if ($value[0]->getCaptainId()) {
                    $response[$key]['id'] = $value[0]->getCaptainId()->getId();
                    $response[$key]['captainName'] = $value[0]->getCaptainId()->getCaptainName();
                    $response[$key]['images'] = $this->uploadFileHelperService->getImageParams($value['captainProfileImage']);
                    $response[$key]['createdAt'] = $value[0]->getCaptainId()->getCreatedAt();

                } else {
                    $response[$key]['id'] = 1;
                    $response[$key]['captainName'] = "مرسول";
                    $response[$key]['createdAt'] = $value[0]->getCreatedAt();
                }
                $response[$key]['orderId'] = $value[0]->getId();
                $response[$key]['orderDeliveredAt'] = $this->getDeliveredStateOrderLogCreatedAtForAdminByOrderId($response[$key]['orderId']);
            }
        }

        return $response;
    }

    public function createOrderLogMessageViaOrderEntityAndByAdmin(OrderEntity $orderEntity, int $userId, int $action, array $details)
    {
        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($orderEntity, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
            $action, $details, null, null);
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

    public function filterExternallyDeliveredOrdersByAdmin(OrderFilterByAdminRequest $request, int $userId): ?array
    {
        $response = [];
        $response['pendingOrders'] = [];
        $response['notDeliveredOrders'] = [];
        $response['hiddenOrders'] = [];

        $this->orderService->showSubOrderIfCarIsAvailable($userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST);
        $this->orderService->hideOrderExceededDeliveryTimeByHour($userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST);

        $request->setExternalOrder(true);

        // 1 Get uncancelled and undelivered external orders from OrderEntity
        $orders = $this->getNotCancelledNorDeliveredNorExpiredExternalOrdersOnly($request->getExternalCompanyId());

        if (count($orders) > 0) {
            foreach ($orders as $order) {
                // 2 Get external order new info from their related external company
                $externallyDeliveredOrders = $order->getExternallyDeliveredOrderEntities()->toArray();

                if (count($externallyDeliveredOrders) > 0) {
                    foreach ($externallyDeliveredOrders as $externallyDeliveredOrder) {
                        if (in_array($externallyDeliveredOrder->getStatus(), MrsoolCompanyConstant::NOT_CANCELLED_OR_DELIVERED_OR_EXPIRED_CONST)) {
                            $externalOrderInfo = $this->getExternalOrderByOrderIdAndExternalDeliveryCompanyId($externallyDeliveredOrder->getExternalOrderId(),
                                $externallyDeliveredOrder->getExternalDeliveryCompany()->getId());

                            if (($externalOrderInfo !== HttpResponseConstant::INVALID_CREDENTIALS_RESULT_CONST)
                                && ($externalOrderInfo !== HttpResponseConstant::ORDER_NOT_FOUND_RESULT_CONST)
                                && ($externalOrderInfo !== HttpResponseConstant::UN_RECOGNIZED_STATUS_CODE_RESULT_CONST)) {
                                // 3 Update external orders status (both in ExternallyDeliveredOrderEntity and OrderEntity)
                                $this->updateExternallyDeliveredOrderStatus($externallyDeliveredOrder->getId(),
                                    $externalOrderInfo['data']['status']);
                                // Update order status in OrderEntity
                                $this->compareAndUpdateOrderState($order, $externalOrderInfo['data']['status']);

                                // save log of the action on order
                                $this->createOrderLogMessageViaOrderEntityAndByAdmin($order, $userId,
                                    OrderLogActionTypeConstant::NORMAL_ORDER_STATUS_UPDATE_BY_FETCHING_IT_FROM_EXTERNAL_COMPANY_CONST,
                                    ['externalCompanyName' => $externallyDeliveredOrder->getExternalDeliveryCompany()->getCompanyName()]);
                            }
                        }
                    }
                }
            }
        }

        // 4 Return external orders according to their status
        $request->setState(OrderStateConstant::ORDER_STATE_PENDING);
        $response['pendingOrders'] = $this->prepareOrderResponseObject($this->adminOrderManager->filterStoreOrdersByAdmin($request),
            $request->getCustomizedTimezone());

        $request->setState(OrderStateConstant::ORDER_STATE_DELIVERED);
        $response['hiddenOrders'] = $this->prepareOrderResponseObject($this->adminOrderManager->filterStoreOrdersByAdmin($request),
            $request->getCustomizedTimezone());

        $request->setState(OrderStateConstant::ORDER_STATE_ONGOING);
        $response['notDeliveredOrders'] = $this->prepareOrderResponseObject($this->adminOrderManager->filterStoreOrdersByAdmin($request),
            $request->getCustomizedTimezone());

        $response['pendingOrdersCount'] = count($response['pendingOrders']);
        $response['hiddenOrdersCount'] = count($response['hiddenOrders']);
        $response['notDeliveredOrdersCount'] = count($response['notDeliveredOrders']);

        $response['totalOrderCount'] = $response['pendingOrdersCount'] + $response['notDeliveredOrdersCount'] + $response['hiddenOrdersCount'];

        return $response;
    }

    public function getLastExternallyDeliveredOrderByOrderId(int $orderId): ExternallyDeliveredOrderEntity|int
    {
        return $this->externallyDeliveredOrderGetService->getLastExternallyDeliveredOrderByOrderId($orderId);
    }
}
