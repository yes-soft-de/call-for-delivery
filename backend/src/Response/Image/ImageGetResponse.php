<?php

namespace App\Response\Image;

use DateTime;

class ImageGetResponse
{
    public int $id;

    public array $image;

    public int $entityType;

    public int $usedAs;

    public int $itemId;

    public datetime $createdAt;

    public datetime $updatedAt;
}
