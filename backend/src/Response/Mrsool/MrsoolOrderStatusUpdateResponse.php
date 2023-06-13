<?php

namespace App\Response\Mrsool;

use DateTime;

class MrsoolOrderStatusUpdateResponse
{
    public int $externalOrderId;

    public DateTime $updatedAt;

    public string $status;
}
