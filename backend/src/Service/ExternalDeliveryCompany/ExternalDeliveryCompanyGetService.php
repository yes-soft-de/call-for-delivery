<?php

namespace App\Service\ExternalDeliveryCompany;

use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Entity\ExternalDeliveryCompanyEntity;
use App\Manager\ExternalDeliveryCompany\ExternalDeliveryCompanyManager;

class ExternalDeliveryCompanyGetService
{
    public function __construct(
        private ExternalDeliveryCompanyManager $externalDeliveryCompanyManager
    )
    {
    }

    /**
     * Get single available external delivery company, if exist
     */
    public function getSingleAvailableExternalDeliveryCompany(): int|ExternalDeliveryCompanyEntity
    {
        $externalDeliveryCompany = $this->externalDeliveryCompanyManager->getSingleAvailableExternalDeliveryCompany();

        if (empty($externalDeliveryCompany)) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST;
        }

        return $externalDeliveryCompany[0];
    }
}
