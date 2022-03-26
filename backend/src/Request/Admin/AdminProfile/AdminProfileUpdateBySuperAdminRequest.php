<?php

namespace App\Request\Admin\AdminProfile;

use App\Entity\ImageEntity;

class AdminProfileUpdateBySuperAdminRequest
{
    private int $id;

    private string $name;

    /**
     * @var string|null
     */
    private $phone;

    /**
     * @var string|null
     */
    private $imagePath;

    /**
     * @var ImageEntity|null
     */
    private $image;

    public function getId(): int
    {
        return $this->id;
    }

    public function setName(string $name): void
    {
        $this->name = $name;
    }

    public function setPhone(?string $phone): void
    {
        $this->phone = $phone;
    }

    public function getImagePath(): ?string
    {
        return $this->imagePath;
    }

    public function setImage(?ImageEntity $image): void
    {
        $this->image = $image;
    }
}
