<?php

namespace App\Request\Notification;

class NotificationFirebaseByUserIdRequest
{
    /**
     * @var int|null|string
     */
    private $otherUserID;

    private int $userID;

    /**
     * @var string|null
     */
    private $roomId;

    /**
     * @return int|null
     */
    public function getOtherUserID(): null|int|string
    {
        return $this->otherUserID;
    }

    /**
     * @param int|null $otherUserID
     */
    public function setOtherUserID(int|null $otherUserID): void
    {
        $this->otherUserID = $otherUserID;
    }

    /**
     * @return int
     */
    public function getUserID(): int
    {
        return $this->userID;
    }

    /**
     * @param int $userID
     */
    public function setUserID(int $userID): void
    {
        $this->userID = $userID;
    }

    public function getRoomId(): ?string
    {
        return $this->roomId;
    }
}