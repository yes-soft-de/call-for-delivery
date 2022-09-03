<?php

namespace App\Request\Admin\Order;
use DateTime;
use App\Entity\StoreOwnerBranchEntity;

class UpdateOrderByAdminRequest
{
    private int $id;

    private string|null $payment;

    private float|null $orderCost;
   
    private string|null $note;
   
    private $deliveryDate;
    
    private $destination;
   
    private string|null $recipientName;
   
    private $images;
   
    private string|null $recipientPhone;
   
    private string|null $detail;
   
    private StoreOwnerBranchEntity|int $branch;

    private string|null $filePdf;

    private float|null $storeBranchToClientDistance;

    /**
     * Auto-calculated value depending on the distance which is being calculated by Google MAP API
     * @var float|null
     */
    private $deliveryCost;

    /**
     * @var bool|null
     */
    private $orderIsMain;
    
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
     * Get the value of payment
     */ 
    public function getPayment()
    {
        return $this->payment;
    }

    /**
     * Set the value of payment
     *
     * @return  self
     */ 
    public function setPayment($payment)
    {
        $this->payment = $payment;

        return $this;
    }

    /**
     * Get the value of orderCost
     */ 
    public function getOrderCost()
    {
        return $this->orderCost;
    }

    /**
     * Set the value of orderCost
     *
     * @return  self
     */ 
    public function setOrderCost($orderCost)
    {
        $this->orderCost = $orderCost;

        return $this;
    }

    /**
     * Get the value of note
     */ 
    public function getNote()
    {
        return $this->note;
    }

    /**
     * Set the value of note
     *
     * @return  self
     */ 
    public function setNote($note)
    {
        $this->note = $note;

        return $this;
    }

    /**
     * Get the value of deliveryDate
     */ 
    public function getDeliveryDate()
    {
        return $this->deliveryDate;
    }

    /**
     * Set the value of deliveryDate
     *
     * @return  self
     */ 
    public function setDeliveryDate($deliveryDate)
    {
        $this->deliveryDate = $deliveryDate;

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
}
