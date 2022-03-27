<?php

namespace App\Request\Image;

use App\Entity\AdminProfileEntity;

class ImageCreateRequest
{
    private string $imagePath;

    private int $entityType;

    private int $usedAs;

    private int $itemId;

    /**
     * @var AdminProfileEntity|null
     */
    private $adminProfile;

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

    public function setAdminProfile(?AdminProfileEntity $adminProfile): void
    {
        $this->adminProfile = $adminProfile;
    }
}
