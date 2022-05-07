<?php

namespace App\Request\Admin\StoreOwnerDuesFromCashOrders;

class StoreOwnerDuesFromCashOrdersFilterGetRequest
{
   private int $storeId;

   private string $fromDate;
   
   private string $toDate;

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

   /**
    * Get the value of storeId
    */ 
   public function getStoreId()
   {
      return $this->storeId;
   }

   /**
    * Set the value of storeId
    *
    * @return  self
    */ 
   public function setStoreId($storeId)
   {
      $this->storeId = $storeId;

      return $this;
   }
}
