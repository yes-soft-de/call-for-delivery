<?php

namespace App\Response\Order;

use DateTime;

class CashOrdersPaidOrNotFilterByStoreResponse
{
    public int $id;

    public DateTime $createdAt;

    public string $storeOwnerName;

    public ?string $branchName;

    public ?string $captainName;

    public ?int $paidToProvider;

    public ?int $isCashPaymentConfirmedByStore;

    public ?DateTime $isCashPaymentConfirmedByStoreUpdateDate;

    public ?float $orderCost;

    public ?DateTime $deliveryDate;
}