<?php

namespace App\Response\Admin\OrderDistanceConflict;

use App\Entity\OrderEntity;
use DateTime;
use OpenApi\Annotations as OA;

class OrderDistanceConflictFilterByAdminResponse
{
    public int $id;

    /**
     * @var int|OrderEntity
     */
    public $orderId;

    public DateTime $createdAt;

    public DateTime $updatedAt;

    /**
     * @var int|null
     */
    public $conflictResolvedBy;

    /**
     * @var int|null
     */
    public $conflictResolvedByUserType;

    /**
     * @var DateTime|null
     */
    public $resolvedAt;

    public bool $isResolved;

    public string $conflictNote;

    /**
     * @var string|null
     */
    public $adminNote;

    /**
     * @var float|null
     */
    public $oldDistance;

    public ?float $newDistance;

    /**
     * @OA\Property(type="array", property="oldDestination",
     *     @OA\Items(type="object"))
     */
    public $oldDestination = [];

    /**
     * @OA\Property(type="array", property="newDestination",
     *     @OA\Items(type="object"), nullable=true)
     */
    public ?array $newDestination = [];

    // the proposed destination or kilometers by the user who create the conflict
    public string $proposedDestinationOrDistance;

    /**
     * refers to the type of the resolve: either by adding direct distance, or by adding new destination
     *
     * @var int|null
     */
    public $resolveType;

    /**
     * @var string|null
     */
    public $captainName;

    /**
     * @var int|null
     */
    public $captainProfileId;

    public string $storeOwnerName;

    public int $storeOwnerProfileId;

    public ?string $storeBranchName;
}
