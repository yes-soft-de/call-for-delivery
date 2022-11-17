<?php

namespace App\Response\Admin\Report;

use OpenApi\Annotations as OA;

class CaptainsRatingsForAdminGetResponse
{
    public int $id;

    public string $captainName;

    public string $avgRating;

    /**
     * @OA\Property(type="array", property="image",
     *     @OA\Items(type="object"), nullable=true)
     */
    public $image;
}
