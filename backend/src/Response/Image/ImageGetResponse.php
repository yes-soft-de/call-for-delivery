<?php

namespace App\Response\Image;

use DateTime;
use OpenApi\Annotations as OA;

class ImageGetResponse
{
    public int $id;

    /**
     * @OA\Property(type="array", property="image",
     *     @OA\Items(type="object"))
     */
    public $image;

    public int $entityType;

    public int $usedAs;

    public int $itemId;

    public datetime $createdAt;

    public datetime $updatedAt;

    public int $bidDetailsId;
}
