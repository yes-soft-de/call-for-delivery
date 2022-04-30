<?php

namespace App\Request\Order;

class OrderUpdateByCaptainRequest
{   
    private int $id;

    private string $state;

    private int|null $kilometer;

    private $captainId;

    private $captainOrderCost;
    
    private $noteCaptainOrderCost;

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

    /**
     * Get the value of noteCaptainOrderCost
     */ 
    public function getNoteCaptainOrderCost()
    {
        return $this->noteCaptainOrderCost;
    }

    /**
     * Set the value of noteCaptainOrderCost
     *
     * @return  self
     */ 
    public function setNoteCaptainOrderCost($noteCaptainOrderCost)
    {
        $this->noteCaptainOrderCost = $noteCaptainOrderCost;

        return $this;
    }

    /**
     * Get the value of paidToProvider
     */ 
    public function getPaidToProvider()
    {
        return $this->paidToProvider;
    }

    /**
     * Set the value of paidToProvider
     *
     * @return  self
     */ 
    public function setPaidToProvider($paidToProvider)
    {
        $this->paidToProvider = $paidToProvider;

        return $this;
    }
}
