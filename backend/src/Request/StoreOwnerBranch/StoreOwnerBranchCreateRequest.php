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

    public function setLocation(array $location): void
    {
        $this->location = $location;
    }

    public function setCity($city): void
    {
        $this->city = $city;
    }

    public function setName($name): void
    {
        $this->name = $name;
    }

    public function setIsActive($isActive): void
    {
        $this->isActive = $isActive;
    }

    public function setBranchPhone(?string $branchPhone): void
    {
        $this->branchPhone = $branchPhone;
    }
}
