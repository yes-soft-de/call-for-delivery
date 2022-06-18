<?php

namespace App\Request\Notification;

class NotificationFirebaseFromAdminRequest
{
    private int $otherUserID;

    /**
     * @var string|null
     */
    private $roomId;

    /**
     * @return int
     */
    public function getOtherUserID(): int
    {
        return $this->otherUserID;
    }

    public function setOtherUserID(int $otherUserID): void
    {
        $this->otherUserID = $otherUserID;
    }

    public function getRoomId(): ?string
    {
        return $this->roomId;
    }
}