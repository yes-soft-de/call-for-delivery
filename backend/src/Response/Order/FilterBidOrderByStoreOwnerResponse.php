<?php

namespace App\Response\Order;

use DateTime;

class FilterBidOrderByStoreOwnerResponse
{
    public int $id;

    public int $bidDetailsId;

    /**
     * @var string|null
     */
    public $title;

    public bool $openToPriceOffer;

    public string $state;

    /**
     * @var string|null
     */
    public $payment;

    public int $orderType;

    /**
     * @var string|null
     */
    public $note;

    public DateTime $deliveryDate;

    public DateTime $createdAt;

    /**
     * @var int|null
     */
    public $storeOwnerBranchId;

    /**
     * @var string|null
     */
    public $branchName;

    /**
     * @var string|null
     */
    public $branchPhone;

    /**
     * @var int|null
     */
    public $supplierCategoryId;

    /**
     * @var string|null
     */
    public $supplierCategoryName;
}
