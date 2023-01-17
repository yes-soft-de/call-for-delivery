<?php

namespace App\Service\Admin\StoreCashOrder;

use App\Constant\Order\OrderAmountCashConstant;
use App\Entity\StoreOwnerPaymentFromCompanyEntity;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrderDeleteByAdminRequest;
use App\Request\Admin\StoreOwnerPayment\StoreOwnerPaymentFromCompanyUpdateAmountByAdminRequest;
use App\Service\Admin\StoreOwnerDuesFromCashOrders\AdminStoreOwnerDuesFromCashOrdersService;
use App\Service\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentFromCompanyService;

class AdminStoreCashOrderService
{
    public function __construct(
        private AdminStoreOwnerDuesFromCashOrdersService $adminStoreOwnerDuesFromCashOrdersService,
        private AdminStoreOwnerPaymentFromCompanyService $adminStoreOwnerPaymentFromCompanyService
    )
    {
    }

    public function deleteStoreDuesFromCashOrderAndUpdatePaymentByStoreOwnerProfileIdAndOrderId(int $storeOwnerProfileId, int $orderId): int|StoreOwnerPaymentFromCompanyEntity
    {
        $deleteCashOrdersAmountResult = $this->deleteStoreOwnerDuesFromCashOrderByCaptainProfileIdAndOrderId($storeOwnerProfileId, $orderId);dd($deleteCashOrdersAmountResult);

        if ($deleteCashOrdersAmountResult === OrderAmountCashConstant::CAPTAIN_AMOUNT_FROM_CASH_ORDER_NOT_EXIST_CONST) {
            return OrderAmountCashConstant::CAPTAIN_AMOUNT_FROM_CASH_ORDER_NOT_EXIST_CONST;
        }

        if ($deleteCashOrdersAmountResult[1]) {
            $this->updateStorePaymentFromCompanyBySpecificAmount($deleteCashOrdersAmountResult[1], $deleteCashOrdersAmountResult[0]->getAmount(),
                OrderAmountCashConstant::AMOUNT_SUBTRACTION_TYPE_OPERATION_CONST);
        }

        return $deleteCashOrdersAmountResult;
    }

    public function deleteStoreOwnerDuesFromCashOrderByCaptainProfileIdAndOrderId(int $storeOwnerProfileId, int $orderId): array|int
    {
        $storeOwnerDuesFromCashOrderDeleteByAdminRequest = new StoreOwnerDuesFromCashOrderDeleteByAdminRequest();

        $storeOwnerDuesFromCashOrderDeleteByAdminRequest->setStoreOwnerProfileId($storeOwnerProfileId);
        $storeOwnerDuesFromCashOrderDeleteByAdminRequest->setOrderId($orderId);

        return $this->adminStoreOwnerDuesFromCashOrdersService->deleteStoreOwnerDuesFromCashOrderByAdmin($storeOwnerDuesFromCashOrderDeleteByAdminRequest);
    }

    public function updateStorePaymentFromCompanyBySpecificAmount(StoreOwnerPaymentFromCompanyEntity $storeOwnerPaymentFromCompanyEntity, float $cashAmount, int $operationType): int|StoreOwnerPaymentFromCompanyEntity
    {
        $storeOwnerPaymentFromCompanyUpdateAmountRequest = new StoreOwnerPaymentFromCompanyUpdateAmountByAdminRequest();

        $storeOwnerPaymentFromCompanyUpdateAmountRequest->setId($storeOwnerPaymentFromCompanyEntity->getId());
        $storeOwnerPaymentFromCompanyUpdateAmountRequest->setCashAmount($cashAmount);
        $storeOwnerPaymentFromCompanyUpdateAmountRequest->setOperationType($operationType);

        return $this->adminStoreOwnerPaymentFromCompanyService->updateStoreOwnerPaymentFromCompanyBySpecificAmount($storeOwnerPaymentFromCompanyUpdateAmountRequest);
    }
}
