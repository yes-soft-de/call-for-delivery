<?php

namespace App\Request\Notification;

class NotificationFirebaseFromAdminRequest
{
    private int $otherUserID;

    /**
     * @return mixed
     */
    public function getOtherUserID()
    {
        return $this->otherUserID;
    }

    /**
     * @param mixed $otherUserID
     */
    public function setOtherUserID(int|null $otherUserID): void
    {
        $this->otherUserID = $otherUserID;
    }
}