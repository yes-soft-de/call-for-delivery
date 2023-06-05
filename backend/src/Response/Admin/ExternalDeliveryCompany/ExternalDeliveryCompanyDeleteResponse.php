<?php

namespace App\Response\Admin\ExternalDeliveryCompany;

use DateTime;

class ExternalDeliveryCompanyDeleteResponse
{
    public string $companyName;

    public bool $status;

    public DateTime $createdAt;

    public DateTime $updatedAt;
}
