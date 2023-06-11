<?php

namespace App\Request\Admin\ExternallyDeliveredOrder;

class ExternallyDeliveredOrderCreateByAdminRequest
{
    private int $orderId;

    private int $externalCompanyId;

    public function getOrderId(): int
    {
        return $this->orderId;
    }

    public function getExternalCompanyId(): int
    {
        return $this->externalCompanyId;
    }
}
