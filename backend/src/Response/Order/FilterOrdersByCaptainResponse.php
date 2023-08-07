<?php

namespace App\Response\Order;

class FilterOrdersByCaptainResponse
{
    /**
     * @var int|null
     */
    public $id;

    /**
     * @var string|null
     */
    public $state;

    /**
     * @var string|null
     */
    public $payment;

    /**
     * @var float|null
     */
    public $orderCost;

    /**
     * @var int|null
     */
    public $orderType;

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
    public $location;

    /**
     * @var string|null
     */
    public $branchName;

    /**
     * @var string|null
     */
    public $storeOwnerName;

    /**
     * @var object|null
     */
    public $sourceDestination;

    public array|null $subOrder;

    public ?float $profit;
}
