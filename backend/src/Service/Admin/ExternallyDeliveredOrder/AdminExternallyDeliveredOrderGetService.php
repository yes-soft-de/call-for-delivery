<?php

namespace App\Service\Admin\ExternallyDeliveredOrder;

use App\Constant\ExternalDeliveryCompany\StreetLine\StreetLineCompanyConstant;
use App\Constant\ExternallyDeliveredOrder\ExternallyDeliveredOrderConstant;
use App\Entity\ExternallyDeliveredOrderEntity;
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

    public function getLastExternallyDeliveredOrderByOrderIdAndExternalDeliveryCompanyId(int $orderId, int $externalDeliveryCompanyId): int|ExternallyDeliveredOrderEntity
    {
        $externalOrderArray = $this->adminExternallyDeliveredOrderManager->getLastExternallyDeliveredOrderByOrderIdAndExternalDeliveryCompanyId($orderId,
            $externalDeliveryCompanyId);

        if (count($externalOrderArray) == 0) {
            return ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST;
        }

        return $externalOrderArray[0];
    }

    public function getPendingExternalOrderByOrderIdAndExternalDeliveryCompanyId(int $orderId, int $externalDeliveryCompanyId): ExternallyDeliveredOrderEntity|int
    {
        $externalOrder = $this->getLastExternallyDeliveredOrderByOrderIdAndExternalDeliveryCompanyId($orderId,
            $externalDeliveryCompanyId);

        if ($externalOrder === ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST) {
            return ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST;
        }

        if (($externalOrder->getStatus() === StreetLineCompanyConstant::ORDER_CREATED_STATUS_CONST)
            || ($externalOrder->getStatus() === StreetLineCompanyConstant::PENDING_DRIVER_ACCEPTANCE_STATUS_CONST)
            || ($externalOrder->getStatus() === StreetLineCompanyConstant::DRIVER_ACCEPTANCE_TIMEOUT_STATUS_CONST)
            || ($externalOrder->getStatus() === StreetLineCompanyConstant::DRIVER_REJECTED_ORDER_STATUS_CONST)
            || ($externalOrder->getStatus() === StreetLineCompanyConstant::ORDER_UNASSIGNED_STATUS_CONST)) {
            return $externalOrder;
        }

        return ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST;
    }
}
