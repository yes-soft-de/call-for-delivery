<?php

namespace App\Request\Supplier;

use App\Entity\UserEntity;

class SupplierProfileUpdateRequest
{
    private int|UserEntity $user;

    private string $supplierName;

    /**
     * @var string|null
     */
    private $phone;

    /**
     * @var string|null
     */
    private $image;

    /**
     * @return UserEntity|int
     */
    public function getUser(): UserEntity|int
    {
        return $this->user;
    }

    /**
     * @param UserEntity|int $user
     */
    public function setUser(UserEntity|int $user): void
    {
        $this->user = $user;
    }

    /**
     * @return string|null
     */
    public function getImage(): ?string
    {
        return $this->image;
    }
}
