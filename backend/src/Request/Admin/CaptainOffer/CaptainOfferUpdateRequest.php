<?php

namespace App\Request\Admin\CaptainOffer;

class CaptainOfferUpdateRequest
{
    private int $id;
    private int $carCount;
    private string $expired;
    private string $price;

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }
}
