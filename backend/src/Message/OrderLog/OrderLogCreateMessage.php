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

    /**
     * @var array
     */
    private $details;

    public static function create(int $orderId, int $action, int $createdBy, int $createdByUserType, ?int $storeOwnerBranch,
                                  array $details, ?int $storeOwnerProfile, ?int $supplierProfile): self
    {
        $orderLogCreateMessage = new OrderLogCreateMessage();

        $orderLogCreateMessage->orderId = $orderId;
        $orderLogCreateMessage->action = $action;
        $orderLogCreateMessage->createdBy = $createdBy;
        $orderLogCreateMessage->createdByUserType = $createdByUserType;
        $orderLogCreateMessage->storeOwnerBranch = $storeOwnerBranch;
        $orderLogCreateMessage->storeOwnerProfile = $storeOwnerProfile;
        $orderLogCreateMessage->supplierProfile = $supplierProfile;
        $orderLogCreateMessage->details = $details;

        return $orderLogCreateMessage;
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

    public function getDetails(): array
    {
        return $this->details;
    }
}
