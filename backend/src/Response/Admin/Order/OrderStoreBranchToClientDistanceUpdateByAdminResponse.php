<?php

namespace App\Response\Admin\Order;

use DateTime;
use OpenApi\Annotations as OA;

class OrderStoreBranchToClientDistanceUpdateByAdminResponse
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
     * @var string|null $detail
     */
    public $detail;

    /**
     * @OA\Property(type="object", property="location")
     */
    public $location;

    /**
     * @var string|null $phone
     */
    public $phone;

    public int|null $paidToProvider;

    public int $storeOwnerId;

    public float|null $captainOrderCost;

    public string|null $noteCaptainOrderCost;

    public float|null $storeBranchToClientDistance;

    /**
     * @var int|null
     */
    public $isCashPaymentConfirmedByStore;

    /**
     * @var DateTime|null
     */
    public $isCashPaymentConfirmedByStoreUpdateDate;
}
