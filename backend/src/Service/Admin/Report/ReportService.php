<?php

namespace App\Service\Admin\Report;

use App\AutoMapping;
use App\Constant\Order\OrderStateConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Response\Admin\Report\StatisticsForAdminGetResponse;
use App\Service\Admin\Order\AdminOrderService;
use App\Service\Admin\StoreOwner\AdminStoreOwnerService;

class ReportService
{
    private AutoMapping $autoMapping;
    private AdminStoreOwnerService $adminStoreOwnerService;
    private AdminOrderService $adminOrderService;

    public function __construct(AutoMapping $autoMapping, AdminStoreOwnerService $adminStoreOwnerService, AdminOrderService $adminOrderService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminStoreOwnerService = $adminStoreOwnerService;
        $this->adminOrderService = $adminOrderService;
    }

    public function getStatisticsForAdmin(): StatisticsForAdminGetResponse
    {
        $response = [];

        $response['activeStoresCount'] = $this->adminStoreOwnerService->getStoreOwnersProfilesCountByStatusForAdmin(StoreProfileConstant::STORE_OWNER_PROFILE_ACTIVE_STATUS);
        $response['inactiveStoresCount'] = $this->adminStoreOwnerService->getStoreOwnersProfilesCountByStatusForAdmin(StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS);

        $response['ongoingOrdersCount'] = $this->adminOrderService->getOrdersByStateForAdmin(OrderStateConstant::ORDER_STATE_ONGOING);
        $response['allOrdersCount'] = $this->adminOrderService->getAllOrdersCountForAdmin();

        return $this->autoMapping->map('array', StatisticsForAdminGetResponse::class, $response);
    }
}
