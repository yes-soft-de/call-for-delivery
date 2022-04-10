<?php

namespace App\Request\Announcement;

class AnnouncementUpdateRequest
{
    private int $id;

    private float $price;

    /**
     * @var string|null
     */
    private $details;

    private int $quantity;

    /**
     * @var array|null
     */
    private $images;

    public function getId(): int
    {
        return $this->id;
    }

    public function getImages(): ?array
    {
        return $this->images;
    }

    public function setImages(?array $images): void
    {
        $this->images = $images;
    }
}
