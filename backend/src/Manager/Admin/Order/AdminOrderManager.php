<?php

namespace App\Manager\Admin\Order;

use App\Repository\OrderEntityRepository;

class AdminOrderManager
{
    private OrderEntityRepository $orderEntityRepository;

    public function __construct(OrderEntityRepository $orderEntityRepository)
    {
        $this->orderEntityRepository = $orderEntityRepository;
    }

    public function getOrdersByStateForAdmin(string $state): string
    {
        return $this->orderEntityRepository->getOrdersByStateForAdmin($state);
    }

    public function getAllOrdersCountForAdmin(): string
    {
        return $this->orderEntityRepository->getAllOrdersCountForAdmin();
    }
}