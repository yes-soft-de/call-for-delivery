<?php

namespace App\Response\Admin\Report;

use OpenApi\Annotations as OA;

class TopOrdersStoresForCurrentMonthByAdminGetResponse
{
    public string $storeOwnerName;

    /**
     * @OA\Property(type="array", property="image",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $image;

    public string $storeBranchName;

    public int $ordersCount;
}
