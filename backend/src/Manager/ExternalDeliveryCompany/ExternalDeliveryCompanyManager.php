<?php

namespace App\Manager\ExternalDeliveryCompany;

use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyStatusConstant;
use App\Entity\ExternalDeliveryCompanyEntity;
use App\Repository\ExternalDeliveryCompanyEntityRepository;

class ExternalDeliveryCompanyManager
{
    public function __construct(
        private ExternalDeliveryCompanyEntityRepository $externalDeliveryCompanyEntityRepository
    )
    {
    }

    /**
     * Get single available external delivery company, if exist
     */
    public function getSingleAvailableExternalDeliveryCompany(): array
    {
        return $this->externalDeliveryCompanyEntityRepository->findBy(['status' => ExternalDeliveryCompanyStatusConstant::STATUS_TRUE_CONST],
            [], [1]);
    }

    /**
     * Get single external delivery company by id, if exist
     */
    public function getExternalDeliveryCompanyById(int $externalCompanyId): ?ExternalDeliveryCompanyEntity
    {
        return $this->externalDeliveryCompanyEntityRepository->findOneBy(['id' => $externalCompanyId]);
    }

    public function getAllActiveExternalDeliveryCompanies(): array
    {
        return $this->externalDeliveryCompanyEntityRepository->findBy(['status' => ExternalDeliveryCompanyStatusConstant::STATUS_TRUE_CONST]);
    }
}
