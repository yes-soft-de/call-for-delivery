<?php

namespace App\Response\Admin\Order;

class OrderByIdGetForAdminResponse
{
    public int $id;

    public string $state;

    public string $payment;

    public float $orderCost;

    public int $orderType;

    public array|null $orderLogs;

    /**
     * @var string|null $note
     */
    public $note;

    /**
     * @var array|null $deliveryDate
     */
    public $deliveryDate;

    /**
     * @var array|null $createdAt
     */
    public $createdAt;

    /**
     * @var array|null $updatedAt
     */
    public $updatedAt;

    /**
     * @var float|null $kilometer
     */
    public $kilometer;

    /**
     * @var int|null $storeOrderDetailsId
     */
    public $storeOrderDetailsId;

    /**
     * @var array|null $destination
     */
    public $destination;

    /**
     * @var string|null $recipientName
     */
    public $recipientName;

    /**
     * @var string|null $recipientPhone
     */
    public $recipientPhone;

    /**
     * @var string|null $detail
     */
    public $detail;

    public int $storeOwnerBranchId;

    /**
     * @var array|null $location
     */
    public $location;

    public string $branchName;

    /**
     * @var array|null $orderImage
     */
    public $orderImage;

    /**
     * @var int|null $captainUserId
     */
    public $captainUserId;

    /**
     * @var string|null $captainName
     */
    public $captainName;

    /**
     * @var string|null $phone
     */
    public $phone;

    public int|null $paidToProvider;
}
