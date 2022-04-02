<?php

namespace App\Request\OrderLogs;

use App\Entity\OrderEntity;
use App\Entity\CaptainEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\StoreOwnerBranchEntity;

class OrderLogsCreateRequest
{
   private OrderEntity $orderId;

   private StoreOwnerProfileEntity $storeOwnerProfile;
   
   private null|CaptainEntity $captainProfile;

   private string $orderState;

   private StoreOwnerBranchEntity $storeOwnerBranch;

   private null|string $isCaptainArrived;

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

    /**
    * Get the value of storeOwnerBranch
    */ 
    public function getStoreOwnerBranch()
    {
       return $this->storeOwnerBranch;
    }
 
    /**
     * Set the value of storeOwnerBranch
     *
     * @return  self
     */ 
    public function setStoreOwnerBranch(StoreOwnerBranchEntity $storeOwnerBranch)
    {
       $this->storeOwnerBranch = $storeOwnerBranch;
 
       return $this;
    }
    /**
    * Get the value of storeOwnerBranch
    */ 
    public function getOrderState()
    {
       return $this->orderState;
    }
 
    /**
     * Set the value of storeOwnerBranch
     *
     * @return  self
     */ 
    public function setOrderState(string $orderState)
    {
       $this->orderState = $orderState;
 
       return $this;
    }

   /**
    * Get the value of isCaptainArrived
    */ 
   public function getIsCaptainArrived()
   {
      return $this->isCaptainArrived;
   }

   /**
    * Set the value of isCaptainArrived
    *
    * @return  self
    */ 
   public function setIsCaptainArrived(null|string $isCaptainArrived)
   {
      $this->isCaptainArrived = $isCaptainArrived;

      return $this;
   }
}
