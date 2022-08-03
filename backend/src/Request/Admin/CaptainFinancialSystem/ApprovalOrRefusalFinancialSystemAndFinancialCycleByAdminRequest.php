<?php

namespace App\Request\Admin\CaptainFinancialSystem;


class ApprovalOrRefusalFinancialSystemAndFinancialCycleByAdminRequest
{    
   private int $id;
   
   private string $date;

   private bool $state;

   /**
    * Get the value of state
    */ 
   public function getState()
   {
      return $this->state;
   }

   /**
    * Get the value of id
    */ 
   public function getId()
   {
      return $this->id;
   }

   /**
    * Get the value of date
    */ 
   public function getDate()
   {
      return $this->date;
   }
}
