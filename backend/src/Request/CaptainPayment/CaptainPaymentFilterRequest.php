<?php

namespace App\Request\CaptainPayment;

class CaptainPaymentFilterRequest
{
    private int $userId;

    /**
     * @var string|null
     */
    private $fromDate;

    /**
     * @var string|null
     */
    private $toDate;

    /**
     * @var null|string
     */
    private $customizedTimezone;

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    public function setFromDate(string|null $fromDate)
    {
        $this->fromDate = $fromDate;
    }

    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    public function setToDate(string|null $toDate): void
    {
        $this->toDate = $toDate;
    }

    public function getUserId(): int
    {
        return $this->userId;
    }

    public function setUserId(int $userId): void
    {
        $this->userId = $userId;
    }

    public function getCustomizedTimezone(): ?string
    {
        return $this->customizedTimezone;
    }
}
