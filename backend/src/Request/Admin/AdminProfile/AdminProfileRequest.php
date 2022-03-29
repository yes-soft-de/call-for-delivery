<?php

namespace App\Request\Admin\AdminProfile;

use App\Entity\UserEntity;

class AdminProfileRequest
{
    private int $id;

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
     * @var array|null
     */
    private $images;

    public function getId(): int
    {
        return $this->id;
    }

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

    public function setName(string $name): void
    {
        $this->name = $name;
    }

    public function setPhone(?string $phone): void
    {
        $this->phone = $phone;
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
