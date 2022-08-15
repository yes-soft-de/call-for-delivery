<?php

namespace App\Message\OrderLog;

class OrderLogCreateMessage
{
    private int $orderId;

    private int $action;

    private int $createdBy;

    private int $createdByUserType;

    /**
     * @var int|null
     */
    private $storeOwnerBranch;

    /**
     * @var int|null
     */
    private $storeOwnerProfile;

    /**
     * @var int|null
     */
    private $supplierProfile;

    public function __construct(int $orderId, int $action, int $createdBy, int $createdByUserType, ?int $storeOwnerBranch,
                                ?int $storeOwnerProfile, ?int $supplierProfile)
    {
        $this->orderId = $orderId;
        $this->action = $action;
        $this->createdBy = $createdBy;
        $this->createdByUserType = $createdByUserType;
        $this->storeOwnerBranch = $storeOwnerBranch;
        $this->storeOwnerProfile = $storeOwnerProfile;
        $this->supplierProfile = $supplierProfile;
    }

    public function getOrderId(): int
    {
        return $this->orderId;
    }

    public function getAction(): int
    {
        return $this->action;
    }

    public function getCreatedBy(): int
    {
        return $this->createdBy;
    }

    public function getCreatedByUserType(): int
    {
        return $this->createdByUserType;
    }

    public function getStoreOwnerBranch(): ?int
    {
        return $this->storeOwnerBranch;
    }

    public function getStoreOwnerProfile(): ?int
    {
        return $this->storeOwnerProfile;
    }

    public function getSupplierProfile(): ?int
    {
        return $this->supplierProfile;
    }
}
