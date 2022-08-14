<?php

namespace App\Response\SuperAdmin\Order;

use DateTime;

class IsCaptainPaidToProviderUpdateBySuperAdminResponse
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
     * @var string|null $note
     */
    public $note;

    public DateTime $deliveryDate;

    public DateTime $createdAt;

    /**
     * @var DateTime|null $note
     */
    public $updatedAt;

    /**
     * @var float|null $kilometer
     */
    public $kilometer;

    /**
     * @var int|null
     */
    public $paidToProvider;

    /**
     * @var float|null
     */
    public $captainOrderCost;

    /**
     * @var string|null
     */
    public $noteCaptainOrderCost;

    /**
     * @var float|null
     */
    public $storeBranchToClientDistance;

    /**
     * @var int|null
     */
    public $isCaptainPaidToProvider;

    /**
     * @var DateTime|null
     */
    public $dateCaptainPaidToProvider;
}
