<?php

namespace App\Service\Admin\CaptainCashOrder;

use App\Constant\Order\OrderAmountCashConstant;
use App\Entity\CaptainPaymentToCompanyEntity;
use App\Request\Admin\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashDeleteByAdminRequest;
use App\Request\Admin\CaptainPayment\CaptainPaymentToCompany\CaptainPaymentToCompanyUpdateAmountByAdminRequest;
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
    public function deleteCaptainAmountFromCashOrderAndUpdatePaymentByCaptainProfileIdAndOrderId(int $captainProfileId, int $orderId): array|int
    {
        $deleteCashOrdersAmountResult = $this->deleteCaptainAmountFromCashOrderByCaptainProfileIdAndOrderId($captainProfileId, $orderId);

        if ($deleteCashOrdersAmountResult === OrderAmountCashConstant::CAPTAIN_AMOUNT_FROM_CASH_ORDER_NOT_EXIST_CONST) {
            return OrderAmountCashConstant::CAPTAIN_AMOUNT_FROM_CASH_ORDER_NOT_EXIST_CONST;
        }

        if ($deleteCashOrdersAmountResult[1]) {
            $this->updateCaptainPaymentToCompanyBySpecificAmount($deleteCashOrdersAmountResult[1], $deleteCashOrdersAmountResult[0]->getAmount(),
                OrderAmountCashConstant::AMOUNT_SUBTRACTION_TYPE_OPERATION_CONST);
        }

        return $deleteCashOrdersAmountResult;
    }

    // Delete captain amount from cash orders
    public function deleteCaptainAmountFromCashOrderByCaptainProfileIdAndOrderId(int $captainProfileId, int $orderId): array|int
    {
        $captainAmountFromCashOrderDeleteRequest = new CaptainAmountFromOrderCashDeleteByAdminRequest();

        $captainAmountFromCashOrderDeleteRequest->setCaptainProfileId($captainProfileId);
        $captainAmountFromCashOrderDeleteRequest->setOrderId($orderId);

        return $this->adminCaptainAmountFromOrderCashService->deleteCaptainAmountFromCashOrderByCaptainProfileIdAndOrderId($captainAmountFromCashOrderDeleteRequest);
    }

    public function updateCaptainPaymentToCompanyBySpecificAmount(CaptainPaymentToCompanyEntity $captainPaymentToCompanyEntity, float $cashAmount, int $operationType): CaptainPaymentToCompanyEntity|int
    {
        $captainPaymentToCompanyUpdateAmountByAdminRequest = new CaptainPaymentToCompanyUpdateAmountByAdminRequest();

        $captainPaymentToCompanyUpdateAmountByAdminRequest->setId($captainPaymentToCompanyEntity->getId());
        $captainPaymentToCompanyUpdateAmountByAdminRequest->setOperationType($operationType);
        $captainPaymentToCompanyUpdateAmountByAdminRequest->setAmount($cashAmount);

        return $this->adminCaptainPaymentToCompanyService->updateCaptainPaymentToCompanyBySpecificAmount($captainPaymentToCompanyUpdateAmountByAdminRequest);
    }
}
