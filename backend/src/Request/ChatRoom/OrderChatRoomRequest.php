<?php

namespace App\Request\ChatRoom;

class OrderChatRoomRequest
{
    private int $orderId;

    private int $userId;

    private int $usedAs;

    /**
     * Get the value of usedAs
     */ 
    public function getUsedAs()
    {
        return $this->usedAs;
    }

    /**
     * Set the value of usedAs
     *
     * @return  self
     */ 
    public function setUsedAs($usedAs)
    {
        $this->usedAs = $usedAs;

        return $this;
    }

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

    /**
     * Get the value of orderId
     */ 
    public function getOrderId()
    {
        return $this->orderId;
    }

    /**
     * Set the value of orderId
     *
     * @return  self
     */ 
    public function setOrderId($orderId)
    {
        $this->orderId = $orderId;

        return $this;
    }
}
