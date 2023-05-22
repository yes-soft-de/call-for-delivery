<?php

namespace App\Response\OrderDistanceConflict;

use DateTime;
use OpenApi\Annotations as OA;

class OrderDistanceConflictCreateByCaptainResponse
{
    public int $id;

    public int $conflictIssuedBy;

    public int $conflictIssuedByUserType;

    public DateTime $createdAt;

    public DateTime $updatedAt;

    public bool $isResolved;

    public string $conflictNote;

    /**
     * @var float|null
     */
    public $oldDistance;

    /**
     * @OA\Property(type="array", property="oldDestination",
     *     @OA\Items(type="object"))
     */
    public $oldDestination;

    public string $proposedDestinationOrDistance;
}
