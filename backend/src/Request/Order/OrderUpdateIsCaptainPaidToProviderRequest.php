<?php

namespace App\Request\Order;

class OrderUpdateIsCaptainPaidToProviderRequest
{   
    private int $id;

    private int $isCaptainPaidToProvider;

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
