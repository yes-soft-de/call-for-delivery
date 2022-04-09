<?php

namespace App\Response\Admin\SupplierProfile;

class SupplierProfileGetByAdminResponse
{
    public int $id;

    public string $supplierName;

    /**
     * @var string|null
     */
    public $phone;

    /**
     * @var array|null
     */
    public $images;
}
