<?php

namespace App\Request\Announcement;

class AnnouncementFilterBySupplierRequest
{
    /**
     * @var string|null
     */
    private $fromDate;

    /**
     * @var string|null
     */
    private $toDate;

    private int $supplierId;

    /**
     * @var string|null
     */
    private $status;

    /**
     * @var string|null
     */
    private $administrationStatus;

    public function getFromDate(): ?string
    {
        return $this->fromDate;
    }

    public function getToDate(): ?string
    {
        return $this->toDate;
    }

    public function getSupplierId(): ?int
    {
        return $this->supplierId;
    }

    public function setSupplierId(int $supplierId): void
    {
        $this->supplierId = $supplierId;
    }

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function getAdministrationStatus(): ?string
    {
        return $this->administrationStatus;
    }
}
