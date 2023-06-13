<?php

namespace App\Response\Admin\ExternallyDeliveredOrder;

use DateTime;

class ExternallyDeliveredOrderCreateByAdminResponse
{
    public int $id;

    public int $externalOrderId;

    public DateTime $createdAt;

    public string $status;
}
