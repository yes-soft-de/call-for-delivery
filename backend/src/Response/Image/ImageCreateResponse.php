<?php

namespace App\Response\Image;

class ImageCreateResponse
{
    /**
     * @var int|null
     */
    public $id;

    public string $imagePath;

    public int $entityType;

    public int $usedAs;

    public int $itemId;
}
