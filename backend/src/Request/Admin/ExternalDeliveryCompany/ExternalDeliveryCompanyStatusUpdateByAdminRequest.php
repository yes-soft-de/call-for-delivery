<?php

namespace App\Request\Admin\ExternalDeliveryCompany;

class ExternalDeliveryCompanyStatusUpdateByAdminRequest
{
    private int $id;

    private bool $status;

    public function getId(): int
    {
        return $this->id;
    }

    public function getStatus(): bool
    {
        return $this->status;
    }
}
