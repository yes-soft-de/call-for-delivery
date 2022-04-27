<?php

namespace App\Request\Image;

use App\Entity\AdminProfileEntity;
use App\Entity\AnnouncementEntity;
use App\Entity\BidDetailsEntity;
use App\Entity\SupplierProfileEntity;

class ImageCreateRequest
{
    private string $imagePath;

    private int $entityType;

    private int $usedAs;

    private int $itemId;

    /**
     * @var AdminProfileEntity|null
     */
    private $user;

    /**
     * @var SupplierProfileEntity|null
     */
    private $supplierProfile;

    /**
     * @var AnnouncementEntity|null
     */
    private $announcement;

    /**
     * @var BidDetailsEntity|null
     */
    private $bidDetails;

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

    public function setUser(?AdminProfileEntity $user): void
    {
        $this->user = $user;
    }

    public function setSupplierProfile(?SupplierProfileEntity $supplierProfile): void
    {
        $this->supplierProfile = $supplierProfile;
    }

    public function setAnnouncement(?AnnouncementEntity $announcement): void
    {
        $this->announcement = $announcement;
    }

    public function setBidDetails(?BidDetailsEntity $bidDetails): void
    {
        $this->bidDetails = $bidDetails;
    }
}
