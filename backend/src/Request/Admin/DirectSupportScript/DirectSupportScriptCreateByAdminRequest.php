<?php

namespace App\Request\Admin\DirectSupportScript;

use App\Entity\AdminProfileEntity;

class DirectSupportScriptCreateByAdminRequest
{
    private int $action;

    private string $message;

    private int $appType;

    /**
     * @var int|AdminProfileEntity
     */
    private $adminProfile;

    public function getAdminProfile(): AdminProfileEntity|int
    {
        return $this->adminProfile;
    }

    public function setAdminProfile(AdminProfileEntity|int $adminProfile): void
    {
        $this->adminProfile = $adminProfile;
    }
}
