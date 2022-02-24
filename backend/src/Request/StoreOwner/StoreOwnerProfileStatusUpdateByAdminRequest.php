<?php

namespace App\Request\StoreOwner;

class StoreOwnerProfileStatusUpdateByAdminRequest
{
    private $id;

    private $status;

    /**
     * @return int
     */
    public function getId(): int
    {
        return $this->id;
    }
}