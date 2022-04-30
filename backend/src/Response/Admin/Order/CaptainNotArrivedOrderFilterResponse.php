<?php

namespace App\Response\Admin\Order;

use DateTime;

class CaptainNotArrivedOrderFilterResponse
{
    public int $id;

    public DateTime $createdAt;

    public string $storeOwnerName;

    /**
     * @var string|null
     */
    public $branchName;

    /**
     * @var string|null
     */
    public $captainName;
}
