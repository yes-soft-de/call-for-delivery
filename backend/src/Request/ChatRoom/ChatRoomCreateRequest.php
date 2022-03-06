<?php

namespace App\Request\ChatRoom;

class ChatRoomCreateRequest
{
    private int $userId;

    /**
     * Get the value of userId
     */ 
    public function getUserId(): ?int
    {
        return $this->userId;
    }

    /**
     * Set the value of userId
     *
     * @return  self
     */ 
    public function setUserId(int $userId)
    {
        $this->userId = $userId;

        return $this;
    }
}
