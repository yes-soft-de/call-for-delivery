<?php

namespace App\Response\Admin\Order;

use OpenApi\Annotations as OA;
use DateTime;

class OrderDifferentDestinationFilterByAdminResponse
{
    public int $id;

    public DateTime $createdAt;

    public string $storeOwnerName;

    /**
     * @var string|null
     */
    public $branchName;

    /**
     * @var string|null
     */
    public $captainName;

    /**
     * @var int|null
     */
    public $paidToProvider;

    /**
     * @var int|null
     */
    public $isCashPaymentConfirmedByStore;

    /**
     * @var DateTime|null
     */
    public $isCashPaymentConfirmedByStoreUpdateDate;

    /**
     * @var string|null
     */
    public $storeBranchToClientDistanceAdditionExplanation;

    /**
     * @var float|null
     */
    public $storeBranchToClientDistance;

    /**
     * @OA\Property(type="array", property="destination",
     *     @OA\Items(type="object"))
     */
    public $destination;
}
