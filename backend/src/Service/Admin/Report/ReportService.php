<?php

namespace App\Service\Admin\Report;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Order\OrderStateConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Response\Admin\Report\StatisticsForAdminGetResponse;
use App\Service\Admin\Captain\AdminCaptainService;
use App\Service\Admin\Order\AdminOrderService;
use App\Service\Admin\StoreOwner\AdminStoreOwnerService;
use App\Service\DateFactory\DateFactoryService;

class ReportService
{
    private AutoMapping $autoMapping;
    private AdminStoreOwnerService $adminStoreOwnerService;
    private AdminOrderService $adminOrderService;
    private AdminCaptainService $adminCaptainService;
    private DateFactoryService $dateFactoryService;

    public function __construct(AutoMapping $autoMapping, AdminStoreOwnerService $adminStoreOwnerService, AdminOrderService $adminOrderService, AdminCaptainService $adminCaptainService,
                                DateFactoryService $dateFactoryService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminStoreOwnerService = $adminStoreOwnerService;
        $this->adminOrderService = $adminOrderService;
        $this->adminCaptainService = $adminCaptainService;
        $this->dateFactoryService = $dateFactoryService;
    }

    public function getStatisticsForAdmin(): StatisticsForAdminGetResponse
    {
        $response = [];

        $response['activeStoresCount'] = $this->adminStoreOwnerService->getStoreOwnersProfilesCountByStatusForAdmin(StoreProfileConstant::STORE_OWNER_PROFILE_ACTIVE_STATUS);
        $response['inactiveStoresCount'] = $this->adminStoreOwnerService->getStoreOwnersProfilesCountByStatusForAdmin(StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS);

        $response['activeCaptainsCount'] = $this->adminCaptainService->getCaptainsCountByStatusForAdmin(CaptainConstant::CAPTAIN_ACTIVE);
        $response['inactiveCaptainsCount'] = $this->adminCaptainService->getCaptainsCountByStatusForAdmin(CaptainConstant::CAPTAIN_INACTIVE);

        $response['ongoingOrdersCount'] = $this->adminOrderService->getCountOrderOngoingForAdmin();
        $response['allOrdersCount'] = $this->adminOrderService->getAllOrdersCountForAdmin();
        $response['pendingOrdersCount'] = $this->adminOrderService->getPendingOrdersCountForAdmin();

        $todayStartAndEndDatesAndTime = $this->dateFactoryService->getStartAndEndDatesAndTimeOfToday();
        $response['todayDeliveredOrdersCount'] = $this->adminOrderService->getDeliveredOrdersCountBetweenTwoDatesForAdmin($todayStartAndEndDatesAndTime[0], $todayStartAndEndDatesAndTime[1]);

        $previousWeekStartAndEndDatesAndTime = $this->dateFactoryService->getStartAndEndDatesAndTimeOfPreviousWeek();
        $response['previousWeekDeliveredOrdersCount'] = $this->adminOrderService->getDeliveredOrdersCountBetweenTwoDatesForAdmin($previousWeekStartAndEndDatesAndTime[0], $previousWeekStartAndEndDatesAndTime[1]);

        return $this->autoMapping->map('array', StatisticsForAdminGetResponse::class, $response);
    }
}
