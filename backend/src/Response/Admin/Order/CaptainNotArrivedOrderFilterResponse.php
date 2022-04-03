<?php

namespace App\Response\Admin\Order;

class CaptainNotArrivedOrderFilterResponse
{
    public int $id;

    public object $createdAt;

    public string $storeOwnerName;

    /**
     * @var string|null
     */
    public ?string $branchName;

    /**
     * @var string|null
     */
    public ?string $captainName;
}
