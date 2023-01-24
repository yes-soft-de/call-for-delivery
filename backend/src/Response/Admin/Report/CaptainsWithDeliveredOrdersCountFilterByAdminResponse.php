<?php

namespace App\Response\Admin\Report;

use OpenApi\Annotations as OA;

class CaptainsWithDeliveredOrdersCountFilterByAdminResponse
{
    // captain profile id
    public int $id;

    public int $captainId;

    public string $captainName;

    /**
     * @OA\Property(type="array", property="image",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $image;

    public string $ordersCount;

    public string $todayOrdersCount;

    ///TODO Currently has constant value because it will be commented out when frontend doesn't depend on it
    public string $lastTwentyFourOrdersCount = "0";
}
