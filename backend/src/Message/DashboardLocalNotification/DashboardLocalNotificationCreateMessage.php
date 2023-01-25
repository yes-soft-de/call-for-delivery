<?php

namespace App\Message\DashboardLocalNotification;

class DashboardLocalNotificationCreateMessage
{
    private string $title;

    /**
     * @var array
     */
    private $message;

    private int $user;

    /**
     * @var int|null
     */
    private $orderId;

    private int $appType;

    public static function create(string $title, array $message, int $user, int $appType, int $orderId = null)
    {
        $dashboardLocalNotificationCreateMessage = new DashboardLocalNotificationCreateMessage();

        $dashboardLocalNotificationCreateMessage->title = $title;
        $dashboardLocalNotificationCreateMessage->message = $message;
        $dashboardLocalNotificationCreateMessage->user = $user;
        $dashboardLocalNotificationCreateMessage->appType = $appType;
        $dashboardLocalNotificationCreateMessage->orderId = $orderId;

        return $dashboardLocalNotificationCreateMessage;
    }

    public function getTitle(): string
    {
        return $this->title;
    }

    public function getMessage(): array
    {
        return $this->message;
    }

    public function getUser(): int
    {
        return $this->user;
    }

    public function getOrderId(): ?int
    {
        return $this->orderId;
    }

    public function getAppType(): int
    {
        return $this->appType;
    }
}
