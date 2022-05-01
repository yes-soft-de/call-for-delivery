<?php

namespace App\Service\Admin\StoreOwnerDuesFromCashOrders;

use App\AutoMapping;
use App\Manager\Admin\StoreOwnerDuesFromCashOrders\AdminStoreOwnerDuesFromCashOrdersManager;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersFilterGetRequest;
use App\Response\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersResponse;

class AdminStoreOwnerDuesFromCashOrdersService
{
    private AutoMapping $autoMapping;
    private AdminStoreOwnerDuesFromCashOrdersManager $adminStoreOwnerDuesFromCashOrdersManager;

    public function __construct(AutoMapping $autoMapping, AdminStoreOwnerDuesFromCashOrdersManager $adminStoreOwnerDuesFromCashOrdersManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminStoreOwnerDuesFromCashOrdersManager = $adminStoreOwnerDuesFromCashOrdersManager;
    }

    public function filterStoreOwnerDuesFromCashOrders(StoreOwnerDuesFromCashOrdersFilterGetRequest $request): array
    {
        $response = [];
        $items = $this->adminStoreOwnerDuesFromCashOrdersManager->filterStoreOwnerDuesFromCashOrders($request);

        foreach ($items as $storeOwnerDuesFromCashOrders) {

            $response[] = $this->autoMapping->map("array", StoreOwnerDuesFromCashOrdersResponse::class, $storeOwnerDuesFromCashOrders);
        }

        return $response;
    }
}
