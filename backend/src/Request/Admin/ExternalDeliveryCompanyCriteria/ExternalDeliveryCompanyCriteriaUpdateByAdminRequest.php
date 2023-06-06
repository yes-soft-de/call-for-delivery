<?php

namespace App\Request\Admin\ExternalDeliveryCompanyCriteria;

use App\Entity\AdminProfileEntity;
use DateTime;

class ExternalDeliveryCompanyCriteriaUpdateByAdminRequest
{
    private int $id;

    private bool $isSpecificDate;

    private null|string|DateTime $fromDate;

    private null|string|DateTime $toDate;

    private int $isDistance;

    private ?float $fromDistance;

    private ?float $toDistance;

    private int $payment;

    private bool $isFromAllStores;

    private ?array $fromStoresBranches;

    private string $criteriaName;

    private ?float $cashLimit;

    private int|AdminProfileEntity $updatedBy;

    public function getId(): int
    {
        return $this->id;
    }

    public function getFromDate(): null|string|DateTime
    {
        return $this->fromDate;
    }

    public function setFromDate(DateTime|string|null $fromDate): void
    {
        $this->fromDate = $fromDate;
    }

    public function getToDate(): null|string|DateTime
    {
        return $this->toDate;
    }

    public function setToDate(DateTime|string|null $toDate): void
    {
        $this->toDate = $toDate;
    }

    public function setUpdatedBy(AdminProfileEntity|int $updatedBy): void
    {
        $this->updatedBy = $updatedBy;
    }
}
