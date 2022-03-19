<?php

namespace App\Service\Notification;

use App\AutoMapping;
use App\Entity\NotificationLocalEntity;
use App\Manager\Notification\NotificationLocalManager;
use App\Request\Notification\NotificationLocalCreateRequest;
use App\Response\Notification\NotificationLocalResponse;
use App\Constant\Notification\NotificationConstant;
use App\Constant\Order\OrderStateConstant;

class NotificationLocalService
{
    private $autoMapping;
    private $notificationLocalManager;

    public function __construct(AutoMapping $autoMapping, NotificationLocalManager $notificationLocalManager)
    {
        $this->autoMapping = $autoMapping;
        $this->notificationLocalManager = $notificationLocalManager;
    }

    public function createNotificationLocal(int $userId, string $title, string $text, int $orderId = null): NotificationLocalResponse
    {
        $request = new NotificationLocalCreateRequest();

        $message = [
            "text" => $text,
            "orderId"=> $orderId
        ];

        $request->setUserId($userId);
        $request->setTitle($title);
        $request->setMessage($message);

        $item = $this->notificationLocalManager->createNotificationLocal($request);

        return $this->autoMapping->map(NotificationLocalEntity::class, NotificationLocalResponse::class, $item);
    }

    public function createNotificationLocalBySuperAdmin(int $userId, string $title, string $text, string $orderState, int $captainUserId = null, int $orderId = null): NotificationLocalResponse
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
    
    public function createNotificationLocalForOrderState(int $userId, string $title, string $state, int $orderId = null, $userType): NotificationLocalResponse
    {       
        if ($userType === "store") {
            $text = $this->getOrderStateForStore($state);
        }
        if ($userType === "captain") {
            $text = $this->getOrderStateForCaptain($state);
        }
       
       
        $message = [
            "text" => $text,
            "orderId"=> $orderId
        ];
      
        $request = $this->createNotificationLocalCreateRequest($userId, $title, $message);
       
        $notificationLocal = $this->notificationLocalManager->createNotificationLocal($request);

        return $this->autoMapping->map(NotificationLocalEntity::class, NotificationLocalResponse::class, $notificationLocal);
    }
    
    public function createNotificationLocalCreateRequest(int $userId, string $title, array $message): NotificationLocalCreateRequest
    {
        $request = new NotificationLocalCreateRequest();

        $request->setUserId($userId);
        $request->setTitle($title);
        $request->setMessage($message);
        
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
}
