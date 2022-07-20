<?php

namespace App\Service\Admin\Report;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Response\Admin\Report\StatisticsForAdminGetResponse;
use App\Service\Admin\Captain\AdminCaptainService;
use App\Service\Admin\Order\AdminOrderService;
use App\Service\Admin\StoreOwner\AdminStoreOwnerService;
use App\Service\DateFactory\DateFactoryService;
use DateTime;

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

        //$todayStartAndEndDatesAndTime = $this->dateFactoryService->getStartAndEndDatesAndTimeOfToday();
        $response['todayDeliveredOrdersCount'] = $this->adminOrderService->getDeliveredOrdersCountBetweenTwoDatesForAdmin(new \DateTime('-24 hour'), new \DateTime('now'));

        //$previousWeekStartAndEndDatesAndTime = $this->dateFactoryService->getStartAndEndDatesAndTimeOfPreviousWeek();
        $response['previousWeekDeliveredOrdersCount'] = $this->adminOrderService->getDeliveredOrdersCountBetweenTwoDatesForAdmin(new \DateTime('-7 day'), new \DateTime('now'),);

        return $this->autoMapping->map('array', StatisticsForAdminGetResponse::class, $response);
    }

    public function getDashboardStatisticsForAdmin(): array
    {
        $response = [];

        // orders statistics
        $response["data"]["orders"]["count"]["allOrders"] = $this->adminOrderService->getAllOrdersCountForAdmin();

        $lastSevenDaysDates = $this->dateFactoryService->getLastSevenDaysDatesAsArray();

        if (! empty($lastSevenDaysDates)) {
            foreach ($lastSevenDaysDates as $date) {
                $response["data"]["orders"]["count"]["delivered"][$date] = $this->adminOrderService->getDeliveredOrdersCountBetweenTwoDatesForAdmin(new DateTime($date), (new DateTime($date))->setTime(23, 59, 59));;
            }
        }

        $response["data"]["orders"]["count"]["pending"] = $this->adminOrderService->getPendingOrdersCountForAdmin();
        $response["data"]["orders"]["count"]["onGoing"] = $this->adminOrderService->getCountOrderOngoingForAdmin();

        // stores statistics
        $response["data"]["stores"]["count"]["active"] = $this->adminStoreOwnerService->getStoreOwnersProfilesCountByStatusForAdmin(StoreProfileConstant::STORE_OWNER_PROFILE_ACTIVE_STATUS);
        $response["data"]["stores"]["count"]["inactive"] = $this->adminStoreOwnerService->getStoreOwnersProfilesCountByStatusForAdmin(StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS);
        $response["data"]["stores"]["count"]["lastThreeActive"] = $this->adminStoreOwnerService->getLastThreeActiveStoreOwnersProfilesForAdmin();

        // captains statistics
        $response["data"]["captains"]["count"]["active"] = $this->adminCaptainService->getCaptainsCountByStatusForAdmin(CaptainConstant::CAPTAIN_ACTIVE);;
        $response["data"]["captains"]["count"]["inactive"] = $this->adminCaptainService->getCaptainsCountByStatusForAdmin(CaptainConstant::CAPTAIN_INACTIVE);;
        $response["data"]["captains"]["count"]["lastThreeActive"] = $this->adminCaptainService->getLastThreeActiveCaptainsProfilesForAdmin();

        return $response;
    }
}
