<?php

namespace App\Request\Notification;

class NotificationFirebaseByUserIdRequest
{
    private int|null $otherUserID;

    private int $userID;


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

    /**
     * @return mixed
     */
    public function getUserID()
    {
        return $this->userID;
    }

    /**
     * @param mixed $userID
     */
    public function setUserID(int $userID): void
    {
        $this->userID = $userID;
    }
}