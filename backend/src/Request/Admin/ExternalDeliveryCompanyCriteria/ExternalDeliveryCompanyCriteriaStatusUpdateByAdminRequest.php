<?php

namespace App\Request\Admin\ExternalDeliveryCompanyCriteria;

use App\Entity\AdminProfileEntity;

class ExternalDeliveryCompanyCriteriaStatusUpdateByAdminRequest
{
    private int $id;

    private bool $status;

    private int|AdminProfileEntity $updatedBy;

    public function getId(): int
    {
        return $this->id;
    }

    public function setUpdatedBy(AdminProfileEntity|int $updatedBy): void
    {
        $this->updatedBy = $updatedBy;
    }

    public function isStatus(): bool
    {
        return $this->status;
    }
}
