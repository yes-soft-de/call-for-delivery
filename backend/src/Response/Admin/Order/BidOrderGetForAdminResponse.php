<?php

namespace App\Response\Admin\Order;

use DateTime;

class BidOrderGetForAdminResponse
{
    public int $id;

    public string $state;

    /**
     * @var float|null
     */
    public $orderCost;

    public int $orderType;

    /**
     * @var DateTime|null
     */
    public $deliveryDate;

    /**
     * @var DateTime|null
     */
    public $createdAt;

    /**
     * @var DateTime|null
     */
    public $updatedAt;

    /**
     * @var string|null
     */
    public $detail;

    /**
     * @var int|null
     */
    public $storeOwnerProfileId;

    /**
     * @var int|null
     */
    public $storeOwnerId;

    /**
     * @var string|null
     */
    public $storeOwnerName;

    /**
     * @var string|null
     */
    public $storeOwnerPhone;

    /**
     * @var int|null
     */
    public $storeOwnerBranchId;

    /**
     * @var string|null
     */
    public $storeOwnerBranchPhone;

    /**
     * @var string|null
     */
    public $storeOwnerBranchName;

    /**
     * @var int|null
     */
    public $bidDetailsId;

    /**
     * @var bool|null
     */
    public $openToPriceOffer;
}
