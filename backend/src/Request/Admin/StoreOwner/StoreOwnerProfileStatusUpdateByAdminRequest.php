<?php

namespace App\Request\Admin\StoreOwner;

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