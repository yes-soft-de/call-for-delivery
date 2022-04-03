<?php

namespace App\Request\Notification;

class NotificationFirebaseByUserIdRequest
{
    /**
     * @var int|null
     */
    private $otherUserID;

    private int $userID;

    /**
     * @return int|null
     */
    public function getOtherUserID(): ?int
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
}