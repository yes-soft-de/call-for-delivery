<?php

namespace App\Service\Admin\CaptainCashOrder;

use App\Service\Admin\CaptainAmountFromOrderCash\AdminCaptainAmountFromOrderCashService;
use App\Service\Admin\CaptainPayment\AdminCaptainPaymentToCompanyService;

class AdminCaptainCashOrderService
{
    public function __construct(
        private AdminCaptainAmountFromOrderCashService $adminCaptainAmountFromOrderCashService,
        private AdminCaptainPaymentToCompanyService $adminCaptainPaymentToCompanyService
    )
    {
    }

    /**
     * Deletes all related records to a specific cash order of a captain in:
     * CaptainAmountFromOrderCashEntity
     * CaptainPaymentToCompanyEntity
     */
    public function deleteCaptainAmountFromCashOrderAndPaymentByCaptainProfileIdAndOrderId(int $captainProfileId, int $orderId)
    {

    }

    // Delete captain amount from cash orders
    public function deleteCaptainAmountFromCashOrderByCaptainProfileIdAndOrderId(int $captainProfileId, int $orderId)
    {
        $this->adminCaptainAmountFromOrderCashService->deleteCaptainAmountFromCashOrderByCaptainProfileIdAndOrderId($captainProfileId, $orderId);
    }
}
