<?php

namespace App\Request\Admin\ExternalDeliveryCompanyCriteria;

class ExternalDeliveryCompanyCriteriaDeleteByAdminRequest
{
    private int $id;

    public function getId(): int
    {
        return $this->id;
    }
}
