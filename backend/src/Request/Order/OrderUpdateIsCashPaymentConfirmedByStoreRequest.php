<?php

namespace App\Request\Order;

class OrderUpdateIsCashPaymentConfirmedByStoreRequest
{   
    private int $id;

    private int $isCashPaymentConfirmedByStore;

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

    public function getIsCashPaymentConfirmedByStore(): int
    {
        return $this->isCashPaymentConfirmedByStore;
    }
}
