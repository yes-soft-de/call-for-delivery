<?php

namespace App\Request\Admin\ExternalDeliveryCompany;

class ExternalDeliveryCompanyDeleteByIdRequest
{
    private int $id;

    public function getId(): int
    {
        return $this->id;
    }
}
