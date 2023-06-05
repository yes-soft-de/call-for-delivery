<?php

namespace App\Response\Admin\ExternalDeliveryCompany;

use DateTime;

class ExternalDeliveryCompanyUpdateByAdminResponse
{
    public int $id;

    public string $companyName;

    public bool $status;

    public DateTime $createdAt;

    public DateTime $updatedAt;
}
