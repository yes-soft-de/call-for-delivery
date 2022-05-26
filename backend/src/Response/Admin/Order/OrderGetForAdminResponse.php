<?php

namespace App\Response\Admin\Order;

class OrderGetForAdminResponse
{
    public int $id;

    public string $state;

    public string $payment;

    public float $orderCost;

    public int $orderType;

    /**
     * @var string|null
     */
    public $note;

    /**
     * @var array|null
     */
    public $deliveryDate;

    /**
     * @var array|null
     */
    public $createdAt;

    /**
     * @var array|null
     */
    public $updatedAt;

    /**
     * @var float|null
     */
    public $kilometer;

    /**
     * @var int|null
     */
    public $storeOrderDetailsId;

    /**
     * @var array|null
     */
    public $destination;

    /**
     * @var string|null
     */
    public $recipientName;

    /**
     * @var string|null
     */
    public $recipientPhone;

    /**
     * @var string|null
     */
    public $detail;

    public int $storeOwnerBranchId;

    /**
     * @var array|null
     */
    public $location;

    public string $branchName;

    /**
     * @var int|null
     */
    public $imageId;

    /**
     * @var array|null
     */
    public $images;
}
