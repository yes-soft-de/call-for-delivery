<?php

namespace App\Request\Rate;

use App\Entity\OrderEntity;
use App\Entity\CaptainEntity;
use App\Entity\StoreOwnerProfileEntity;

class OrderLogsCreateRequest
{
   private OrderEntity $orderId;

   private StoreOwnerProfileEntity $storeOwnerProfile;
   
   private null|CaptainEntity $captainProfile;

   /**
    * Get the value of orderId
    */ 
   public function getOrderId()
   {
      return $this->orderId;
   }

   /**
    * Set the value of orderId
    *
    * @return  self
    */ 
   public function setOrderId(OrderEntity $orderId)
   {
      $this->orderId = $orderId;

      return $this;
   }

   /**
    * Get the value of storeOwnerProfile
    */ 
   public function getStoreOwnerProfile()
   {
      return $this->storeOwnerProfile;
   }

   /**
    * Set the value of storeOwnerProfile
    *
    * @return  self
    */ 
   public function setStoreOwnerProfile(StoreOwnerProfileEntity $storeOwnerProfile)
   {
      $this->storeOwnerProfile = $storeOwnerProfile;

      return $this;
   }

   /**
    * Get the value of captainProfile
    */ 
   public function getCaptainProfile()
   {
      return $this->captainProfile;
   }

   /**
    * Set the value of captainProfile
    *
    * @return  self
    */ 
   public function setCaptainProfile(null|CaptainEntity $captainProfile)
   {
      $this->captainProfile = $captainProfile;

      return $this;
   }
}
