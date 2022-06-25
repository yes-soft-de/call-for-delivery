<?php

namespace App\Request\Admin\Order;

use App\Entity\CaptainEntity;

class OrderAssignToCaptainByAdminRequest
{
   private int|CaptainEntity $id;
   
   private int $orderId;

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
   public function setId(CaptainEntity $id)
   {
      $this->id = $id;

      return $this;
   }

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
   public function setOrderId($orderId)
   {
      $this->orderId = $orderId;

      return $this;
   }
}
