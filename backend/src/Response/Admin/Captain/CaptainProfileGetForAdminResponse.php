<?php

namespace App\Response\Admin\Captain;

class CaptainProfileGetForAdminResponse
{
    public int $id;

    public int $captainId;

    /**
     * @var string|null
     */
    public $captainName;

    /**
     * @var array|null
     */
    public $images;

    /**
     * @var array|null
     */
    public $location;

    /**
     * @var int|null
     */
    public $age;

    /**
     * @var string|null
     */
    public $car;

    /**
     * @var float|null
     */
    public $salary;

    /**
     * @var string|null
     */
    public $status;

    /**
     * @var float|null
     */
    public null|float $bounce;

    /**
     * @var string|null
     */
    public $phone;

    public bool $isOnline;

    /**
     * @var string|null
     */
    public $bankName;

    /**
     * @var string|null
     */
    public $bankAccountNumber;

    /**
     * @var string|null
     */
    public $stcPay;

    /**
     * @var string|null
     */
    public $mechanicLicense;

    /**
     * @var string|null
     */
    public $drivingLicence;

    /**
     * @var string|null
     */
    public $identity;

    /**
     * @var string|null
     */
    public $roomId;
}
