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

    public function getId(): int
    {
        return $this->id;
    }
}
