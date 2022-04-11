<?php

namespace App\Response\Admin\SupplierProfile;

use App\Entity\SupplierCategoryEntity;
use App\Entity\UserEntity;

class SupplierProfileGetByAdminResponse
{
    public int $id;

    /**
     * @var UserEntity|array
     */
    public $user;

    public string $supplierName;

    /**
     * @var string|null
     */
    public $phone;

    /**
     * @var array|null
     */
    public $images;

    public bool $status;

    public object $createdAt;

    /**
     * @var string|null
     */
    public $supplierCategoryName;
}
