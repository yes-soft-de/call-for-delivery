<?php

namespace App\Response\Image;

class ImageCreateResponse
{
    public int $id;

    public string $imagePath;

    public int $entityType;

    public int $usedAs;

    public int $itemId;
}
