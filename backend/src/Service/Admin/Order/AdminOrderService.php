<?php

namespace App\Service\Admin\Order;

use App\Manager\Admin\Order\AdminOrderManager;

class AdminOrderService
{
    private AdminOrderManager $adminOrderManager;

    public function __construct(AdminOrderManager $adminStoreOwnerManager)
    {
        $this->adminOrderManager = $adminStoreOwnerManager;
    }

    public function getOrdersByStateForAdmin(string $storeOwnerProfileStatus): int
    {
        return $this->adminOrderManager->getOrdersByStateForAdmin($storeOwnerProfileStatus);
    }

    public function getAllOrdersCountForAdmin(): int
    {
        return $this->adminOrderManager->getAllOrdersCountForAdmin();
    }
}
