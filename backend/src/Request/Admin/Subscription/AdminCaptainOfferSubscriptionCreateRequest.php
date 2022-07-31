<?php

namespace App\Request\Admin\Subscription;

use App\Entity\CaptainOfferEntity;
use App\Entity\StoreOwnerProfileEntity;

class AdminCaptainOfferSubscriptionCreateRequest
{
    /**
     * @var int|CaptainOfferEntity
     */
    private $captainOffer;

    /**
     * @var int|StoreOwnerProfileEntity
     */
    private $storeOwner;

    public function getCaptainOffer(): CaptainOfferEntity|int
    {
        return $this->captainOffer;
    }

    public function setCaptainOffer(CaptainOfferEntity|int $captainOffer): void
    {
        $this->captainOffer = $captainOffer;
    }

    public function getStoreOwner(): int|StoreOwnerProfileEntity
    {
        return $this->storeOwner;
    }

    public function setStoreOwner(int|StoreOwnerProfileEntity $storeOwner): void
    {
        $this->storeOwner = $storeOwner;
    }
}
