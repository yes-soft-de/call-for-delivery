<?php

namespace App\Request\Image;

class ImageCreateRequest
{
    private $imagePath;

    private $entityType;

    private $imageAim;

    private $itemId;

    public function setImagePath(string $imagePath): void
    {
        $this->imagePath = $imagePath;
    }

    public function setEntityType(string $entityType): void
    {
        $this->entityType = $entityType;
    }

    public function setImageAim(string $imageAim): void
    {
        $this->imageAim = $imageAim;
    }

    public function setItemId(int $itemId): void
    {
        $this->itemId = $itemId;
    }
}
