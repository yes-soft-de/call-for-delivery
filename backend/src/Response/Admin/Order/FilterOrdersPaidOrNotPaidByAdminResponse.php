<?php

namespace App\Response\Admin\Order;

use DateTime;

class FilterOrdersPaidOrNotPaidByAdminResponse
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

    public null|int $paidToProvider;
   
    public null|int $isCaptainPaidToProvider;
   
    public object|int $dateCaptainPaidToProvider;
}
