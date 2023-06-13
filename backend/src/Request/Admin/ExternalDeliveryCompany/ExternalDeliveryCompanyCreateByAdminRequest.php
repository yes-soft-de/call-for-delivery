<?php

namespace App\Request\Admin\ExternalDeliveryCompany;

class ExternalDeliveryCompanyCreateByAdminRequest
{
    private string $companyName;

    private bool $status;

    public function getStatus(): bool
    {
        return $this->status;
    }

    public function setStatus(bool $status): void
    {
        $this->status = $status;
    }
}
