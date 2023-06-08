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

    /**
     * @return string|null
     */
    public function getState(): ?string
    {
        return $this->state;
    }

    /**
     * @return string|null
     */
    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    /**
     * @return string|null
     */
    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    /**
     * @return int|null
     */
    public function getStoreOwnerProfileId(): ?int
    {
        return $this->storeOwnerProfileId;
    }

    /**
     * @return bool|null
     */
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

    /**
     * @return string|null
     */
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
}
