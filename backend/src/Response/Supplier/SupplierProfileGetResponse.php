<?php

namespace App\Response\Supplier;

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
     * @var array|null
     */
    public $images;

    /**
     * @var object|null
     */
    public $createdAt;

    /**
     * @var string|null
     */
    public $supplierCategoryName;

    /**
     * @var int|null
     */
    public $supplierCategoryId;

    public bool $status;

    public $roomId;
}
