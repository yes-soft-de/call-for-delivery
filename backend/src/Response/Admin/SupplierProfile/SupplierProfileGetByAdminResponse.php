<?php

namespace App\Response\Admin\SupplierProfile;

use DateTime;
use OpenApi\Annotations as OA;

class SupplierProfileGetByAdminResponse
{
    public int $id;

    /**
     * @OA\Property(type="object", property="user")
     */
    public $user;

    public string $supplierName;

    /**
     * @var string|null
     */
    public $phone;

    /**
     * @OA\Property(type="array", property="images",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $images;

    public bool $status;

    public DateTime $createdAt;

    /**
     * @var string|null
     */
    public $supplierCategoryName;

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
}
