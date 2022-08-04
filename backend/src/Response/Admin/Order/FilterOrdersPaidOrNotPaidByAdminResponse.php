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

    /**
     * @var int|null
     */
    public $paidToProvider;

    /**
     * @var int|null
     */
    public $isCaptainPaidToProvider;

    /**
     * @var DateTime|null
     */
    public $dateCaptainPaidToProvider;
}
