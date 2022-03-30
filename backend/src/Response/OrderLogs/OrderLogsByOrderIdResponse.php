<?php

namespace App\Response\OrderLogs;

use App\Entity\OrderEntity;
use App\Entity\CaptainEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\StoreOwnerBranchEntity;

class OrderLogsByOrderIdResponse
{
    public int $id;

    public CaptainEntity|null $captainProfile;

    public StoreOwnerProfileEntity|null $storeOwnerProfile;

    public object $createdAt;

    public string $orderState;

    public StoreOwnerBranchEntity|null $storeOwnerBranch;
}
