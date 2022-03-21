<?php

namespace App\Manager\Admin\Order;

use App\Repository\OrderEntityRepository;
use App\Request\Admin\Order\OrderFilterByAdminRequest;

class AdminOrderManager
{
    private OrderEntityRepository $orderEntityRepository;

    public function __construct(OrderEntityRepository $orderEntityRepository)
    {
        $this->orderEntityRepository = $orderEntityRepository;
    }

    public function getOrdersByStateForAdmin(string $state): int
    {
        return $this->orderEntityRepository->count(["state" => $state]);
    }

    public function getAllOrdersCountForAdmin(): int
    {
        return count($this->orderEntityRepository->findAll());
    }

    public function filterStoreOrdersByAdmin(OrderFilterByAdminRequest $request): ?array
    {
        return $this->orderEntityRepository->filterStoreOrdersByAdmin($request);
    }
}
