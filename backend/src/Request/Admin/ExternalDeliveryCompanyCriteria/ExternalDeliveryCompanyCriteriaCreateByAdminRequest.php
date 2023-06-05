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

    private ?float $fromDistance;

    private ?float $toDistance;

    private int $payment = ExternalDeliveryCompanyCriteriaPaymentConstant::PAYMENT_OFF_CONST;

    private bool $isFromAllStores = ExternalDeliveryCompanyCriteriaIsFromAllStoresConstant::IS_FROM_ALL_STORES_FALSE_CONST;

    private ?array $fromStoresBranches;

    private ExternalDeliveryCompanyEntity|int $externalDeliveryCompany;

    private string $criteriaName;

    private bool $status = ExternalDeliveryCompanyCriteriaStatusConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_STATUS_FALSE_CONST;

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
}
