<?php

namespace App\Response\GeoDistance;

use OpenApi\Annotations as OA;

class GeoDistanceInfoGetResponse
{
    public string $distance;

    /**
     * @OA\Property(type="object", property="costDeliveryOrder", nullable=true)
     */
    public $costDeliveryOrder;
}
