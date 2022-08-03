<?php

namespace App\Request\Admin\StoreOwner;

class DeleteStoreOwnerAccountAndProfileByAdminRequest
{
    // id of user record
    private int $storeOwnerId;

    public function getStoreOwnerId(): int
    {
        return $this->storeOwnerId;
    }
}
