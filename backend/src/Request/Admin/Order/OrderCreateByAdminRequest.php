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

    /**
     * Auto-calculated value depending on the distance which is being calculated by Google MAP API
     * @var float|null
     */
    private $deliveryCost;

    /**
     * @var int|null
     */
    private $costType;

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

    public function setPayment(string $payment): void
    {
        $this->payment = $payment;
    }

    public function setOrderCost(?float $orderCost): void
    {
        $this->orderCost = $orderCost;
    }

    public function setNote(?string $note): void
    {
        $this->note = $note;
    }

    public function setDestination(array $destination): void
    {
        $this->destination = $destination;
    }

    public function getDestination(): array
    {
        return $this->destination;
    }

    public function setRecipientName(?string $recipientName): void
    {
        $this->recipientName = $recipientName;
    }

    public function setImages(?string $images): void
    {
        $this->images = $images;
    }

    public function setRecipientPhone(?string $recipientPhone): void
    {
        $this->recipientPhone = $recipientPhone;
    }

    public function setDetail(?string $detail): void
    {
        $this->detail = $detail;
    }

    public function setOrderIsMain(?bool $orderIsMain): void
    {
        $this->orderIsMain = $orderIsMain;
    }

    public function setFilePdf(?string $filePdf): void
    {
        $this->filePdf = $filePdf;
    }

    public function setStoreBranchToClientDistance(?float $storeBranchToClientDistance): void
    {
        $this->storeBranchToClientDistance = $storeBranchToClientDistance;
    }

    public function setDeliveryCost(?float $deliveryCost): void
    {
        $this->deliveryCost = $deliveryCost;
    }

    public function setCostType(?int $costType): void
    {
        $this->costType = $costType;
    }
}
