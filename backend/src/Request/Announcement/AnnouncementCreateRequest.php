<?php

namespace App\Request\Announcement;

use App\Entity\SupplierProfileEntity;

class AnnouncementCreateRequest
{
    private float $price;

    /**
     * @var string|null
     */
    private $details;

    private int $quantity;

    /**
     * @var int|SupplierProfileEntity
     */
    private $supplier;

    /**
     * @var array|null
     */
    private $imagesArray;

    public function getSupplier(): SupplierProfileEntity|int
    {
        return $this->supplier;
    }

    public function setSupplier(SupplierProfileEntity|int $supplier): void
    {
        $this->supplier = $supplier;
    }

    public function getImagesArray(): ?array
    {
        return $this->imagesArray;
    }

    public function setImagesArray(?array $imagesArray): void
    {
        $this->imagesArray = $imagesArray;
    }
}
