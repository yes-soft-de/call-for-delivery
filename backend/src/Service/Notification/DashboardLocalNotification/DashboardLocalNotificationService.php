<?php

namespace App\Service\Notification\DashboardLocalNotification;

use App\Message\DashboardLocalNotification\DashboardLocalNotificationCreateMessage;
use Symfony\Component\Messenger\MessageBusInterface;

class DashboardLocalNotificationService
{
    public function __construct(
        private MessageBusInterface $eventBus
    )
    {
    }

    public function createOrderLogMessage(int $adminUserId, string $title, array $message, int $appType, int $orderId = null)
    {
        $this->eventBus->dispatch(DashboardLocalNotificationCreateMessage::create($title, $message, $adminUserId,
            $appType, $orderId));
    }
}
