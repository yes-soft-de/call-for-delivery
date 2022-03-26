<?php

namespace App\Request\Order;

class OrderUpdateCaptainArrivedRequest
{   
    private int $id;

    private bool $isCaptainArrived;

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
    public function setId(int $id)
    {
        $this->id = $id;

        return $this;
    }
}
