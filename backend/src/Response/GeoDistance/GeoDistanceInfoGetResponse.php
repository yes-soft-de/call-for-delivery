<?php

namespace App\Response\GeoDistance;

use OpenApi\Annotations as OA;

class GeoDistanceInfoGetResponse
{
    /**
     * @OA\Property(type="array", property="distance",
     *     @OA\Items(type="object"))
     */
    public $distance;

    /**
     * @OA\Property(type="array", property="duration",
     *     @OA\Items(type="object"))
     */
    public $duration;

    public string $status;
}
