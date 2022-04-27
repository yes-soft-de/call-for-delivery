<?php

namespace App\Response\Admin\SupplierProfile;

use DateTime;

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

    public DateTime $createdAt;
}
