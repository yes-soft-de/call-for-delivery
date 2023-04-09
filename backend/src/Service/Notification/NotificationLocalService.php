<?php

namespace App\Service\Notification;

use App\AutoMapping;
use App\Constant\Notification\NotificationTokenConstant;
use App\Entity\NotificationLocalEntity;
use App\Manager\Notification\NotificationLocalManager;
use App\Request\Notification\NotificationLocalCreateRequest;
use App\Response\Notification\NotificationLocalResponse;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Order\OrderStateConstant;

class NotificationLocalService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private NotificationLocalManager $notificationLocalManager
    )
    {
    }

    public function createNotificationLocal(int $userId, string $title, string $text, int $appType, int $orderId = null): NotificationLocalResponse
    {
        $request = new NotificationLocalCreateRequest();

        $message = [
            "text" => $text,
            "orderId"=> $orderId
        ];

        $request->setUserId($userId);
        $request->setTitle($title);
        $request->setMessage($message);
        $request->setAppType($appType);

        $item = $this->notificationLocalManager->createNotificationLocal($request);

        return $this->autoMapping->map(NotificationLocalEntity::class, NotificationLocalResponse::class, $item);
    }

    public function createPriceOfferNotificationLocal(int $userId, string $title, string $text, int $orderId, int $bidDetailsId,
                                                      int $priceOfferId, int $appType): NotificationLocalResponse
    {
        $request = new NotificationLocalCreateRequest();

        $message = [
            "text" => $text,
            "orderId" => $orderId,
            "bidDetailsId" => $bidDetailsId,
            "priceOfferId" => $priceOfferId
        ];

        $request->setUserId($userId);
        $request->setTitle($title);
        $request->setMessage($message);
        $request->setAppType($appType);

        $item = $this->notificationLocalManager->createNotificationLocal($request);

        return $this->autoMapping->map(NotificationLocalEntity::class, NotificationLocalResponse::class, $item);
    }

    public function createNotificationLocalBySuperAdmin(int $userId, string $title, string $text, string $orderState,
                                                        int $appType, int $captainUserId = null, int $orderId = null): NotificationLocalResponse
    {
        $request = new NotificationLocalCreateRequest();

        $message = [
            "text" => $text,
            "orderId"=> $orderId,
            "orderState"=> $orderState,
            "captainUserId"=> $captainUserId
        ];

        $request->setUserId($userId);
        $request->setTitle($title);
        $request->setMessage($message);
        $request->setAppType($appType);

        $item = $this->notificationLocalManager->createNotificationLocal($request);

        return $this->autoMapping->map(NotificationLocalEntity::class, NotificationLocalResponse::class, $item);
    }
    
    /**
     * @param integer $userId
     */
    public function getLocalNotifications($userId): ?array
    {
        $response = [];

        $notifications = $this->notificationLocalManager->getLocalNotifications($userId);

        foreach ($notifications as $notification) {

            $response[] = $this->autoMapping->map("array", NotificationLocalResponse::class, $notification);
        }

        return $response;
    }

    /**
     * @param integer $id
     */
    public function deleteLocalNotification($id): ?NotificationLocalEntity
    {
        return $this->notificationLocalManager->deleteLocalNotification($id);
    }

    public function getOrderStateForStore($state): string
    {
        if ($state == OrderStateConstant::ORDER_STATE_ON_WAY){
            $state = NotificationConstant::STATE_ON_WAY_PICK_ORDER;
        }
        if ($state == OrderStateConstant::ORDER_STATE_IN_STORE){
            $state =  NotificationConstant::STATE_IN_STORE;
        }
        if ($state == OrderStateConstant::ORDER_STATE_PICKED){
            $state =  NotificationConstant::STATE_PICKED;
        }
        if ($state == OrderStateConstant::ORDER_STATE_ONGOING){
            $state =  NotificationConstant::STATE_ONGOING;
        }
        if ($state == OrderStateConstant::ORDER_STATE_DELIVERED){
            $state =  NotificationConstant::STATE_DELIVERED;
        }

        return $state;
    }

    /**
     * Creates local notification for specific user who defined by userId, and includes order state within the notification
     */
    public function createNotificationLocalForOrderState(int $userId, string $title, string $state, string $userType, int $orderId = null, int $captainProfileId = null): NotificationLocalResponse
    {
        $appType = 0;
        $message = [];

        if ($userType === NotificationConstant::STORE) {
            $text = $this->getOrderStateForStore($state);
            $message = [
                "text" => $text,
                "orderId"=> $orderId,
                "captainUserId"=> $captainProfileId
            ];

            $appType = NotificationTokenConstant::APP_TYPE_STORE;

        } elseif ($userType === NotificationConstant::CAPTAIN) {
            $text = $this->getOrderStateForCaptain($state);
            $message = [
                "text" => $text,
                "orderId"=> $orderId
            ];

            $appType = NotificationTokenConstant::APP_TYPE_CAPTAIN;

        } elseif ($userType === NotificationConstant::SUPPLIER) {
            $text = $this->getOrderStateForSupplier($state);
            //TODO here we may also add supplierId to the message
            $message = [
                "text" => $text,
                "orderId"=> $orderId
            ];

            $appType = NotificationTokenConstant::APP_TYPE_SUPPLIER;
        }

        $request = $this->createNotificationLocalCreateRequest($userId, $title, $message, $appType);
       
        $notificationLocal = $this->notificationLocalManager->createNotificationLocal($request);

        return $this->autoMapping->map(NotificationLocalEntity::class, NotificationLocalResponse::class, $notificationLocal);
    }
    
    public function createNotificationLocalCreateRequest(int $userId, string $title, array $message, int $appType): NotificationLocalCreateRequest
    {
        $request = new NotificationLocalCreateRequest();

        $request->setUserId($userId);
        $request->setTitle($title);
        $request->setMessage($message);
        $request->setAppType($appType);
        
        return $request;
    }

    public function getOrderStateForCaptain($state): string
    {
        if ($state == OrderStateConstant::ORDER_STATE_ON_WAY){
            $state = NotificationConstant::STATE_ON_WAY_PICK_ORDER_CAPTAIN;
        }
        if ($state == OrderStateConstant::ORDER_STATE_IN_STORE){
            $state =  NotificationConstant::STATE_IN_STORE_CAPTAIN;
        }
        if ($state == OrderStateConstant::ORDER_STATE_PICKED){
            $state =  NotificationConstant::STATE_PICKED_CAPTAIN;
        }
        if ($state == OrderStateConstant::ORDER_STATE_ONGOING){
            $state =  NotificationConstant::STATE_ONGOING_CAPTAIN;
        }
        if ($state == OrderStateConstant::ORDER_STATE_DELIVERED){
            $state =  NotificationConstant::STATE_DELIVERED_CAPTAIN;
        }
        
        return $state;
    }

    public function getOrderStateForSupplier(string $state): string
    {
        if ($state === OrderStateConstant::ORDER_STATE_ON_WAY) {
            $state = NotificationConstant::STATE_CAPTAIN_ON_WAY_TO_PICK_ORDER;
        }
        if ($state == OrderStateConstant::ORDER_STATE_IN_STORE){
            $state =  NotificationConstant::STATE_CAPTAIN_IN_STORE;
        }
        if ($state == OrderStateConstant::ORDER_STATE_PICKED){
            $state =  NotificationConstant::STATE_ORDER_PICKED;
        }
        if ($state == OrderStateConstant::ORDER_STATE_ONGOING){
            $state =  NotificationConstant::STATE_ORDER_ONGOING;
        }
        if ($state == OrderStateConstant::ORDER_STATE_DELIVERED){
            $state =  NotificationConstant::STATE_ORDER_DELIVERED;
        }

        return $state;
    }
}
