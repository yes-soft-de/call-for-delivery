<?php

namespace App\Request\Admin\Order;

use App\Entity\CaptainEntity;

class OrderStateUpdateByAdminRequest
{   
    private int $id;

    private string $state;

    private float|null $kilometer;

    private float|null $captainOrderCost;
    
    private string|null $noteCaptainOrderCost;

    private int|null $paidToProvider;

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
     * Get the value of state
     */ 
    public function getState()
    {
        return $this->state;
    }

    /**
     * Set the value of state
     *
     * @return  self
     */ 
    public function setState($state)
    {
        $this->state = $state;

        return $this;
    }
}
