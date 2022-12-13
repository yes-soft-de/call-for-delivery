<?php

namespace App\Request\Admin\Order;

use App\Entity\StoreOwnerBranchEntity;

class OrderRecycleOrCancelByAdminRequest
{
    private int $id;

    /**
     * @var string|null
     */
    private $payment;

    /**
     * @var float|null
     */
    private $orderCost;

    /**
     * @var string|null
     */
    private $note;

    private string $deliveryDate;

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

    private StoreOwnerBranchEntity|int $branch;

    /**
     * @var int|null
     */
    private $cancel;

    /**
     * @var string|null
     */
    private $filePdf;

    /**
     * @var float|null
     */
    private $storeBranchToClientDistance;

    /**
     * @var int|null
     */
    private $isHide;

    /**
     * Auto-calculated value depending on the distance which is being calculated by Google MAP API
     * @var float|null
     */
    private $deliveryCost;

    public function getId(): int
    {
        return $this->id;
    }

    public function setId(int $id)
    {
        $this->id = $id;
    }

    public function getPayment(): ?string
    {
        return $this->payment;
    }

    public function setPayment(?string $payment)
    {
        $this->payment = $payment;
    }

    public function getOrderCost(): ?float
    {
        return $this->orderCost;
    }

    public function setOrderCost(?float $orderCost)
    {
        $this->orderCost = $orderCost;
    }

    public function getNote(): ?string
    {
        return $this->note;
    }

    public function setNote(?string $note)
    {
        $this->note = $note;
    }

    public function getDeliveryDate(): string
    {
        return $this->deliveryDate;
    }

    public function setDeliveryDate(string $deliveryDate)
    {
        $this->deliveryDate = $deliveryDate;
    }

    public function getDestination(): array
    {
        return $this->destination;
    }

    public function setDestination(array $destination)
    {
        $this->destination = $destination;
    }

    public function getRecipientName(): ?string
    {
        return $this->recipientName;
    }

    public function setRecipientName(?string $recipientName)
    {
        $this->recipientName = $recipientName;
    }

    public function getImages(): ?string
    {
        return $this->images;
    }

    public function setImages(?string $images)
    {
        $this->images = $images;
    }

    public function getRecipientPhone(): ?string
    {
        return $this->recipientPhone;
    }

    public function setRecipientPhone(?string $recipientPhone)
    {
        $this->recipientPhone = $recipientPhone;
    }

    public function getDetail(): ?string
    {
        return $this->detail;
    }

    public function setDetail(?string $detail)
    {
        $this->detail = $detail;
    }

    public function getBranch(): StoreOwnerBranchEntity|int
    {
        return $this->branch;
    }

    public function setBranch(StoreOwnerBranchEntity|int $branch)
    {
        $this->branch = $branch;
    }

    public function getCancel(): ?int
    {
        return $this->cancel;
    }

    public function setCancel(?int $cancel)
    {
        $this->cancel = $cancel;
    }

    public function getIsHide(): ?int
    {
        return $this->isHide;
    }

    public function setIsHide(?int $isHide)
    {
        $this->isHide = $isHide;
    }
}
