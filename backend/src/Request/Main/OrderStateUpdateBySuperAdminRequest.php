<?php

namespace App\Request\Main;

class OrderStateUpdateBySuperAdminRequest
{
    private int $id;

    private string $state;

    public function getId(): int
    {
        return $this->id;
    }
}
