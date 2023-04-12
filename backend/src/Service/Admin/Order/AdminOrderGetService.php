<?php

namespace App\Service\Admin\Order;

use App\Manager\Admin\Order\AdminOrderManager;
use DateTime;

class AdminOrderGetService
{
    public function __construct(
        private AdminOrderManager $adminOrderManager
    )
    {
    }

    /**
     * Get the count of delivered orders according to dates and a specific store's branch
     */
    public function getDeliveredOrdersCountBetweenTwoDatesAndByStoreBranchId(int $storeBranchId, DateTime $fromDate, DateTime $toDate): array
    {
        return $this->adminOrderManager->getDeliveredOrdersCountBetweenTwoDatesAndByStoreBranchId($storeBranchId,
            $fromDate, $toDate);
    }
}
