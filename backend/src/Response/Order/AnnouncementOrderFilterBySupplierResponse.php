<?php

namespace App\Response\Order;

use DateTime;

class AnnouncementOrderFilterBySupplierResponse
{
    public int $id;

    public DateTime $createdAt;

    public string $storeOwnerName;

    public int $announcementOrderDetailsId;

    public int $announcementId;
}
