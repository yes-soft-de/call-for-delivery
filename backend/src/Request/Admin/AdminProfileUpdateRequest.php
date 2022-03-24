<?php

namespace App\Request\Admin;

class AdminProfileUpdateRequest
{
    private int $adminUserId;

    private string $name;

    /**
     * @var string|null
     */
    private $phone;

    /**
     * @var string|null
     */
    private $image;

    /**
     * @return int
     */
    public function getAdminUserId(): int
    {
        return $this->adminUserId;
    }

    /**
     * @param int $adminUserId
     */
    public function setAdminUserId(int $adminUserId): void
    {
        $this->adminUserId = $adminUserId;
    }

    /**
     * @return string|null
     */
    public function getImage(): ?string
    {
        return $this->image;
    }
}
