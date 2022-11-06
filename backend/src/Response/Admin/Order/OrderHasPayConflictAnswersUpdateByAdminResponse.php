<?php

namespace App\Response\Admin\Order;

use DateTime;

class OrderHasPayConflictAnswersUpdateByAdminResponse
{
    public int $id;

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
     * @var string|null
     */
    public $noteCaptainOrderCost;

    public DateTime $deliveryDate;

    public DateTime $createdAt;

    /**
     * @var DateTime|null
     */
    public $updatedAt;

    /**
     * @var float|null
     */
    public $kilometer;

    /**
     * @var float|null
     */
    public $captainOrderCost;

    /**
     * @var int|null
     */
    public $paidToProvider;

    /**
     * @var int|null
     */
    public $isHide;

    /**
     * @var bool|null
     */
    public $orderIsMain;

    /**
     * @var float|null
     */
    public $storeBranchToClientDistance;

    /**
     * @var int|null
     */
    public $isCashPaymentConfirmedByStore;

    /**
     * @var DateTime|null
     */
    public $isCashPaymentConfirmedByStoreUpdateDate;

    /**
     * @var int|null
     */
    public $hasPayConflictAnswers;

    /**
     * @var float|null
     */
    public $deliveryCost;
}
