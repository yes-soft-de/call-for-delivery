<?php

namespace App\Request\Admin\AdminProfile;

class AdminProfileStatusUpdateRequest
{
    private int $id;

    private bool $status;

    public function getId(): int
    {
        return $this->id;
    }
}
