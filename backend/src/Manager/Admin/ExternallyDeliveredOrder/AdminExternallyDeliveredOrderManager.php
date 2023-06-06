<?php

namespace App\Manager\Admin\ExternallyDeliveredOrder;

use App\Repository\ExternallyDeliveredOrderEntityRepository;

class AdminExternallyDeliveredOrderManager
{
    public function __construct(
        private ExternallyDeliveredOrderEntityRepository $externallyDeliveredOrderEntityRepository
    )
    {
    }

    public function getExternallyDeliveredOrdersByExternalDeliveryCompanyId(int $externallyDeliveryCompanyId): array
    {
        return $this->externallyDeliveredOrderEntityRepository->findBy(['externalDeliveryCompany' => $externallyDeliveryCompanyId]);
    }
}
