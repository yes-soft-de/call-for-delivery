<?php

namespace App\Request\EPayment;

class EPaymentCreateByStoreOwnerRequest
{
    private int $status;

    private int $storeOwner;

    public function getStatus(): int
    {
        return $this->status;
    }

    /**
     * @return int
     */
    public function getStoreOwner(): int
    {
        return $this->storeOwner;
    }

    /**
     * @param int $storeOwner
     */
    public function setStoreOwner(int $storeOwner): void
    {
        $this->storeOwner = $storeOwner;
    }
}
