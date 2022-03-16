<?php

namespace App\Request\Captain;

class CaptainProfileUpdateRequest
{
    private int $captainId;

    private string $captainName;

    private $images;

    private array $location = [];

    private int $age;

    private string $car;

    private float $salary;
   
    private float $bounce;
   
    private string $phone;

    private bool $isOnline;
   
    private string $bankName;
   
    private string $bankAccountNumber;

    private string $stcPay;
   
    private $mechanicLicense;
    
    private $identity;

    /**
     * @return mixed
     */
    public function getImage()
    {
        return $this->image;
    }

    /**
     * @param mixed $image
     */
    public function setImage($image): void
    {
        $this->image = $image;
    }

    /**
     * Get the value of captainName
     */ 
    public function getCaptainName()
    {
        return $this->captainName;
    }

    /**
     * Set the value of captainName
     *
     * @return  self
     */ 
    public function setCaptainName($captainName)
    {
        $this->captainName = $captainName;

        return $this;
    }

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
}
