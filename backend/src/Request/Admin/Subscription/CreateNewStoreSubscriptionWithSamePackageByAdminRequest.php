<?php

namespace App\Request\Admin\Subscription;

class CreateNewStoreSubscriptionWithSamePackageByAdminRequest
{
    private int $storeProfileId;

    /**
     * @var string|null
     */
    private $note;

    public function getStoreProfileId(): int
    {
        return $this->storeProfileId;
    }

    public function setStoreProfileId(int $storeProfileId)
    {
        $this->storeProfileId = $storeProfileId;
    }

    public function getNote(): ?string
    {
        return $this->note;
    }
}
