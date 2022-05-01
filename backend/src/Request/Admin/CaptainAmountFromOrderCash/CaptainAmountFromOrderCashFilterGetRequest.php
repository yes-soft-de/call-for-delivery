<?php

namespace App\Request\Admin\CaptainAmountFromOrderCash;

class CaptainAmountFromOrderCashFilterGetRequest
{
   private int $captainId;

   private string $fromDate;
   
   private string $toDate;

   /**
    * Get the value of captainId
    */ 
   public function getCaptainId()
   {
      return $this->captainId;
   }

   /**
    * Set the value of captainId
    *
    * @return  self
    */ 
   public function setCaptainId($captainId)
   {
      $this->captainId = $captainId;

      return $this;
   }

   /**
    * Get the value of fromDate
    */ 
   public function getFromDate()
   {
      return $this->fromDate;
   }

   /**
    * Set the value of fromDate
    *
    * @return  self
    */ 
   public function setFromDate($fromDate)
   {
      $this->fromDate = $fromDate;

      return $this;
   }

   /**
    * Get the value of toDate
    */ 
   public function getToDate()
   {
      return $this->toDate;
   }

   /**
    * Set the value of toDate
    *
    * @return  self
    */ 
   public function setToDate($toDate)
   {
      $this->toDate = $toDate;

      return $this;
   }
}
