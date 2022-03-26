<?php

namespace App\Request\Admin\AdminProfile;

use App\Entity\ImageEntity;
use App\Entity\UserEntity;

class AdminProfileRequest
{
    /**
     * @var UserEntity|int
     */
    private $user;

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

    /**
     * @param UserEntity|int $user
     */
    public function setUser($user): void
    {
        $this->user = $user;
    }

    public function getUser(): UserEntity|int
    {
        return $this->user;
    }

    /**
     * @param string $name
     */
    public function setName(string $name): void
    {
        $this->name = $name;
    }

    /**
     * @param string|null $phone
     */
    public function setPhone(?string $phone): void
    {
        $this->phone = $phone;
    }

    /**
     * @return string|null
     */
    public function getImagePath(): ?string
    {
        return $this->imagePath;
    }

    /**
     * @param ImageEntity|null $image
     */
    public function setImage(?ImageEntity $image): void
    {
        $this->image = $image;
    }
}
