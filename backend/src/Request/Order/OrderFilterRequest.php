<?php

namespace App\Request\Order;

class OrderFilterRequest
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
     * @var bool|null
     */
    private $openToPriceOffer;

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
     * @return bool|null
     */
    public function getOpenToPriceOffer(): ?bool
    {
        return $this->openToPriceOffer;
    }
}
