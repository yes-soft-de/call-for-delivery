<?php

namespace App\Service\Admin\StoreCashOrder;

use App\Constant\Order\OrderAmountCashConstant;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrderDeleteByAdminRequest;
use App\Service\Admin\StoreOwnerDuesFromCashOrders\AdminStoreOwnerDuesFromCashOrdersService;

class AdminStoreCashOrderService
{
    public function __construct(
        private AdminStoreOwnerDuesFromCashOrdersService $adminStoreOwnerDuesFromCashOrdersService
    )
    {
    }

    public function deleteStoreDuesFromCashOrderAndUpdatePaymentByStoreOwnerProfileIdAndOrderId(int $storeOwnerProfileId, int $orderId): array|int
    {
        $deleteCashOrdersAmountResult = $this->deleteStoreOwnerDuesFromCashOrderByCaptainProfileIdAndOrderId($storeOwnerProfileId, $orderId);

        if ($deleteCashOrdersAmountResult === OrderAmountCashConstant::STORE_DUES_FROM_CASH_ORDER_NOT_EXIST_CONST) {
            return OrderAmountCashConstant::STORE_DUES_FROM_CASH_ORDER_NOT_EXIST_CONST;
        }

//        if ($deleteCashOrdersAmountResult[1]) {
//               if ($deleteCashOrdersAmountResult[1] > 0) {
//                   foreach ($deleteCashOrdersAmountResult[1] as $paymentId) {
//                       $this->updateStorePaymentFromCompanyBySpecificAmount($paymentId, $deleteCashOrdersAmountResult[0]->getStoreAmount(),
//                           OrderAmountCashConstant::AMOUNT_SUBTRACTION_TYPE_OPERATION_CONST);
//                   }
//               }
//        }

        return $deleteCashOrdersAmountResult;
    }

    public function deleteStoreOwnerDuesFromCashOrderByCaptainProfileIdAndOrderId(int $storeOwnerProfileId, int $orderId): array|int
    {
        $storeOwnerDuesFromCashOrderDeleteByAdminRequest = new StoreOwnerDuesFromCashOrderDeleteByAdminRequest();

        $storeOwnerDuesFromCashOrderDeleteByAdminRequest->setStoreOwnerProfileId($storeOwnerProfileId);
        $storeOwnerDuesFromCashOrderDeleteByAdminRequest->setOrderId($orderId);

        return $this->adminStoreOwnerDuesFromCashOrdersService->deleteStoreOwnerDuesFromCashOrderByAdmin($storeOwnerDuesFromCashOrderDeleteByAdminRequest);
    }

//    public function updateStorePaymentFromCompanyBySpecificAmount(StoreOwnerPaymentFromCompanyEntity $storeOwnerPaymentFromCompanyEntity, float $cashAmount, int $operationType): int|StoreOwnerPaymentFromCompanyEntity
//    {
//        $storeOwnerPaymentFromCompanyUpdateAmountRequest = new StoreOwnerPaymentFromCompanyUpdateAmountByAdminRequest();
//
//        $storeOwnerPaymentFromCompanyUpdateAmountRequest->setId($storeOwnerPaymentFromCompanyEntity->getId());
//        $storeOwnerPaymentFromCompanyUpdateAmountRequest->setCashAmount($cashAmount);
//        $storeOwnerPaymentFromCompanyUpdateAmountRequest->setOperationType($operationType);
//
//        return $this->adminStoreOwnerPaymentFromCompanyService->updateStoreOwnerPaymentFromCompanyBySpecificAmount($storeOwnerPaymentFromCompanyUpdateAmountRequest);
//    }
}
