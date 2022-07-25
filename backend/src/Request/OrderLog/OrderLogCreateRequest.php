<?php

namespace App\Request\OrderLog;

use App\Entity\CaptainEntity;
use App\Entity\OrderEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SupplierProfileEntity;

class OrderLogCreateRequest
{
    /**
     * @var int|OrderEntity
     */
    private $orderId;

    private int $type;

    private int $action;

    private int $state;

    // THE ID OF THE USER RECORD
    private int $createdBy;

    private int $createdByUserType;

    /**
     * @var bool|null
     */
    private $isCaptainArrivedConfirmation;

    /**
     * @var int|StoreOwnerBranchEntity|null
     */
    private $storeOwnerBranch;

    /**
     * @var int|StoreOwnerProfileEntity
     */
    private $storeOwnerProfile;

    /**
     * @var int|CaptainEntity|null
     */
    private $captainProfile;

    /**
     * @var int|SupplierProfileEntity|null
     */
    private $supplierProfile;

    public function getOrderId(): int|OrderEntity
    {
        return $this->orderId;
    }

    public function setOrderId(int|OrderEntity $orderId): void
    {
        $this->orderId = $orderId;
    }

    public function getType(): int
    {
        return $this->type;
    }

    public function setType(int $type): void
    {
        $this->type = $type;
    }

    public function getAction(): int
    {
        return $this->action;
    }

    public function setAction(int $action): void
    {
        $this->action = $action;
    }

    public function getState(): int
    {
        return $this->state;
    }

    public function setState(int $state): void
    {
        $this->state = $state;
    }

    public function getCreatedBy(): int
    {
        return $this->createdBy;
    }

    public function setCreatedBy(int $createdBy): void
    {
        $this->createdBy = $createdBy;
    }

    public function getCreatedByUserType(): int
    {
        return $this->createdByUserType;
    }

    public function setCreatedByUserType(int $createdByUserType): void
    {
        $this->createdByUserType = $createdByUserType;
    }

    public function getIsCaptainArrivedConfirmation(): ?bool
    {
        return $this->isCaptainArrivedConfirmation;
    }

    public function setIsCaptainArrivedConfirmation(?bool $isCaptainArrivedConfirmation): void
    {
        $this->isCaptainArrivedConfirmation = $isCaptainArrivedConfirmation;
    }

    public function getStoreOwnerBranch(): StoreOwnerBranchEntity|int|null
    {
        return $this->storeOwnerBranch;
    }

    public function setStoreOwnerBranch(StoreOwnerBranchEntity|int|null $storeOwnerBranch): void
    {
        $this->storeOwnerBranch = $storeOwnerBranch;
    }

    public function getStoreOwnerProfile(): int|StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfile;
    }

    public function setStoreOwnerProfile(int|StoreOwnerProfileEntity $storeOwnerProfile): void
    {
        $this->storeOwnerProfile = $storeOwnerProfile;
    }

    public function getCaptainProfile(): CaptainEntity|int|null
    {
        return $this->captainProfile;
    }

    public function setCaptainProfile(CaptainEntity|int|null $captainProfile): void
    {
        $this->captainProfile = $captainProfile;
    }

    public function getSupplierProfile(): SupplierProfileEntity|int|null
    {
        return $this->supplierProfile;
    }

    public function setSupplierProfile(SupplierProfileEntity|int|null $supplierProfile): void
    {
        $this->supplierProfile = $supplierProfile;
    }
}
