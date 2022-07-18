<?php

namespace App\Response\Admin\Order;

class OrderGetForAdminResponse
{
    public int $id;

    public string $state;

    public string $payment;

    /**
     * @var float|null
     */
    public $orderCost;

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

    /**
     * @var int|null
     */
    public $storeOwnerBranchId;

    /**
     * @var array|null
     */
    public $location;

    /**
     * @var string|null
     */
    public $branchName;

    /**
     * @var int|null
     */
    public $imageId;

    /**
     * @var array|null
     */
    public $images;
    
    /**
     * @var int
     */
    public $countOrders;
}
