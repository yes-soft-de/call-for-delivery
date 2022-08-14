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

    /**
     * @var int|null
     */
    private $isHide;

    /**
     * @var bool|null
     */
    private $orderIsMain;

    /**
     * @var OrderEntity|null
     */
    private $primaryOrder;

    
    private null|int $paidToProvider;
   
    private null|int $isCashPaymentConfirmedByStore;

    public function getOrderId(): int|OrderEntity
    {
        return $this->orderId;
    }

    public function setOrderId(int|OrderEntity $orderId): void
    {
        $this->orderId = $orderId;
    }

    public function setType(int $type): void
    {
        $this->type = $type;
    }

    public function setAction(int $action): void
    {
        $this->action = $action;
    }

    public function setState(int $state): void
    {
        $this->state = $state;
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

    public function setIsCaptainArrivedConfirmation(?bool $isCaptainArrivedConfirmation): void
    {
        $this->isCaptainArrivedConfirmation = $isCaptainArrivedConfirmation;
    }

    public function setStoreOwnerBranch(StoreOwnerBranchEntity|int|null $storeOwnerBranch): void
    {
        $this->storeOwnerBranch = $storeOwnerBranch;
    }

    public function setStoreOwnerProfile(int|StoreOwnerProfileEntity $storeOwnerProfile): void
    {
        $this->storeOwnerProfile = $storeOwnerProfile;
    }

    public function setCaptainProfile(CaptainEntity|int|null $captainProfile): void
    {
        $this->captainProfile = $captainProfile;
    }

    public function setSupplierProfile(SupplierProfileEntity|int|null $supplierProfile): void
    {
        $this->supplierProfile = $supplierProfile;
    }

    public function setIsHide(?int $isHide): void
    {
        $this->isHide = $isHide;
    }

    public function setOrderIsMain(?bool $orderIsMain): void
    {
        $this->orderIsMain = $orderIsMain;
    }

    public function setPrimaryOrder(OrderEntity|null $primaryOrder): void
    {
        $this->primaryOrder = $primaryOrder;
    }

    /**
     * Get the value of paidToProvider
     */ 
    public function getPaidToProvider()
    {
        return $this->paidToProvider;
    }

    /**
     * Set the value of paidToProvider
     *
     * @return  self
     */ 
    public function setPaidToProvider($paidToProvider)
    {
        $this->paidToProvider = $paidToProvider;

        return $this;
    }

    public function getIsCashPaymentConfirmedByStore(): ?int
    {
        return $this->isCashPaymentConfirmedByStore;
    }

    public function setIsCashPaymentConfirmedByStore(?int $isCashPaymentConfirmedByStore)
    {
        $this->isCashPaymentConfirmedByStore = $isCashPaymentConfirmedByStore;

        return $this;
    }
}
