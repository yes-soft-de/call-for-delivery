<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDefaultSystem;

use App\Constant\Order\OrderResultConstant;
use App\Entity\OrderEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialDefaultSystem\CaptainFinancialDefaultSystemOrderManager;

class CaptainFinancialDefaultSystemOrderGetService
{
    public function __construct(
        private CaptainFinancialDefaultSystemOrderManager $captainFinancialDefaultSystemOrderManager
    )
    {
    }

    /**
     * Get delivered (or cancelled under specific circumstances) orders by specific captain and among specific date
     */
    public function getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->captainFinancialDefaultSystemOrderManager->getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainProfileId,
            $fromDate, $toDate);
    }

    public function getOrderEntityById(int $orderId): OrderEntity|string
    {
        $order = $this->captainFinancialDefaultSystemOrderManager->getOrderEntityById($orderId);

        if (! $order) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        return $order;
    }
}
