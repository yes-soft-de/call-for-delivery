<?php

namespace App\Request\CaptainFinancialSystem\CaptainFinancialDaily;

class CaptainFinancialDailyFilterRequest
{
    private int $captainUserId;

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
    private $isPaid;

    /**
     * @var string|null
     */
    private $customizedTimezone;

    public function getCaptainUserId(): int
    {
        return $this->captainUserId;
    }

    public function setCaptainUserId(int $captainUserId): void
    {
        $this->captainUserId = $captainUserId;
    }

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    public function getIsPaid(): ?int
    {
        return $this->isPaid;
    }

    public function getCustomizedTimezone(): ?string
    {
        return $this->customizedTimezone;
    }
}
