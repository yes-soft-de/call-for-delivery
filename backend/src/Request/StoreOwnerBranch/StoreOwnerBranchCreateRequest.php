<?php

namespace App\Request\StoreOwnerBranch;

class StoreOwnerBranchCreateRequest
{
    private $storeOwner;
   
    private $location = [];
   
    private $city;
   
    private $name;
   
    private $isActive;

    private string|null $branchPhone;
      
   /**
    * @param mixed $storeOwner
    */
    public function setStoreOwner($storeOwner): void
    {
        $this->storeOwner = $storeOwner;
    }

   /**
    * @return mixed
    */
    public function getStoreOwner()
    {
        return $this->storeOwner;
    }
}
