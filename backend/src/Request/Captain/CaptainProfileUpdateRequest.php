<?php

namespace App\Request\Captain;

class CaptainProfileUpdateRequest
{
    private int $captainId;

    private string $captainName;

    private string $images;

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
   
    private string $mechanicLicense;
    
    private string $identity;

    private string $drivingLicence;

    /**
     * @return mixed
     */
    public function getImages()
    {
        return $this->images;
    }

    public function setImages($images): void
    {
        $this->images = $images;
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

    /**
     * Get the value of drivingLicence
     */ 
    public function getDrivingLicence()
    {
        return $this->drivingLicence;
    }

    /**
     * Set the value of drivingLicence
     *
     * @return  self
     */ 
    public function setDrivingLicence($drivingLicence)
    {
        $this->drivingLicence = $drivingLicence;

        return $this;
    }

    /**
     * Get the value of identity
     */ 
    public function getIdentity()
    {
        return $this->identity;
    }

    /**
     * Set the value of identity
     *
     * @return  self
     */ 
    public function setIdentity($identity)
    {
        $this->identity = $identity;

        return $this;
    }

    /**
     * Get the value of mechanicLicense
     */ 
    public function getMechanicLicense()
    {
        return $this->mechanicLicense;
    }

    /**
     * Set the value of mechanicLicense
     *
     * @return  self
     */ 
    public function setMechanicLicense($mechanicLicense)
    {
        $this->mechanicLicense = $mechanicLicense;

        return $this;
    }
}
