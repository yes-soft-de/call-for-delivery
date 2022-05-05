<?php

namespace App\Manager\Admin\StoreOwnerDuesFromCashOrders;

use App\Repository\StoreOwnerDuesFromCashOrdersEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersFilterGetRequest;

class AdminStoreOwnerDuesFromCashOrdersManager
{
    private StoreOwnerDuesFromCashOrdersEntityRepository $storeOwnerDuesFromCashOrdersEntityRepository;
    private EntityManagerInterface $entityManager;

    public function __construct(StoreOwnerDuesFromCashOrdersEntityRepository $storeOwnerDuesFromCashOrdersEntityRepository, EntityManagerInterface $entityManager)
    {
        $this->storeOwnerDuesFromCashOrdersEntityRepository = $storeOwnerDuesFromCashOrdersEntityRepository;
        $this->entityManager = $entityManager;
    }

    public function filterStoreOwnerDuesFromCashOrders(StoreOwnerDuesFromCashOrdersFilterGetRequest $request): ?array
    {       
        return $this->storeOwnerDuesFromCashOrdersEntityRepository->filterStoreOwnerDuesFromCashOrders($request->getStoreId(), $request->getFromDate(), $request->getToDate());
    }
}
