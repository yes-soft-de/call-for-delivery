<?php

namespace App\Request\CaptainFinancialSystem;
use App\Entity\CaptainEntity;
use DateTime;

class CreateCaptainFinancialDuesByOptionalDatesRequest
{    
   private float $amount;

   private int $status;

   private float $amountForStore;

   private int $statusAmountForStore;

   private int|CaptainEntity $captain;

   private DateTime $startDate;
   
   private DateTime $endDate;

   /**
    * Get the value of amount
    */ 
   public function getAmount()
   {
      return $this->amount;
   }

   /**
    * Set the value of amount
    *
    * @return  self
    */ 
   public function setAmount($amount)
   {
      $this->amount = $amount;

      return $this;
   }

   /**
    * Get the value of status
    */ 
   public function getStatus()
   {
      return $this->status;
   }

   /**
    * Set the value of status
    *
    * @return  self
    */ 
   public function setStatus($status)
   {
      $this->status = $status;

      return $this;
   }

   /**
    * Get the value of captain
    */ 
   public function getCaptain()
   {
      return $this->captain;
   }

   /**
    * Set the value of captain
    *
    * @return  self
    */ 
   public function setCaptain(int|CaptainEntity $captain)
   {
      $this->captain = $captain;

      return $this;
   }

   /**
    * Get the value of startDate
    */ 
   public function getStartDate()
   {
      return $this->startDate;
   }

   /**
    * Set the value of startDate
    *
    * @return  self
    */ 
   public function setStartDate($startDate)
   {
      $this->startDate = $startDate;

      return $this;
   }

   /**
    * Get the value of endDate
    */ 
   public function getEndDate()
   {
      return $this->endDate;
   }

   /**
    * Set the value of endDate
    *
    * @return  self
    */ 
   public function setEndDate($endDate)
   {
      $this->endDate = $endDate;

      return $this;
   }

   /**
    * Get the value of amountForStore
    */ 
   public function getAmountForStore()
   {
      return $this->amountForStore;
   }

   /**
    * Set the value of amountForStore
    *
    * @return  self
    */ 
   public function setAmountForStore($amountForStore)
   {
      $this->amountForStore = $amountForStore;

      return $this;
   }

   /**
    * Get the value of statusAmountForStore
    */ 
   public function getStatusAmountForStore()
   {
      return $this->statusAmountForStore;
   }

   /**
    * Set the value of statusAmountForStore
    *
    * @return  self
    */ 
   public function setStatusAmountForStore($statusAmountForStore)
   {
      $this->statusAmountForStore = $statusAmountForStore;

      return $this;
   }
}
