<?php

namespace App\Request\Admin;

class AdminProfileCreateRequest
{
    private int $adminUserId;

    private string $name;

    /**
     * @var string|null
     */
    private $phone;

    /**
     * @param int $adminUserId
     */
    public function setAdminUserId(int $adminUserId): void
    {
        $this->adminUserId = $adminUserId;
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
}
