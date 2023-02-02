<?php

namespace App\Request\Admin\DirectSupportScript;

use App\Entity\AdminProfileEntity;

class DirectSupportScriptUpdateByAdminRequest
{
    private int $id;

    private int $action;

    private string $message;

    private int $appType;

    /**
     * @var int|AdminProfileEntity
     */
    private $adminProfile;

    public function getId(): int
    {
        return $this->id;
    }

    public function getAdminProfile(): AdminProfileEntity|int
    {
        return $this->adminProfile;
    }

    public function setAdminProfile(AdminProfileEntity|int $adminProfile): void
    {
        $this->adminProfile = $adminProfile;
    }
}
