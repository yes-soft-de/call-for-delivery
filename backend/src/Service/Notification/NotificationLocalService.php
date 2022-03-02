<?php

namespace App\Service\Notification;

use App\AutoMapping;
use App\Entity\NotificationLocalEntity;
use App\Manager\Notification\NotificationLocalManager;
use App\Request\Notification\NotificationLocalCreateRequest;
use App\Response\Notification\NotificationLocalResponse;
use App\Constant\Notification\NotificationConstant;

class NotificationLocalService
{
    public function __construct(private AutoMapping $autoMapping, private NotificationLocalManager $notificationLocalManager)
    {
    }

    /**
     * @param $userId
     * @param $title
     * @param $text
     * @param $orderId
     * @return NotificationLocalResponse
     */
    public function createNotificationLocal($userId, $title, $text, $orderId = null): NotificationLocalResponse
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
    
    /**
     * @param $userId
     * @return array|null
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
     * @param $id
     * @return NotificationLocalEntity|null
     */
    public function deleteLocalNotification($id): ?NotificationLocalEntity
    {
        return $this->notificationLocalManager->deleteLocalNotification($id);
    }
}
