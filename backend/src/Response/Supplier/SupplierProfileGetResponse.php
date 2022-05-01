<?php

namespace App\Response\Supplier;

use DateTime;
use OpenApi\Annotations as OA;

class SupplierProfileGetResponse
{
    /**
     * @var int|null
     */
    public $id;

    /**
     * @var string|null
     */
    public $supplierName;

    /**
     * @var string|null
     */
    public $phone;

    /**
     * @OA\Property(type="array", property="images",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $images;

    public DateTime $createdAt;

    /**
     * Will be removed when front doesn't depend on it
     * @var string|null
     */
    public $supplierCategoryName;

    /**
     * Will be removed when front doesn't depend on it
     * @var int|null
     */
    public $supplierCategoryId;

    public bool $status;

    /**
     * @var string|null
     */
    public $roomId;

    /**
     * @OA\Property(type="object", property="location", nullable=true)
     */
    public $location;

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
     * @OA\Property(type="array", property="supplierCategories",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $supplierCategories;

    /**
     * @var float|null
     */
    public $profitMargin;
}
