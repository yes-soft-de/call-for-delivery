<?php

namespace App\Service\Order;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Manager\Order\OrderManager;
use App\Request\Order\OrderFilterRequest;
use App\Request\Order\OrderCreateRequest;
use App\Response\Order\OrderResponse;
use App\Response\Order\OrdersResponse;
use App\Response\Subscription\CanCreateOrderResponse;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Subscription\SubscriptionConstant;
use App\Service\FileUpload\UploadFileHelperService;
use App\Service\Subscription\SubscriptionService;
use App\Service\Notification\NotificationLocalService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class OrderService
{
    private AutoMapping $autoMapping;
    private OrderManager $orderManager;
    private SubscriptionService $subscriptionService;
    private NotificationLocalService $notificationLocalService;
    private string $params;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, OrderManager $orderManager, SubscriptionService $subscriptionService, NotificationLocalService $notificationLocalService, ParameterBagInterface $params,
                                UploadFileHelperService $uploadFileHelperService)
    {
       $this->params = $params->get('upload_base_url') . '/';
       $this->autoMapping = $autoMapping;
       $this->orderManager = $orderManager;
       $this->subscriptionService = $subscriptionService;
       $this->notificationLocalService = $notificationLocalService;
        $this->uploadFileHelperService = $uploadFileHelperService;
    }

    /**
     * @param OrderCreateRequest $request
     * @return OrderResponse|CanCreateOrderResponse
     */
    public function createOrder(OrderCreateRequest $request): OrderResponse|CanCreateOrderResponse
    {
        $canCreateOrder = $this->subscriptionService->canCreateOrder($request->getStoreOwner()); 
     
        if($canCreateOrder->canCreateOrder === SubscriptionConstant::CAN_NOT_CREATE_ORDER) {
      
            return  $canCreateOrder;
        }

        $order = $this->orderManager->createOrder($request);
        if($order) {

         $this->subscriptionService->updateRemainingOrders($request->getStoreOwner()->getStoreOwnerId());

         $this->notificationLocalService->createNotificationLocal($request->getStoreOwner()->getStoreOwnerId(), NotificationConstant::NEW_ORDER_TITLE, NotificationConstant::CREATE_ORDER_SUCCESS, $order->getId());
        }
        
        return $this->autoMapping->map(OrderEntity::class, OrderResponse::class, $order);
    }

    /**
     * @param $userId
     * @return array
     */
    public function getStoreOrders(int $userId): ?array
    {
        $response = [];
       
        $orders = $this->orderManager->getStoreOrders($userId);
       
        foreach ($orders as $order) {
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

        $order['images'] = $this->uploadFileHelperService->getImageParams($order['images']);

        return $this->autoMapping->map("array", OrdersResponse::class, $order);
    }
    
    public function getImageParams($imageURL, $image, $baseURL): array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }

    public function filterStoreOrders(OrderFilterRequest $request, int $userId): ?array
    {
        $response = [];

        $orders = $this->orderManager->filterStoreOrders($request, $userId);

        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map("array", OrdersResponse::class, $order);
        }

        return $response;
    }
}
