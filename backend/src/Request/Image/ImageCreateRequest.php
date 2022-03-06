<?php

namespace App\Request\Image;

class ImageCreateRequest
{
    private string $imagePath;

    private int $entityType;

    private int $usedAs;

    private int $itemId;

    public function setImagePath(string $imagePath): void
    {
        $this->imagePath = $imagePath;
    }

    public function setEntityType(int $entityType): void
    {
        $this->entityType = $entityType;
    }

    public function setUsedAs(int $usedAs): void
    {
        $this->usedAs = $usedAs;
    }

    public function setItemId(int $itemId): void
    {
        $this->itemId = $itemId;
    }
}
