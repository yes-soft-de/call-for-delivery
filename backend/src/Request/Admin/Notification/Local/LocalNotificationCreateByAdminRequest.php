<?php

namespace App\Request\Admin\Notification\Local;

class LocalNotificationCreateByAdminRequest
{
    private string $title;

    /**
     * @var int|null
     */
    private $userId;

    private array $message;

    /**
     * @var int|null
     */
    private $appType;

    public function getTitle(): string
    {
        return $this->title;
    }

    public function setTitle(string $title): void
    {
        $this->title = $title;
    }

    public function getUserId(): ?int
    {
        return $this->userId;
    }

    public function setUserId(?int $userId): void
    {
        $this->userId = $userId;
    }

    public function getMessage(): array
    {
        return $this->message;
    }

    public function setMessage(array $message): void
    {
        $this->message = $message;
    }

    public function setAppType(?int $appType): void
    {
        $this->appType = $appType;
    }
}
