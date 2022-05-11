<?php

namespace App\Request\Order;

class OrderCreateRequest
{
    private $payment;

    private $orderCost;
   
    private $note;
   
    private $deliveryDate;

    private $storeOwner;
    
    private $destination;
   
    private $recipientName;
   
    private $images;
   
    private $recipientPhone;
   
    private $detail;
   
    private $branch;

    private bool|null $orderIsMain;

    /**
     * Get the value of storeOwner
     */ 
    public function getStoreOwner()
    {
        return $this->storeOwner;
    }

    /**
     * Set the value of storeOwner
     *
     * @return  self
     */ 
    public function setStoreOwner($storeOwner)
    {
        $this->storeOwner = $storeOwner;

        return $this;
    }

    /**
     * Get the value of branch
     */ 
    public function getBranch()
    {
        return $this->branch;
    }

    /**
     * Set the value of branch
     *
     * @return  self
     */ 
    public function setBranch($branch)
    {
        $this->branch = $branch;

        return $this;
    }

    /**
     * Get the value of detail
     */ 
    public function getDetail()
    {
        return $this->detail;
    }

    /**
     * Set the value of detail
     *
     * @return  self
     */ 
    public function setDetail($detail)
    {
        $this->detail = $detail;

        return $this;
    }

    /**
     * Get the value of recipientPhone
     */ 
    public function getRecipientPhone()
    {
        return $this->recipientPhone;
    }

    /**
     * Set the value of recipientPhone
     *
     * @return  self
     */ 
    public function setRecipientPhone($recipientPhone)
    {
        $this->recipientPhone = $recipientPhone;

        return $this;
    }

    /**
     * Get the value of images
     */ 
    public function getImages()
    {
        return $this->images;
    }

    /**
     * Set the value of images
     *
     * @return  self
     */ 
    public function setImages($images)
    {
        $this->images = $images;

        return $this;
    }

    /**
     * Get the value of recipientName
     */ 
    public function getRecipientName()
    {
        return $this->recipientName;
    }

    /**
     * Set the value of recipientName
     *
     * @return  self
     */ 
    public function setRecipientName($recipientName)
    {
        $this->recipientName = $recipientName;

        return $this;
    }

    /**
     * Get the value of destination
     */ 
    public function getDestination()
    {
        return $this->destination;
    }

    /**
     * Set the value of destination
     *
     * @return  self
     */ 
    public function setDestination($destination)
    {
        $this->destination = $destination;

        return $this;
    }
}
