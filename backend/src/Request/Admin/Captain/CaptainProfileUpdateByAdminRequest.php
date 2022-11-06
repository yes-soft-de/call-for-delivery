<?php

namespace App\Request\Admin\Captain;

class CaptainProfileUpdateByAdminRequest
{
    private int $id;

    private string $captainName;

    /**
     * @var string|null
     */
    private $images;

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

    /**
     * @var string|null
     */
    private $phone;

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

    /**
     * @var string|null
     */
    private $address;

    public function getId(): int
    {
        return $this->id;
    }

    /**
     * @return string|null
     */
    public function getImages(): ?string
    {
        return $this->images;
    }

    /**
     * @return string|null
     */
    public function getMechanicLicense(): ?string
    {
        return $this->mechanicLicense;
    }

    /**
     * @return string|null
     */
    public function getIdentity(): ?string
    {
        return $this->identity;
    }

    /**
     * @return string|null
     */
    public function getDrivingLicence(): ?string
    {
        return $this->drivingLicence;
    }
}
