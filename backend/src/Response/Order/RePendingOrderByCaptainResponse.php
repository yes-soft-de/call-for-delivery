<?php

namespace App\Response\Order;

use DateTime;

class RePendingOrderByCaptainResponse
{
    public int $id;

    public string $state;

    /**
     * @var string|null
     */
    public $payment;

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
     * @var string|null
     */
    private $noteCaptainOrderCost;

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
     * @var bool|null
     */
    public $isCaptainArrived;

    /**
     * @var DateTime|null
     */
    public $dateCaptainArrived;

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

    // Auto-calculated value depending on the distance which is being calculated by Google MAP API
    /**
     * @var float|null
     */
    public $deliveryCost;

    /**
     * @var int|null
     */
    public $conflictedAnswersResolvedBy;

    // store isHide value before hide order for updating it
    public int $previousVisibility;

    /**
     * @var string|null
     */
    public $storeBranchToClientDistanceAdditionExplanation;

    /**
     * @var int|null
     */
    public $costType;

    /**
     * @var int|null
     */
    public $orderCancelledByUserAndAtState;
}
