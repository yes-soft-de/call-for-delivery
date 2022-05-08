<?php

namespace App\Response\BidDetails;

use DateTime;
use OpenApi\Annotations as OA;

class BidDetailsGetForCaptainResponse
{
    public int $id;

    public string $title;

    /**
     * @var string|null
     */
    public $description;

    public DateTime $createdAt;

    public DateTime $updatedAt;

    /**
     * @OA\Property(type="array", property="images",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $images;

    public bool $openToPriceOffer;

    /**
     * @OA\Property(type="array", property="sourceDestination",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $sourceDestination;

    public int $storeOwnerBranchId;

    public string $branchName;

    /**
     * @var string|null
     */
    public $branchPhone;

    /**
     * @OA\Property(type="array", property="location",
     *     @OA\Items(type="object"))
     */
    public $location;
}
