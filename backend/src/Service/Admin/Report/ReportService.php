<?php

namespace App\Service\Admin\Report;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Request\Admin\Report\CaptainWithDeliveredOrdersDuringSpecificTimeFilterByAdminRequest;
use App\Request\Admin\Report\StoresAndOrdersCountDuringSpecificTimeFilterByAdminRequest;
use App\Response\Admin\Report\ActiveCaptainWithOrdersCountInLastFinancialCycleGetForAdminResponse;
use App\Response\Admin\Report\CaptainsRatingsForAdminGetResponse;
use App\Response\Admin\Report\CaptainsWithDeliveredOrdersCountFilterByAdminResponse;
use App\Response\Admin\Report\StatisticsForAdminGetResponse;
use App\Response\Admin\Report\StoresWithOrdersCountDuringSpecificTimeFilterByAdminResponse;
use App\Response\Admin\Report\TopOrdersStoresForCurrentMonthByAdminGetResponse;
use App\Service\Admin\Captain\AdminCaptainService;
use App\Service\Admin\Order\AdminOrderService;
use App\Service\Admin\StoreOwner\AdminStoreOwnerService;
use App\Service\DateFactory\DateFactoryService;
use App\Service\FileUpload\UploadFileHelperService;
use DateTime;

class ReportService
{
    private AutoMapping $autoMapping;
    private AdminStoreOwnerService $adminStoreOwnerService;
    private AdminOrderService $adminOrderService;
    private AdminCaptainService $adminCaptainService;
    private DateFactoryService $dateFactoryService;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, AdminStoreOwnerService $adminStoreOwnerService, AdminOrderService $adminOrderService, AdminCaptainService $adminCaptainService,
                                DateFactoryService $dateFactoryService, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminStoreOwnerService = $adminStoreOwnerService;
        $this->adminOrderService = $adminOrderService;
        $this->adminCaptainService = $adminCaptainService;
        $this->dateFactoryService = $dateFactoryService;
        $this->uploadFileHelperService = $uploadFileHelperService;
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

        // 1. orders statistics
        $response["data"]["orders"]["count"]["allOrders"] = $this->adminOrderService->getAllOrdersCountForAdmin();

        // order statistics in the last seven days
        $lastSevenDaysDates = $this->dateFactoryService->getLastSevenDaysDatesAsArray();

        if (! empty($lastSevenDaysDates)) {
            foreach ($lastSevenDaysDates as $key => $value) {
                $response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["daily"][$key]["date"] = $value;
                $response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["daily"][$key]["count"] = $this->adminOrderService->getDeliveredOrdersCountBetweenTwoDatesForAdmin(new DateTime($value),
                    (new DateTime($value))->setTime(23, 59, 59));
            }
        }

        $response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["sum"] = array_sum($response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["daily"]);

        $countValues = array_column($response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["daily"], "count");
        $response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["minDeliveredCountPerDay"] = min($countValues);
        $response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["maxDeliveredCountPerDay"] = max($countValues);

        $response["data"]["orders"]["count"]["pending"] = $this->adminOrderService->getPendingOrdersCountForAdmin();
        $response["data"]["orders"]["count"]["onGoing"] = $this->adminOrderService->getCountOrderOngoingForAdmin();

        // 2. stores statistics
        $response["data"]["stores"]["count"]["active"] = $this->adminStoreOwnerService->getStoreOwnersProfilesCountByStatusForAdmin(StoreProfileConstant::STORE_OWNER_PROFILE_ACTIVE_STATUS);
        $response["data"]["stores"]["count"]["inactive"] = $this->adminStoreOwnerService->getStoreOwnersProfilesCountByStatusForAdmin(StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS);
        $response["data"]["stores"]["count"]["lastThreeActive"] = $this->adminStoreOwnerService->getLastThreeActiveStoreOwnersProfilesForAdmin();

        // 3. captains statistics
        $response["data"]["captains"]["count"]["active"] = $this->adminCaptainService->getCaptainsCountByStatusForAdmin(CaptainConstant::CAPTAIN_ACTIVE);;
        $response["data"]["captains"]["count"]["inactive"] = $this->adminCaptainService->getCaptainsCountByStatusForAdmin(CaptainConstant::CAPTAIN_INACTIVE);;
        $response["data"]["captains"]["count"]["lastThreeActive"] = $this->adminCaptainService->getLastThreeActiveCaptainsProfilesForAdmin();

        return $response;
    }

    public function getCaptainsRatingsForAdmin(): array
    {
        $response = [];

        $captainsRatings = $this->adminCaptainService->getCaptainsRatingsForAdmin();

        // Sort the resulted array descending according to orders count key
        $sortedCaptainsResult = $this->sortArrayDescendingBySpecificKey($captainsRatings, 'avgRating');

        if (count($sortedCaptainsResult) > 0) {
            foreach ($sortedCaptainsResult as $key => $value) {
                $value['avgRating'] = round($value['avgRating'], 2);

                $response[$key] = $this->autoMapping->map('array', CaptainsRatingsForAdminGetResponse::class, $value);

                $response[$key]->image = $this->uploadFileHelperService->getImageParams($value['imagePath']);
            }
        }

        return $response;
    }

    public function getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByAdmin(): array
    {
        $response = [];

        $captainsResult = $this->adminCaptainService->getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByAdmin();

        // Sort the resulted array descending according to orders count key
        $sortedCaptainsResult = $this->sortArrayDescendingBySpecificKey($captainsResult, 'ordersCount');

        if (count($sortedCaptainsResult) > 0) {
            foreach ($sortedCaptainsResult as $captainInfo) {
                $captainInfo['image'] = $this->uploadFileHelperService->getImageParams($captainInfo['imagePath']);

                $response[] = $this->autoMapping->map('array', ActiveCaptainWithOrdersCountInLastFinancialCycleGetForAdminResponse::class, $captainInfo);
            }
        }

        return $response;
    }

    // Sort an array descending according on the value of specific key
    public function sortArrayDescendingBySpecificKey(array $inputArray, string $keyName): array
    {
        usort($inputArray, function($itemOne, $itemTwo) use ($keyName) {
            if((int) $itemOne[$keyName] === (int)$itemTwo[$keyName]) {
                return 0;

            } elseif ((int) $itemOne[$keyName] < (int)$itemTwo[$keyName]) {
                return 1;

            } elseif ((int) $itemOne[$keyName] > (int)$itemTwo[$keyName]) {
                return -1;
            }
        });

        return $inputArray;
    }

    public function getCaptainsWhoDeliveredOrdersDuringSpecificTime(CaptainWithDeliveredOrdersDuringSpecificTimeFilterByAdminRequest $request): array
    {
        $response = [];

        $captainsWithOrders = $this->adminCaptainService->getCaptainsWhoDeliveredOrdersDuringSpecificTime($request);

        $sortedCaptainsWithOrders = $this->sortArrayDescendingBySpecificKey($captainsWithOrders, 'ordersCount');

        if (count($sortedCaptainsWithOrders) > 0) {
            foreach ($sortedCaptainsWithOrders as $captainInfo) {
                $captainInfo['image'] = $this->uploadFileHelperService->getImageParams($captainInfo['imagePath']);

                $response[] = $this->autoMapping->map('array', CaptainsWithDeliveredOrdersCountFilterByAdminResponse::class, $captainInfo);
            }
        }

        return $response;
    }

    // Get top stores according on delivered orders during current month
    public function getTopOrdersStoresDuringCurrentMonthByAdmin(): array
    {
        $response = [];

        $storesWithOrders = $this->adminStoreOwnerService->getActiveStoresWithOrdersDuringCurrentMonthForAdmin();

        if (count($storesWithOrders) > 0) {
            // Sort the results descending according to the orders count
            $sortedStores = $this->sortArrayDescendingBySpecificKey($storesWithOrders, "ordersCount");

            foreach ($sortedStores as $value) {
                $value['image'] = $this->uploadFileHelperService->getImageParams($value['images']);

                $value['storeBranchName'] = $this->getTopBranchOfOrders($value['orders']);

                $response[] = $this->autoMapping->map('array', TopOrdersStoresForCurrentMonthByAdminGetResponse::class, $value);
            }
        }

        return $response;
    }

    public function getTopBranchOfOrders(array $inputArray): string|int
    {
        if (count($inputArray) === 0) {
            return 0;
        }

        $topFrequentedValueArray = $this->getTopFrequentedElement($inputArray);

        foreach ($inputArray as $item) {
            if ($item['branchId'] === $topFrequentedValueArray[0]) {
                return $item['branchName'];
            }
        }

        return 0;
    }

    public function getTopFrequentedElement(array $inputArray): array
    {
        // Get array of specific value frequencies
        $valueFrequenciesArray = array_count_values(array_map(function($item) {
            return $item['branchId'];
        }, $inputArray));

        // return top frequented value
        return array_keys($valueFrequenciesArray, max($valueFrequenciesArray));
    }

    // Get top stores according on delivered orders during specific time
    public function filterTopStoresAccordingOnOrdersByAdmin(StoresAndOrdersCountDuringSpecificTimeFilterByAdminRequest $request): array
    {
        $response = [];

        $storesWithOrders = $this->adminStoreOwnerService->filterTopStoresAccordingOnOrdersByAdmin($request);

        if (count($storesWithOrders) > 0) {
            // Sort the results descending according to the orders count
            $sortedStoresWithOrders = $this->sortArrayDescendingBySpecificKey($storesWithOrders, 'ordersCount');

            foreach ($sortedStoresWithOrders as $storeInfo) {//dd($storeInfo);
                $storeInfo['image'] = $this->uploadFileHelperService->getImageParams($storeInfo['images']);

                $response[] = $this->autoMapping->map('array', StoresWithOrdersCountDuringSpecificTimeFilterByAdminResponse::class, $storeInfo);
            }
        }

        return $response;
    }

    public function getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByTester(?string $customizedTimezone): array
    {
        $response = [];

        $captainsResult = $this->adminCaptainService->getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByTester($customizedTimezone);

        if (count($captainsResult) > 0) {
            foreach ($captainsResult as $captainInfo) {
                $captainInfo['image'] = $this->uploadFileHelperService->getImageParams($captainInfo['imagePath']);

                $response[] = $this->autoMapping->map('array', ActiveCaptainWithOrdersCountInLastFinancialCycleGetForAdminResponse::class, $captainInfo);
            }
        }

        return $response;
    }
}
