<?php

namespace App\Request\Order;

class OrderUpdateCaptainOrderCostRequest
{   
    private int $id;

    private float $captainOrderCost;

    private string|null $noteCaptainOrderCost;

    private $captainId;

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set the value of id
     *
     * @return  self
     */ 
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }

    /**
     * Get the value of captainId
     */ 
    public function getCaptainId()
    {
        return $this->captainId;
    }

    /**
     * Set the value of captainId
     *
     * @return  self
     */ 
    public function setCaptainId($captainId)
    {
        $this->captainId = $captainId;

        return $this;
    }

    /**
     * Get the value of captainOrderCost
     */ 
    public function getCaptainOrderCost()
    {
        return $this->captainOrderCost;
    }

    /**
     * Set the value of captainOrderCost
     *
     * @return  self
     */ 
    public function setCaptainOrderCost($captainOrderCost)
    {
        $this->captainOrderCost = $captainOrderCost;

        return $this;
    }
}
