<?php

namespace App\Request\Admin\Captain;

class DeleteCaptainAccountAndProfileByAdminRequest
{
    private int $captainId; // id of the user record

    public function getCaptainId(): int
    {
        return $this->captainId;
    }
}
