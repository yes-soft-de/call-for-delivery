<?php

namespace App\Service\Admin\StoreOwnerDuesFromCashOrders;

use App\Constant\Order\OrderAmountCashConstant;
use App\Entity\StoreOwnerDuesFromCashOrdersEntity;
use App\Manager\Admin\StoreOwnerDuesFromCashOrders\AdminStoreOwnerDuesFromCashOrdersManager;

class AdminStoreOwnerDueFromCashOrderGetService
{
    public function __construct(
        private AdminStoreOwnerDuesFromCashOrdersManager $adminStoreOwnerDuesFromCashOrdersManager
    )
    {
    }

    public function getUnPaidStoreOwnerDueFromCashOrderByOrderId(int $orderId): int|StoreOwnerDuesFromCashOrdersEntity
    {
        $storeOwnerDue = $this->adminStoreOwnerDuesFromCashOrdersManager->getUnPaidStoreOwnerDueFromCashOrderByOrderId($orderId);

        if (! $storeOwnerDue) {
            return OrderAmountCashConstant::STORE_DUES_FROM_CASH_ORDER_NOT_EXIST_CONST;
        }

        return $storeOwnerDue;
    }
}
