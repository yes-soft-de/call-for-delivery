<?php

namespace App\Request\Order;

use App\Entity\AnnouncementEntity;
use App\Entity\StoreOwnerProfileEntity;

class AnnouncementOrderCreateRequest
{
    /**
     * @var string|null
     */
    private $payment;

    /**
     * @var string|null
     */
    private $note;

    /**
     * @var int|StoreOwnerProfileEntity
     */
    private $storeOwner;

    /**
     * @var int|AnnouncementEntity
     */
    private $announcement;

    public function getStoreOwner(): int|StoreOwnerProfileEntity
    {
        return $this->storeOwner;
    }

    public function setStoreOwner(int|StoreOwnerProfileEntity $storeOwner): void
    {
        $this->storeOwner = $storeOwner;
    }

    public function getAnnouncement(): AnnouncementEntity|int
    {
        return $this->announcement;
    }

    public function setAnnouncement(AnnouncementEntity|int $announcement): void
    {
        $this->announcement = $announcement;
    }
}
