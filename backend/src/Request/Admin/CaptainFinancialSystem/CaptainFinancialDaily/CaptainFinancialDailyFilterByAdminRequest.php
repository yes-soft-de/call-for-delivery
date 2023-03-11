<?php

namespace App\Request\Admin\CaptainFinancialSystem\CaptainFinancialDaily;

class CaptainFinancialDailyFilterByAdminRequest
{
    /**
     * @var int|null
     */
    private $captainProfileId;

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

    public function getCaptainProfileId(): ?int
    {
        return $this->captainProfileId;
    }

    /**
     * @param int|null $captainProfileId
     */
    public function setCaptainProfileId(?int $captainProfileId): void
    {
        $this->captainProfileId = $captainProfileId;
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
