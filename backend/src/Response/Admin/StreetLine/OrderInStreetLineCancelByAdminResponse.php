<?php

namespace App\Response\Admin\StreetLine;

use DateTime;

class OrderInStreetLineCancelByAdminResponse
{
    public DateTime $updatedAt;

    // The status of the order at the external company
    public string $status;
}
