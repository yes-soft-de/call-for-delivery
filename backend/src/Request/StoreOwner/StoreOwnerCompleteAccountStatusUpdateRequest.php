<?php

namespace App\Request\StoreOwner;

class StoreOwnerCompleteAccountStatusUpdateRequest
{
    private $storeOwnerId;

    private $completeAccountStatus;

    /**
     * @return string|null
     */
    public function getStoreOwnerId(): ?string
    {
        return $this->storeOwnerId;
    }

    public function setStoreOwnerId($storeOwnerId)
    {
        $this->storeOwnerId = $storeOwnerId;
    }

    /**
     * @return string|null
     */
    public function getCompleteAccountStatus(): ?string
    {
        return $this->completeAccountStatus;
    }

    public function setCompleteAccountStatus($completeAccountStatus)
    {
        $this->completeAccountStatus = $completeAccountStatus;
    }
}
