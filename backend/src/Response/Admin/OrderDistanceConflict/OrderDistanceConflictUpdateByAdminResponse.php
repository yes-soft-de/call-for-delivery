<?php

namespace App\Response\Admin\OrderDistanceConflict;

use DateTime;
use OpenApi\Annotations as OA;

class OrderDistanceConflictUpdateByAdminResponse
{
    public int $id;

    public DateTime $createdAt;

    public DateTime $updatedAt;

    public ?int $conflictResolvedBy;

    public ?int $conflictResolvedByUserType;

    public ?DateTime $resolvedAt;

    public bool $isResolved;

    public string $conflictNote;

    public ?string $adminNote;

    public ?float $oldDistance;

    public ?float $newDistance;

    /**
     * @OA\Property(type="array", property="oldDestination",
     *     @OA\Items(type="object"))
     */
    public array $oldDestination = [];

    /**
     * @OA\Property(type="array", property="newDestination",
     *     @OA\Items(type="object"), nullable=true)
     */
    public ?array $newDestination = [];

    // the proposed destination or kilometers by the user who create the conflict
    public string $proposedDestinationOrDistance;

    /**
     * refers to the type of the resolve: either by adding direct distance, or by adding new destination
     */
    public ?int $resolveType;
}
