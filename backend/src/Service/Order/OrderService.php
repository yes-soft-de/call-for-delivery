<?php

namespace App\Service\Order;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Manager\Order\OrderManager;
use App\Request\Order\OrderCreateRequest;
use App\Response\Order\OrderResponse;
use App\Response\Order\OrdersResponse;
use App\Response\Subscription\CanCreateOrderResponse;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Subscription\SubscriptionConstant;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Service\Subscription\SubscriptionService;
use App\Service\Notification\NotificationLocalService;
use App\Service\Image\ImageService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use App\Request\Image\ImageCreateRequest;
use App\Response\Image\ImageCreateResponse;

class OrderService
{
    private AutoMapping $autoMapping;
    private OrderManager $orderManager;
    private SubscriptionService $subscriptionService;
    private NotificationLocalService $notificationLocalService;
    private ImageService $imageService;

    public function __construct(AutoMapping $autoMapping, OrderManager $orderManager, SubscriptionService $subscriptionService, NotificationLocalService $notificationLocalService, ParameterBagInterface $params,
    ImageService $imageService)
    {
       $this->imageService = $imageService;
       $this->autoMapping = $autoMapping;
       $this->orderManager = $orderManager;
       $this->subscriptionService = $subscriptionService;
       $this->notificationLocalService = $notificationLocalService;
       $this->imageService = $imageService;
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
        
            $this->createImage($request->getImages(), $order->getId());
        
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

        $order['images'] = $this->imageService->getImagesByItemIdAndEntityTypeAndImageAim($id, ImageEntityTypeConstant::ENTITY_TYPE_ORDER, ImageUseAsConstant::IMAGE_USE_AS_ORDER_IMAGE);

        return $this->autoMapping->map("array", OrdersResponse::class, $order);
    }
    
    public function createImage(string $image, $id): ?ImageCreateResponse
    {
        $request = new ImageCreateRequest();
       
        $request->setImagePath($image);
        $request->setEntityType(ImageEntityTypeConstant::ENTITY_TYPE_ORDER);
        $request->setUsedAs(ImageUseAsConstant::IMAGE_USE_AS_ORDER_IMAGE);
        $request->setItemId($id);

        return $this->imageService->create($request);
    }
}
