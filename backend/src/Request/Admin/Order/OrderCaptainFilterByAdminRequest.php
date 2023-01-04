<?php

namespace App\Request\Admin\Order;

class OrderCaptainFilterByAdminRequest
{
    /**
     * @var string|null
     */
    private $fromDate;

    /**
     * @var string|null
     */
    private $toDate;

    /**
     * refers to the id of the captain profile
     * @var int
     */
    private $captainId;

    /**
     * @var string|null
     */
    private $payment;

    /**
     * @var string|null
     */
    private $state;

    /**
     * @var null|string
     */
    private $customizedTimezone;

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
     * Get the value of captainProfileId
     *
     * @return  int|null
     */ 
    public function getCaptainId(): ?int
    {
        return $this->captainId;
    }

    public function getPayment(): ?string
    {
        return $this->payment;
    }

    public function getState(): ?string
    {
        return $this->state;
    }

    public function getCustomizedTimezone(): ?string
    {
        return $this->customizedTimezone;
    }
}
