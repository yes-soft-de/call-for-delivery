<?php

namespace App\Request\ExternallyDeliveredOrder;

use App\Entity\ExternalDeliveryCompanyEntity;
use App\Entity\OrderEntity;

class ExternallyDeliveredOrderCreateRequest
{
    private OrderEntity $orderId;

    private int $externalOrderId;

    private ExternalDeliveryCompanyEntity $externalDeliveryCompany;

    // The status of the order at the external company
    private string $status;

    public function setOrderId(OrderEntity $orderId): void
    {
        $this->orderId = $orderId;
    }

    public function setExternalOrderId(int $externalOrderId): void
    {
        $this->externalOrderId = $externalOrderId;
    }

    public function setExternalDeliveryCompany(ExternalDeliveryCompanyEntity $externalDeliveryCompany): void
    {
        $this->externalDeliveryCompany = $externalDeliveryCompany;
    }

    public function setStatus(string $status): void
    {
        $this->status = $status;
    }
}
