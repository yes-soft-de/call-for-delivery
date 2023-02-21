<?php

namespace App\Request\Notification\DashboardLocalNotification;

use App\Entity\AdminProfileEntity;
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

    private int $appType;

    /**
     * @var AdminProfileEntity|null
     */
    private $adminProfile;

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

    public function getAppType(): int
    {
        return $this->appType;
    }

    public function setAppType(int $appType): void
    {
        $this->appType = $appType;
    }

    public function getAdminProfile(): ?AdminProfileEntity
    {
        return $this->adminProfile;
    }

    public function setAdminProfile(?AdminProfileEntity $adminProfile): void
    {
        $this->adminProfile = $adminProfile;
    }
}
