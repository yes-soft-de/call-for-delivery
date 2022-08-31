<?php

namespace App\Request\Admin\Order;

class OrderStoreBranchToClientDistanceAndDestinationByAdminRequest
{   
    private int $orderId;

    private float $storeBranchToClientDistance;

    private array $destination;


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

    /**
     * Get the value of storeBranchToClientDistance
     */ 
    public function getStoreBranchToClientDistance()
    {
        return $this->storeBranchToClientDistance;
    }

    /**
     * Set the value of storeBranchToClientDistance
     *
     * @return  self
     */ 
    public function setStoreBranchToClientDistance($storeBranchToClientDistance)
    {
        $this->storeBranchToClientDistance = $storeBranchToClientDistance;

        return $this;
    }

    /**
     * Get the value of destination
     */ 
    public function getDestination()
    {
        return $this->destination;
    }

    /**
     * Set the value of destination
     *
     * @return  self
     */ 
    public function setDestination($destination)
    {
        $this->destination = $destination;

        return $this;
    }
}
