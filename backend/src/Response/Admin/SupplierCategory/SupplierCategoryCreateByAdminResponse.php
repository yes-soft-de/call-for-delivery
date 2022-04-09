<?php

namespace App\Response\Admin\SupplierCategory;

class SupplierCategoryCreateByAdminResponse
{
    public int $id;

    public string $name;

    public ?string $description;

    public bool $status;
}
