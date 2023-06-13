<?php

namespace App\Response\Admin\ExternalDeliveryCompanyCriteria;

use DateTime;
use OpenApi\Annotations as OA;

class ExternalDeliveryCompanyCriteriaDeleteResponse
{
    public string $criteriaName;

    public bool $isSpecificDate;

    public ?DateTime $fromDate;

    public ?DateTime $toDate;

    // 205: off. 206: storeBranchToClientDistance
    public int $isDistance;

    public ?float $fromDistance;

    public ?float $toDistance;

    // 207: off. 208: card. 209: cash. 210: both
    public int $payment;

    public bool $isFromAllStores;

    /**
     * @OA\Property(type="array", property="fromStores",
     *     @OA\Items(type="object"))
     */
    public ?array $fromStores;

    public DateTime $createdAt;

    public DateTime $updatedAt;
}
