<?php

namespace App\Response\Admin\Order;

use DateTime;

class FilterDifferentlyAnsweredCashOrdersByAdminResponse
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
    public $isCashPaymentConfirmedByStore;

    /**
     * @var DateTime|null
     */
    public $isCashPaymentConfirmedByStoreUpdateDate;
}
