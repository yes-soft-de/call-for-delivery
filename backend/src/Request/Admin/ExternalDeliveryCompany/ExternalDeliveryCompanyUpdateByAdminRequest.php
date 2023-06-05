<?php

namespace App\Request\Admin\ExternalDeliveryCompany;

class ExternalDeliveryCompanyUpdateByAdminRequest
{
    private int $id;

    private string $companyName;

    public function getId(): int
    {
        return $this->id;
    }
}
