<?php

namespace App\Request\Notification\DashboardLocalNotification;

use App\Entity\OrderEntity;
use App\Entity\UserEntity;

class DashboardLocalNotificationCreateRequest
{
    private string $title;

    private array $message = [];

    /**
     * @var int|null|OrderEntity
     */
    private $orderId;

    /**
     * @var int|UserEntity
     */
    private $user;

    private int $appType;

    public function getTitle(): string
    {
        return $this->title;
    }

    public function setTitle(string $title): void
    {
        $this->title = $title;
    }

    public function getMessage(): array
    {
        return $this->message;
    }

    public function setMessage(array $message): void
    {
        $this->message = $message;
    }

    public function getOrderId(): OrderEntity|int|null
    {
        return $this->orderId;
    }

    public function setOrderId(OrderEntity|int $orderId = null): void
    {
        $this->orderId = $orderId;
    }

    public function getUser(): UserEntity|int
    {
        return $this->user;
    }

    public function setUser(UserEntity|int $user): void
    {
        $this->user = $user;
    }

    public function getAppType(): int
    {
        return $this->appType;
    }

    public function setAppType(int $appType): void
    {
        $this->appType = $appType;
    }
}
