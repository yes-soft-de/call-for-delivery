<?php

namespace App\Request\Image;

class ImageUpdateRequest
{
    private int $id;
    
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

    /**
     * Get the value of id
     */ 
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set the value of id
     *
     * @return  self
     */ 
    public function setId($id)
    {
        $this->id = $id;

        return $this;
    }
}
