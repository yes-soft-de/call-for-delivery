<?php

namespace App\Request\Admin\CaptainOffer;

class CaptainOfferStatusUpdateRequest
{
    private int $id;
    private string $status;

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }
}
