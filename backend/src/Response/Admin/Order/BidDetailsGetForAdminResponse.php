<?php

namespace App\Response\Admin\Order;

use DateTime;
use OpenApi\Annotations as OA;

class BidDetailsGetForAdminResponse
{
    public int $id;

    public string $title;

    /**
     * @var string|null
     */
    public $description;

    public DateTime $createdAt;

    public DateTime $updatedAt;

    public int $supplierCategoryId;

    public string $supplierCategoryName;

    /**
     * @OA\Property(type="array", property="images",
     *     @OA\Items(type="object"))
     */
    public $images;

    public bool $openToPriceOffer;

    /**
     * @OA\Property(type="object", property="sourceDestination")
     */
    public $sourceDestination;
}
