<?php

namespace App\Service\Admin\ExternallyDeliveredOrder;

use App\Manager\Admin\ExternallyDeliveredOrder\AdminExternallyDeliveredOrderManager;

class AdminExternallyDeliveredOrderGetService
{
    public function __construct(
        private AdminExternallyDeliveredOrderManager $adminExternallyDeliveredOrderManager
    )
    {
    }

    public function getExternallyDeliveredOrdersByExternalDeliveryCompanyId(int $externallyDeliveryCompanyId): array
    {
        return $this->adminExternallyDeliveredOrderManager->getExternallyDeliveredOrdersByExternalDeliveryCompanyId($externallyDeliveryCompanyId);
    }
}
