<?php

namespace App\Request\Admin\Order;

use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;

class OrderCreateByAdminRequest
{
    private string $payment;

    /**
     * @var float|null
     */
    private $orderCost;

    /**
     * @var string|null
     */
    private $note;

    /**
     * @var string|null
     */
    private $deliveryDate;

    /**
     * The id of the store owner profile
     * @var StoreOwnerProfileEntity|int
     */
    private $storeOwner;

    private array $destination;

    /**
     * @var string|null
     */
    private $recipientName;

    /**
     * @var string|null
     */
    private $images;

    /**
     * @var string|null
     */
    private $recipientPhone;

    /**
     * @var string|null
     */
    private $detail;

    /**
     * @var StoreOwnerBranchEntity|int
     */
    private $branch;

    /**
     * @var bool|null
     */
    private $orderIsMain;
     
    private string|null $filePdf;

    private float|null $storeBranchToClientDistance;

    private int $isHide;

    public function getStoreOwner(): int|StoreOwnerProfileEntity
    {
        return $this->storeOwner;
    }

    public function setStoreOwner(int|StoreOwnerProfileEntity $storeOwner): void
    {
        $this->storeOwner = $storeOwner;
    }

    public function getBranch(): StoreOwnerBranchEntity|int
    {
        return $this->branch;
    }

    public function setBranch(StoreOwnerBranchEntity|int $branch): void
    {
        $this->branch = $branch;
    }

    public function getImages(): ?string
    {
        return $this->images;
    }

    public function getDeliveryDate(): ?string
    {
        return $this->deliveryDate;
    }

    public function setDeliveryDate(?string $deliveryDate): void
    {
        $this->deliveryDate = $deliveryDate;
    }

    /**
     * Get the value of isHide
     */ 
    public function getIsHide()
    {
        return $this->isHide;
    }

    /**
     * Set the value of isHide
     *
     * @return  self
     */ 
    public function setIsHide($isHide)
    {
        $this->isHide = $isHide;

        return $this;
    }
}
