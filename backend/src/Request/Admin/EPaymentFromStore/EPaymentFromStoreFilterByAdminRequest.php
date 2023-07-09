<?php

namespace App\Request\Admin\EPaymentFromStore;

class EPaymentFromStoreFilterByAdminRequest
{
    /**
     * @var int|null
     */
    private $storeOwnerProfileId;

    /**
     * @var string|null
     */
    private $fromDate;

    /**
     * @var string|null
     */
    private $toDate;

    /**
     * @var string|null
     */
    private $customizedTimezone;

    public function getStoreOwnerProfileId(): ?int
    {
        return $this->storeOwnerProfileId;
    }

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    public function getCustomizedTimezone(): ?string
    {
        return $this->customizedTimezone;
    }
}
