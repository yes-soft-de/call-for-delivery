<?php

namespace App\Response\Supplier;

use DateTime;

class SupplierProfileUpdateResponse
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
     * @var DateTime|null
     */
    public $createdAt;
}
