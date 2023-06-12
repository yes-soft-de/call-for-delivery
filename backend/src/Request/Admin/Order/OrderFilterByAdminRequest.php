<?php

namespace App\Request\Admin\Order;

class OrderFilterByAdminRequest
{
    /**
     * @var string|null
     */
    private $state;

    /**
     * @var string|null
     */
    private $fromDate;

    /**
     * @var string|null
     */
    private $toDate;

    /**
     * @var int|null
     */
    private $storeOwnerProfileId;

    /**
     * @var bool|null
     */
    private $openToPriceOffer;

    /**
     * 1 refers to use Kilometer, 2 refers to use storeBranchToClientDistance
     * @var int|null|string
     */
    private $chosenDistanceIndicator;

    /**
     * @var float|null|string
     */
    private $kilometer;

    /**
     * @var float|null|string
     */
    private $storeBranchToClientDistance;

    /**
     * @var null|string
     */
    private $customizedTimezone;

    /**
     * @var int|null
     */
    private $orderId;

    private bool $externalOrder = false;

    private ?int $externalCompanyId = null;

    private ?int $storeBranchId = null;

    public function getState(): ?string
    {
        return $this->state;
    }

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    public function getStoreOwnerProfileId(): ?int
    {
        return $this->storeOwnerProfileId;
    }

    public function getOpenToPriceOffer(): ?bool
    {
        return $this->openToPriceOffer;
    }

    public function getChosenDistanceIndicator(): string|null|int
    {
        return $this->chosenDistanceIndicator;
    }

    public function getKilometer(): float|null|string
    {
        return $this->kilometer;
    }

    public function getStoreBranchToClientDistance(): float|null|string
    {
        return $this->storeBranchToClientDistance;
    }

    public function getCustomizedTimezone(): ?string
    {
        return $this->customizedTimezone;
    }

    public function getOrderId(): ?int
    {
        return $this->orderId;
    }

    public function getExternalOrder(): bool
    {
        return $this->externalOrder;
    }

    public function getExternalCompanyId(): ?int
    {
        return $this->externalCompanyId;
    }

    public function getStoreBranchId(): ?int
    {
        return $this->storeBranchId;
    }
}
