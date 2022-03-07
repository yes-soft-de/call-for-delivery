<?php

namespace App\Request\ChatRoom;

class ChatRoomCreateRequest
{
    private int $userId;

    private int $usedAs;

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

    /**
     * Get the value of usedAs
     */ 
    public function getUsedAs(): ?int
    {
        return $this->usedAs;
    }

    /**
     * Set the value of usedAs
     *
     * @return  self
     */ 
    public function setUsedAs(int $usedAs)
    {
        $this->usedAs = $usedAs;

        return $this;
    }
}
