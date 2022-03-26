<?php

namespace App\Request\Admin\AdminProfile;

class AdminProfileStateUpdateRequest
{
    private int $id;

    private bool $state;

    public function getId(): int
    {
        return $this->id;
    }
}
