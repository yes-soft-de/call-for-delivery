<?php

namespace App\Response\Admin\Report;

use OpenApi\Annotations as OA;

class TopOrdersStoresForCurrentMonthByAdminGetResponse
{
    // Store Owner profile id
    public int $id;

    public string $storeOwnerName;

    /**
     * @OA\Property(type="array", property="image",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $image;

    public string $storeBranchName;

    public int $ordersCount;
}
