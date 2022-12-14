<?php

namespace App\Response\Admin\Order;

use DateTime;
use OpenApi\Annotations as OA;

class OrderCurrentFinancialCycleByCaptainProfileIdForAdminGetResponse
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
     * @var DateTime|null
     */
    public $updatedAt;

    /**
     * @var int|null
     */
    public $storeOrderDetailsId;

    /**
     * @var string|null
     */
    public $detail;

    public string $storeOwnerName;

    /**
     * @var float|null
     */
    public $captainOrderCost;

    /**
     * @OA\Property(type="object", property="destination")
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
    public $branchName;

    /**
     * @OA\Property(type="object", property="location")
     */
    public $location;

    public int $storeOwnerBranchId;

    /**
     * @var int|null
     */
    public $orderIsMain;
}
