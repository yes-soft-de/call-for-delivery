<?php

namespace App\Request\Order;

class OrderUpdateByCaptainRequest
{   
    private int $id;

    private string $state;

    private int|null $kilometer;

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
}
