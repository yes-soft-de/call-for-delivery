<?php

namespace App\Request\ChatRoom;

class ChatRoomCreateRequest
{
    private int $userId;

    private string $usedAs;
  
    private string $createdAt;
    
    private string $roomId;

    /**
     * Get the value of userId
     */ 
    public function getUserId()
    {
        return $this->userId;
    }

    /**
     * Set the value of userId
     *
     * @return  self
     */ 
    public function setUserId($userId)
    {
        $this->userId = $userId;

        return $this;
    }
}
