<?php

namespace App\Request\Image;

class ImageUpdateRequest
{
    private int $id;

    private string $imagePath;

    private int $entityType;

    private int $usedAs;

    private int $itemId;

    public function getId(): int
    {
        return $this->id;
    }

    /**
     * @param int $id
     */
    public function setId(int $id): void
    {
        $this->id = $id;
    }

    /**
     * @param string $imagePath
     */
    public function setImagePath(string $imagePath): void
    {
        $this->imagePath = $imagePath;
    }

    /**
     * @param int $entityType
     */
    public function setEntityType(int $entityType): void
    {
        $this->entityType = $entityType;
    }

    /**
     * @param int $usedAs
     */
    public function setUsedAs(int $usedAs): void
    {
        $this->usedAs = $usedAs;
    }

    /**
     * @param int $itemId
     */
    public function setItemId(int $itemId): void
    {
        $this->itemId = $itemId;
    }
}
