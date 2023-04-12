<?php

namespace App\Response\Admin\StoreOwner;

use DateTime;
use OpenApi\Annotations as OA;

class StoreOwnerProfileGetByAdminResponse
{
    /**
     * @var int|null
     */
    public $id;

    /**
     * @var int|null
     */
    public $storeOwnerId;

    /**
     * @var string|null
     */
    public $storeOwnerName;

    /**
     * @OA\Property(type="array", property="images",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $images;

    /**
     * @var string|null
     */
    public $status;

    /**
     * @var string|null
     */
    public $roomID;

    /**
     * @var string|null
     */
    public $city;

    /**
     * @var int|null
     */
    public $storeCategoryId;

    /**
     * @var string|null
     */
    public $phone;

    /**
     * @var DateTime|null
     */
    public $openingTime;

    /**
     * @var DateTime|null
     */
    public $closingTime;

    /**
     * @var float|null
     */
    public $commission;

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
    public $employeeCount;

    public string $userId;

    public int $verificationStatus;

    public string $completeAccountStatus;

    /**
     * @var int|null
     */
    public $packageType;
}
