<?php

namespace App\Request\Admin\ExternalDeliveryCompanyCriteria;

use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaIsDistanceConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaIsFromAllStoresConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaIsSpecificDateConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaPaymentConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaStatusConstant;
use App\Entity\ExternalDeliveryCompanyEntity;
use DateTime;

class ExternalDeliveryCompanyCriteriaCreateByAdminRequest
{
    private bool $isSpecificDate = ExternalDeliveryCompanyCriteriaIsSpecificDateConstant::IS_SPECIFIC_DATE_FALSE_CONST;

    private null|string|DateTime $fromDate;

    private null|string|DateTime $toDate;

    private int $isDistance = ExternalDeliveryCompanyCriteriaIsDistanceConstant::IS_DISTANCE_OFF_CONST;

    /**
     * @var float|null
     */
    private $fromDistance;

    /**
     * @var float|null
     */
    private $toDistance;

    private int $payment = ExternalDeliveryCompanyCriteriaPaymentConstant::PAYMENT_OFF_CONST;

    private bool $isFromAllStores = ExternalDeliveryCompanyCriteriaIsFromAllStoresConstant::IS_FROM_ALL_STORES_FALSE_CONST;

    /**
     * @var array|null
     */
    private $fromStoresBranches;

    private ExternalDeliveryCompanyEntity|int $externalDeliveryCompany;

    private string $criteriaName;

    private bool $status = ExternalDeliveryCompanyCriteriaStatusConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_STATUS_FALSE_CONST;

    /**
     * @var float|null
     */
    private $cashLimit;

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

    public function getExternalDeliveryCompany(): int|ExternalDeliveryCompanyEntity
    {
        return $this->externalDeliveryCompany;
    }

    public function setExternalDeliveryCompany(int|ExternalDeliveryCompanyEntity $externalDeliveryCompany): void
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

    public function getCriteriaName(): string
    {
        return $this->criteriaName;
    }

    public function isStatus(): bool
    {
        return $this->status;
    }

    public function getCashLimit(): ?float
    {
        return $this->cashLimit;
    }
}
