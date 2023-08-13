<?php

namespace App\Response\StreetLine;

use DateTime;

class StreetLineOrderStatusUpdateResponse
{
    public int $externalOrderId;

    public DateTime $updatedAt;

    public string $status;
}
