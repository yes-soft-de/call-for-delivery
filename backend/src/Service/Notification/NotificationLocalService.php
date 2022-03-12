<?php

namespace App\Service\Notification;

use App\AutoMapping;
use App\Entity\NotificationLocalEntity;
use App\Manager\Notification\NotificationLocalManager;
use App\Request\Notification\NotificationLocalCreateRequest;
use App\Response\Notification\NotificationLocalResponse;

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
}
