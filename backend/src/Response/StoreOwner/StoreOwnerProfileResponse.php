<?php

namespace App\Response\StoreOwner;

use DateTime;
use OpenApi\Annotations as OA;

class StoreOwnerProfileResponse
{
    /**
     * @var int|null
     */
    public $id;

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
    public $phone;

    /**
     * @var string|null
     */
    public $city;

    /**
     * @var string|null
     */
    public $status;

    /**
     * @var int|null
     */
    public $storeCategoryId;

    /**
     * @var DateTime|null
     */
    public $openingTime;

    /**
     * @var DateTime|null
     */
    public $closingTime;

    /**
     * @var string|null
     */
    public $employeeCount;

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
     * @var string|null $roomId
     */
    public $roomId;

    /**
     * @var float|null
     */
    public $profitMargin;
}
