<?php

namespace App\Request\Captain;

class CaptainProfileUpdateRequest
{
    private int $captainId;

    private string $captainName;

    private string $image;

    private array $location = [];

    /**
     * @var int|null
     */
    private $age;

    /**
     * @var string|null
     */
    private $car;

    /**
     * @var float|null
     */
    private $salary;

    /**
     * @var float|null
     */
    private $bounce;
   
    private string $phone;

    private bool $isOnline;

    /**
     * @var string|null
     */
    private $bankName;

    /**
     * @var string|null
     */
    private $bankAccountNumber;

    /**
     * @var string|null
     */
    private $stcPay;

    /**
     * @var string|null
     */
    private $mechanicLicense;

    /**
     * @var string|null
     */
    private $identity;

    /**
     * @var string|null
     */
    private $drivingLicence;

    public function getImage(): string
    {
        return $this->image;
    }

    public function setImage($image): void
    {
        $this->image = $image;
    }

    /**
     * Get the value of captainName
     */ 
    public function getCaptainName(): string
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
    public function getDrivingLicence(): ?string
    {
        return $this->drivingLicence;
    }

    /**
     * Set the value of drivingLicence
     *
     * @return  self
     */ 
    public function setDrivingLicence(?string $drivingLicence)
    {
        $this->drivingLicence = $drivingLicence;

        return $this;
    }

    /**
     * Get the value of identity
     */ 
    public function getIdentity(): ?string
    {
        return $this->identity;
    }

    /**
     * Set the value of identity
     *
     * @return  self
     */ 
    public function setIdentity(?string $identity)
    {
        $this->identity = $identity;

        return $this;
    }

    /**
     * Get the value of mechanicLicense
     */ 
    public function getMechanicLicense(): ?string
    {
        return $this->mechanicLicense;
    }

    /**
     * Set the value of mechanicLicense
     *
     * @return  self
     */ 
    public function setMechanicLicense(?string $mechanicLicense)
    {
        $this->mechanicLicense = $mechanicLicense;

        return $this;
    }

    public function getCar(): ?string
    {
        return $this->car;
    }

    public function setCar(?string $car): void
    {
        $this->car = $car;
    }

    public function getSalary(): ?float
    {
        return $this->salary;
    }

    public function setSalary(?float $salary): void
    {
        $this->salary = $salary;
    }

    public function getBounce(): ?float
    {
        return $this->bounce;
    }

    public function setBounce(?float $bounce): void
    {
        $this->bounce = $bounce;
    }

    public function getBankName(): ?string
    {
        return $this->bankName;
    }

    public function setBankName(?string $bankName): void
    {
        $this->bankName = $bankName;
    }

    public function getBankAccountNumber(): ?string
    {
        return $this->bankAccountNumber;
    }

    public function setBankAccountNumber(?string $bankAccountNumber): void
    {
        $this->bankAccountNumber = $bankAccountNumber;
    }

    public function getStcPay(): ?string
    {
        return $this->stcPay;
    }

    public function setStcPay(?string $stcPay): void
    {
        $this->stcPay = $stcPay;
    }
}
