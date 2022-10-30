<?php

namespace App\Request\Admin\Order;

use App\Entity\CaptainEntity;
use App\Entity\OrderEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\StoreOwnerProfileEntity;

class SubOrderCreateByAdminRequest
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
     * @var int|StoreOwnerProfileEntity
     */
    private $storeOwner;

    /**
     * @var array|null
     */
    private $destination;

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
     * @var int|OrderEntity
     */
    private $primaryOrder;

    /**
     * @var CaptainEntity|null
     */
    private $captainId;

    /**
     * @var string|null
     */
    private $filePdf;

    /**
     * @var float|null
     */
    private $storeBranchToClientDistance;

    /**
     * Auto-calculated value depending on the distance which is being calculated by Google MAP API
     * @var float|null
     */
    private $deliveryCost;

    public function getStoreOwner(): int|StoreOwnerProfileEntity
    {
        return $this->storeOwner;
    }

    public function setStoreOwner(int|StoreOwnerProfileEntity $storeOwner)
    {
        $this->storeOwner = $storeOwner;
    }

    public function getBranch(): StoreOwnerBranchEntity|int
    {
        return $this->branch;
    }

    public function setBranch(StoreOwnerBranchEntity|int $branch)
    {
        $this->branch = $branch;
    }

    public function getDetail(): ?string
    {
        return $this->detail;
    }

    public function setDetail(?string $detail)
    {
        $this->detail = $detail;
    }

    public function getRecipientPhone(): ?string
    {
        return $this->recipientPhone;
    }

    public function setRecipientPhone(?string $recipientPhone)
    {
        $this->recipientPhone = $recipientPhone;
    }

    public function getImages(): ?string
    {
        return $this->images;
    }

    public function setImages(?string $images)
    {
        $this->images = $images;
    }

    public function getRecipientName(): ?string
    {
        return $this->recipientName;
    }

    public function setRecipientName(?string $recipientName)
    {
        $this->recipientName = $recipientName;
    }

    public function getDestination(): ?array
    {
        return $this->destination;
    }

    public function setDestination($destination)
    {
        $this->destination = $destination;
    }

    public function getPrimaryOrder(): OrderEntity|int
    {
        return $this->primaryOrder;
    }

    public function setPrimaryOrder(OrderEntity|int $primaryOrder)
    {
        $this->primaryOrder = $primaryOrder;
    }

    public function getCaptainId(): ?CaptainEntity
    {
        return $this->captainId;
    }

    public function setCaptainId($captainId)
    {
        $this->captainId = $captainId;
    }

    public function getDeliveryDate(): ?string
    {
        return $this->deliveryDate;
    }

    public function setDeliveryDate($deliveryDate)
    {
        $this->deliveryDate = $deliveryDate;
    }
}
