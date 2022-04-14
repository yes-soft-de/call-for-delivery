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

    public bool $status;

    public $roomId;
}
