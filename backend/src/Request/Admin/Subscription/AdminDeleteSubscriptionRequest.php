<?php

namespace App\Request\Admin\Subscription;

class AdminDeleteSubscriptionRequest
{
    private int $id;

    private int $deletePayment;

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }

    /**
     * Get the value of deletePayment
     */ 
    public function getDeletePayment()
    {
        return $this->deletePayment;
    }
}
