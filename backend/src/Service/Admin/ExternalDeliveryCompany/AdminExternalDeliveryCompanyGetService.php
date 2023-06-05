<?php

namespace App\Service\Admin\ExternalDeliveryCompany;

use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Entity\ExternalDeliveryCompanyEntity;
use App\Manager\Admin\ExternalDeliveryCompany\AdminExternalDeliveryCompanyManager;

class AdminExternalDeliveryCompanyGetService
{
    public function __construct(
        private AdminExternalDeliveryCompanyManager $adminExternalDeliveryCompanyManager
    )
    {
    }

    public function getExternalDeliveryCompanyEntityById(int $id): int|ExternalDeliveryCompanyEntity
    {
        $externalDeliveryCompanyEntity = $this->adminExternalDeliveryCompanyManager->getExternalDeliveryCompanyEntityById($id);

        if (! $externalDeliveryCompanyEntity) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST;
        }

        return $externalDeliveryCompanyEntity;
    }
}
