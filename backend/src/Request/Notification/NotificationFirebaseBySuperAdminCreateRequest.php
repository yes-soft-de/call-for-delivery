<?php

namespace App\Request\Notification;

class NotificationFirebaseBySuperAdminCreateRequest
{
    /**
     * @var int|null
     */
    private $otherUserId;

    /**
     * @var int|null
     */
    private $appType;

    private string $title;

    private string $messageBody;

    /**
     * @return int|null
     */
    public function getOtherUserId(): ?int
    {
        return $this->otherUserId;
    }

    /**
     * @return int|null
     */
    public function getAppType(): ?int
    {
        return $this->appType;
    }

    /**
     * @return string
     */
    public function getTitle(): string
    {
        return $this->title;
    }

    /**
     * @return string
     */
    public function getMessageBody(): string
    {
        return $this->messageBody;
    }
}
