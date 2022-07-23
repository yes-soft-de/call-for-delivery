<?php

namespace App\Response\Admin\Captain;

use OpenApi\Annotations as OA;

class CaptainProfileGetForAdminResponse
{
    public int $id;

    public int $captainId;

    /**
     * @var string|null
     */
    public $captainName;

    /**
     * @OA\Property(type="array", property="images",
     *     @OA\Items(type="string"))
     */
    public $images;

    /**
     * @OA\Property(type="array", property="location",
     *     @OA\Items(type="object"))
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
    public $bounce;

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
     * @OA\Property(type="array", property="mechanicLicense",
     *     @OA\Items(type="object"))
     */
    public $mechanicLicense;

    /**
     * @OA\Property(type="array", property="drivingLicence",
     *     @OA\Items(type="object"))
     */
    public $drivingLicence;

    /**
     * @OA\Property(type="array", property="identity",
     *     @OA\Items(type="object"))
     */
    public $identity;

    /**
     * @var string|null
     */
    public $roomId;

    /**
     * @OA\Property(type="object", nullable=true)
     */
    public $financialCaptainSystemDetails;

    public string $userId;

    public int $verificationStatus;

    public string $completeAccountStatus;
}
