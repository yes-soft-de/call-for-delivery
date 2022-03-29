<?php

namespace App\Request\Admin\Captain;

class CaptainProfileStatusUpdateByAdminRequest
{
    private int $id;

    private string $status;

    public function getId(): int
    {
        return $this->id;
    }
}
