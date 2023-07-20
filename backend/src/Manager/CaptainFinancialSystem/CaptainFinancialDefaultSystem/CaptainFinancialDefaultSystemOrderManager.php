<?php

namespace App\Manager\CaptainFinancialSystem\CaptainFinancialDefaultSystem;

use App\Entity\OrderEntity;
use App\Repository\OrderEntityRepository;

class CaptainFinancialDefaultSystemOrderManager
{
    public function __construct(
        private OrderEntityRepository $orderEntityRepository
    )
    {
    }

    /**
     * Get delivered (or cancelled under specific circumstances) orders by specific captain and among specific date
     */
    public function getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->orderEntityRepository->getDeliveredOrdersByCaptainProfileIdAndBetweenTwoDates($captainId, $fromDate,
            $toDate);
    }

    public function getOrderEntityById(int $orderId): ?OrderEntity
    {
        return $this->orderEntityRepository->findOneBy(['id' => $orderId]);
    }
}
