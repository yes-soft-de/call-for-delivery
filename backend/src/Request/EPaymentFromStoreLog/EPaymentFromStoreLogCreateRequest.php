<?php

namespace App\Request\EPaymentFromStoreLog;

use App\Entity\AdminProfileEntity;
use App\Entity\EPaymentFromStoreEntity;
use App\Entity\StoreOwnerProfileEntity;

class EPaymentFromStoreLogCreateRequest
{
    private ?EPaymentFromStoreEntity $ePaymentFromStore;

    private int $action;

    private ?string $details;

    private int $createdByUser;

    private ?StoreOwnerProfileEntity $storeOwnerProfile;

    private ?AdminProfileEntity $adminProfile;

    public function setEPaymentFromStore(?EPaymentFromStoreEntity $ePaymentFromStore): void
    {
        $this->ePaymentFromStore = $ePaymentFromStore;
    }

    public function setAction(int $action): void
    {
        $this->action = $action;
    }

    public function setDetails(?string $details): void
    {
        $this->details = $details;
    }

    public function setCreatedByUser(int $createdByUser): void
    {
        $this->createdByUser = $createdByUser;
    }

    public function setStoreOwnerProfile(?StoreOwnerProfileEntity $storeOwnerProfile): void
    {
        $this->storeOwnerProfile = $storeOwnerProfile;
    }

    public function setAdminProfile(?AdminProfileEntity $adminProfile): void
    {
        $this->adminProfile = $adminProfile;
    }
}
