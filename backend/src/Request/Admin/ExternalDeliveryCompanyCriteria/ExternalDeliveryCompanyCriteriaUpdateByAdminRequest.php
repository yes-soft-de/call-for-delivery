<?php

namespace App\Request\Admin\ExternalDeliveryCompanyCriteria;

use App\Entity\AdminProfileEntity;
use App\Entity\ExternalDeliveryCompanyEntity;
use DateTime;

class ExternalDeliveryCompanyCriteriaUpdateByAdminRequest
{
    private int $id;

    private bool $isSpecificDate;

    private null|string|DateTime $fromDate;

    private null|string|DateTime $toDate;

    private int $isDistance;

    /**
     * @var float|null
     */
    private $fromDistance;

    /**
     * @var float|null
     */
    private $toDistance;

    private int $payment;

    private bool $isFromAllStores;

    /**
     * @var array|null
     */
    private $fromStoresBranches;

    private string $criteriaName;

    /**
     * @var float|null
     */
    private $cashLimit;

    private int|AdminProfileEntity $updatedBy;

    /**
     * @var ExternalDeliveryCompanyEntity|null
     */
    private $externalDeliveryCompany;

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

    public function getExternalDeliveryCompany(): ?ExternalDeliveryCompanyEntity
    {
        return $this->externalDeliveryCompany;
    }

    public function setExternalDeliveryCompany(?ExternalDeliveryCompanyEntity $externalDeliveryCompany): void
    {
        $this->externalDeliveryCompany = $externalDeliveryCompany;
    }

    public function isSpecificDate(): bool
    {
        return $this->isSpecificDate;
    }

    public function getIsDistance(): int
    {
        return $this->isDistance;
    }

    public function getFromDistance(): ?float
    {
        return $this->fromDistance;
    }

    public function getToDistance(): ?float
    {
        return $this->toDistance;
    }

    public function getPayment(): int
    {
        return $this->payment;
    }

    public function isFromAllStores(): bool
    {
        return $this->isFromAllStores;
    }

    public function getFromStoresBranches(): ?array
    {
        return $this->fromStoresBranches;
    }

    public function getCashLimit(): ?float
    {
        return $this->cashLimit;
    }
}
