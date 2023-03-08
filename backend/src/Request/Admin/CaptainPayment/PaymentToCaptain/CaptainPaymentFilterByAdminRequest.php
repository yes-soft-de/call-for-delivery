<?php

namespace App\Request\Admin\CaptainPayment\PaymentToCaptain;

class CaptainPaymentFilterByAdminRequest
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
     * @var int|null
     */
    private $captainProfileId;

    /**
     * @var null|string
     */
    private $customizedTimezone;

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    public function getCaptainProfileId(): ?int
    {
        return $this->captainProfileId;
    }

    public function getCustomizedTimezone(): ?string
    {
        return $this->customizedTimezone;
    }
}
