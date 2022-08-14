<?php

namespace App\Message\OrderLog;

class OrderLogCreateMessage
{
    private int $orderId;

    private int $type;

    private int $action;

    private $state;

    private int $createdBy;

    private int $createdByUserType;

    /**
     * @var int|null
     */
    private $isCaptainArrivedConfirmation;

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
    private $captainProfile;

    /**
     * @var int|null
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
     * @var int|null
     */
    private $primaryOrder;

    /**
     * @var int|null
     */
    private $paidToProvider;

    /**
     * @var int|null
     */
    private $isCaptainPaidToProvider;

    public function __construct(int $orderId, int $type, int $action, $state, int $createdBy, int $createdByUserType,
                                ?int $isCaptainArrivedConfirmation, ?int $storeOwnerBranch, ?int $storeOwnerProfile,
                                ?int $captainProfile, ?int $supplierProfile, ?int $isHide, ?bool $orderIsMain, ?int $primaryOrder,
                                ?int $paidToProvider, ?int $isCaptainPaidToProvider)
    {
        $this->orderId = $orderId;
        $this->type = $type;
        $this->action = $action;
        $this->state = $state;
        $this->createdBy = $createdBy;
        $this->createdByUserType = $createdByUserType;
        $this->isCaptainArrivedConfirmation = $isCaptainArrivedConfirmation;
        $this->storeOwnerBranch = $storeOwnerBranch;
        $this->storeOwnerProfile = $storeOwnerProfile;
        $this->captainProfile = $captainProfile;
        $this->supplierProfile = $supplierProfile;
        $this->isHide = $isHide;
        $this->orderIsMain = $orderIsMain;
        $this->primaryOrder = $primaryOrder;
        $this->paidToProvider = $paidToProvider;
        $this->isCaptainPaidToProvider = $isCaptainPaidToProvider;
    }

    /**
     * @return int
     */
    public function getOrderId(): int
    {
        return $this->orderId;
    }

    /**
     * @return int
     */
    public function getType(): int
    {
        return $this->type;
    }

    /**
     * @return int
     */
    public function getAction(): int
    {
        return $this->action;
    }

    /**
     * @return mixed
     */
    public function getState()
    {
        return $this->state;
    }

    /**
     * @return int
     */
    public function getCreatedBy(): int
    {
        return $this->createdBy;
    }

    /**
     * @return int
     */
    public function getCreatedByUserType(): int
    {
        return $this->createdByUserType;
    }

    /**
     * @return int|null
     */
    public function getIsCaptainArrivedConfirmation(): ?int
    {
        return $this->isCaptainArrivedConfirmation;
    }

    /**
     * @return int|null
     */
    public function getStoreOwnerBranch(): ?int
    {
        return $this->storeOwnerBranch;
    }

    /**
     * @return int|null
     */
    public function getStoreOwnerProfile(): ?int
    {
        return $this->storeOwnerProfile;
    }

    /**
     * @return int|null
     */
    public function getCaptainProfile(): ?int
    {
        return $this->captainProfile;
    }

    /**
     * @return int|null
     */
    public function getSupplierProfile(): ?int
    {
        return $this->supplierProfile;
    }

    /**
     * @return int|null
     */
    public function getIsHide(): ?int
    {
        return $this->isHide;
    }

    /**
     * @return bool|null
     */
    public function getOrderIsMain(): ?bool
    {
        return $this->orderIsMain;
    }

    /**
     * @return int|null
     */
    public function getPrimaryOrder(): ?int
    {
        return $this->primaryOrder;
    }

    /**
     * @return int|null
     */
    public function getPaidToProvider(): ?int
    {
        return $this->paidToProvider;
    }

    /**
     * @return int|null
     */
    public function getIsCaptainPaidToProvider(): ?int
    {
        return $this->isCaptainPaidToProvider;
    }

//    public function handleCreateOrderMessage()
//    {
//        dd(2);
//    }
}
