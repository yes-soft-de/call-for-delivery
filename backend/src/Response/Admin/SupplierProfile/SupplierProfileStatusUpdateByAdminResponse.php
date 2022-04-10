<?php

namespace App\Response\Admin\SupplierProfile;

class SupplierProfileStatusUpdateByAdminResponse
{
    public int $id;

    public string $supplierName;

    /**
     * @var string|null
     */
    public $phone;

    /**
     * @var bool|null
     */
    public $status;

    public object $createdAt;
}
