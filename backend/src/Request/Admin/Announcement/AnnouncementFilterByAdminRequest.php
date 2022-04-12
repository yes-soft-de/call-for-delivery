<?php

namespace App\Request\Admin\Announcement;

class AnnouncementFilterByAdminRequest
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
    private $supplierProfileId;

    /**
     * @var int|null
     */
    private $supplierCategoryId;

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

    public function getSupplierProfileId(): ?int
    {
        return $this->supplierProfileId;
    }

    public function getSupplierCategoryId(): ?int
    {
        return $this->supplierCategoryId;
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
