<?php

namespace App\Response\Admin\StoreOwner;

use DateTime;
use OpenApi\Annotations as OA;

class StoreOwnerProfileByIdGetByAdminResponse
{
    /**
     * @var int|null $id
     */
    public $id;

    /**
     * @var int|null $storeOwnerId
     */
    public $storeOwnerId;

    /**
     * @var string|null $storeOwnerName
     */
    public $storeOwnerName;

    /**
     * @OA\Property(type="array", property="images",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $images;

    /**
     * @var string|null $status
     */
    public $status;

    /**
     * @var string|null $roomID
     */
    public $roomID;

    /**
     * @var string|null $city
     */
    public $city;

    /**
     * @var int|null $storeCategoryId
     */
    public $storeCategoryId;

    /**
     * @var string|null $phone
     */
    public $phone;

    /**
     * @var DateTime|null $openingTime
     */
    public $openingTime;

    /**
     * @var DateTime|null $closingTime
     */
    public $closingTime;

    /**
     * @var float|null $commission
     */
    public $commission;

    /**
     * @var string|null $bankName
     */
    public $bankName;

    /**
     * @var string|null $bankAccountNumber
     */
    public $bankAccountNumber;

    /**
     * @var string|null $stcPay
     */
    public $stcPay;

    /**
     * @var string|null $employeeCount
     */
    public $employeeCount;

    /**
     * @OA\Property(type="array", property="branches",
     *     @OA\Items(type="object"))
     */
    public $branches;
    
    /**
     * @var string|null $roomId
     */
    public $roomId;

    /**
     * @var float|null
     */
    public $profitMargin;
}
