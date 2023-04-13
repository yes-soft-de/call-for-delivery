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
use App\Service\Admin\Order\AdminOrderGetService;
use App\Service\Admin\Order\AdminOrderService;
use App\Service\Admin\StoreOwner\AdminStoreOwnerService;
use App\Service\Admin\StoreOwnerBranch\AdminStoreOwnerBranchGetService;
use App\Service\DateFactory\DateFactoryService;
use App\Service\FileUpload\UploadFileHelperService;
use DateTime;

class ReportService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminStoreOwnerService $adminStoreOwnerService,
        private AdminOrderService $adminOrderService,
        private AdminCaptainService $adminCaptainService,
        private DateFactoryService $dateFactoryService,
        private UploadFileHelperService $uploadFileHelperService,
        private AdminStoreOwnerBranchGetService $adminStoreOwnerBranchGetService,
        private AdminOrderGetService $adminOrderGetService
    )
    {
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

        // Get the count of delivered orders today
        $response['todayDeliveredOrdersCount'] = $this->adminOrderService->getDeliveredOrdersCountBetweenTwoDatesForAdmin(new \DateTime('midnight yesterday'),
            new \DateTime('midnight today'));

        // Get the count of delivered orders last seven days
        $response['previousWeekDeliveredOrdersCount'] = $this->adminOrderService->getDeliveredOrdersCountBetweenTwoDatesForAdmin(new \DateTime('-6 day'),
            new \DateTime('now'));

        return $this->autoMapping->map('array', StatisticsForAdminGetResponse::class, $response);
    }

    /**
     * Get array of last seven days dates
     */
    public function getLastSevenDaysDatesAsArray(): array
    {
        return $this->dateFactoryService->getLastSevenDaysDatesAsArray();
    }

    public function getDashboardStatisticsForAdmin(string $customizedTimezone = null): array
    {
        $response = [];

        // 1. orders statistics
        $response["data"]["orders"]["count"]["allOrders"] = $this->adminOrderService->getAllOrdersCountForAdmin();

        // order statistics in the last seven days
        $lastSevenDaysDates = $this->getLastSevenDaysDatesAsArray();

        if (! empty($lastSevenDaysDates)) {
            foreach ($lastSevenDaysDates as $key => $value) {//dd($value);
                $response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["daily"][$key]["date"] = $value;
                $response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["daily"][$key]["count"] = $this->adminOrderService->getDeliveredOrdersCountBetweenTwoDatesForAdmin(new DateTime($value),
                    (new DateTime($value))->setTime(23, 59, 59), $customizedTimezone);
            }
        }

        $response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["sum"] = array_sum(array_column($response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["daily"],
            "count"));

        $countValues = array_column($response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["daily"], "count");

        $minOrderCountPerDay = min($countValues);
        $maxOrderCountPerDay = max($countValues);

        $response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["minDeliveredCountPerDay"] = $minOrderCountPerDay;
        $response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["maxDeliveredCountPerDay"] = $maxOrderCountPerDay;

        // get the date of the day which contains the min orders count
        $response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["minDeliveredCountDayDate"] = $this->getSpecificObjectOfArrayBySpecificPropertyValue(
            $response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["daily"], "count",
            $minOrderCountPerDay, "date"
        );

        // get the date of the day which contains the max orders count
        $response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["maxDeliveredCountDayDate"] = $this->getSpecificObjectOfArrayBySpecificPropertyValue(
            $response["data"]["orders"]["count"]["delivered"]["lastSevenDays"]["daily"], "count",
            $maxOrderCountPerDay, "date"
        );

        $response["data"]["orders"]["count"]["pending"] = $this->adminOrderService->getPendingOrdersCountForAdmin();
        $response["data"]["orders"]["count"]["onGoing"] = $this->adminOrderService->getCountOrderOngoingForAdmin();

        // 2. stores statistics
        $response["data"]["stores"]["count"]["active"] = $this->adminStoreOwnerService->getStoreOwnersProfilesCountByStatusForAdmin(StoreProfileConstant::STORE_OWNER_PROFILE_ACTIVE_STATUS);
        $response["data"]["stores"]["count"]["inactive"] = $this->adminStoreOwnerService->getStoreOwnersProfilesCountByStatusForAdmin(StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS);
        $response["data"]["stores"]["count"]["lastThreeActive"] = $this->adminStoreOwnerService->getLastThreeActiveStoreOwnersProfilesForAdmin();
        $response["data"]["stores"]["count"]["lastFiveCreatedOrderStores"] = $this->adminOrderService->getStoresWhichCreatedLastFiveOrders();

        // 3. captains statistics
        $response["data"]["captains"]["count"]["active"] = $this->adminCaptainService->getCaptainsCountByStatusForAdmin(CaptainConstant::CAPTAIN_ACTIVE);;
        $response["data"]["captains"]["count"]["inactive"] = $this->adminCaptainService->getCaptainsCountByStatusForAdmin(CaptainConstant::CAPTAIN_INACTIVE);;
        $response["data"]["captains"]["count"]["lastThreeActive"] = $this->adminCaptainService->getLastThreeActiveCaptainsProfilesForAdmin();
        $response["data"]["captains"]["count"]["lastFiveDeliveredOrdersCaptains"] = $this->adminOrderService->getCaptainsWhoDeliveredLastFiveOrders();

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

    /**
     * Get array of branch id, branch name, store id. store name, and store profile image for admin
     */
    public function getBranchesForAdmin(): array
    {
        return $this->adminStoreOwnerBranchGetService->getBranchesForAdmin();
    }

    /**
     * Get the count of delivered orders according to dates and a specific store's branch
     */
    public function getDeliveredOrdersCountBetweenTwoDatesAndByStoreBranchId(int $storeBranchId, DateTime $fromDate, DateTime $toDate): array
    {
        return $this->adminOrderGetService->getDeliveredOrdersCountBetweenTwoDatesAndByStoreBranchId($storeBranchId,
            $fromDate, $toDate);
    }

    /**
     * Get top stores' branches according to orders count of each branch in the current month
     */
    public function getTopStoreBranchesAccordingToCurrentMonthOrdersCount(): array
    {
        $response = [];

        $storesBranches = $this->getBranchesForAdmin();

        if (count($storesBranches) > 0) {
            foreach ($storesBranches as $branch) {

                // Get orders count of current month of the branch
                $branchOrdersCount = $this->getDeliveredOrdersCountBetweenTwoDatesAndByStoreBranchId($branch['storeBranchId'],
                    (new \DateTime('first day of this month'))->setTime(00, 00, 00),
                    (new \DateTime('last day of this month'))->setTime(23, 59, 59));

                if (count($branchOrdersCount) > 0) {
                    $branch['ordersCount'] = (int) $branchOrdersCount[0];

                    $branch['image'] = $this->uploadFileHelperService->getImageParams($branch['images']);

                    $response[] = $this->autoMapping->map('array', TopOrdersStoresForCurrentMonthByAdminGetResponse::class, $branch);
                }
            }

            // Sort the results descending according to the orders count of each element (branch)
            return $this->sortTopOrdersStoresForCurrentMonthArrayDescendingBySpecificKey($response, "ordersCount");
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

            foreach ($sortedStoresWithOrders as $storeInfo) {
                $storeInfo['image'] = $this->uploadFileHelperService->getImageParams($storeInfo['images']);
                // Select top branch
                $storeInfo['storeBranchName'] = $this->getTopBranchOfOrders($storeInfo['orders']);

                $response[] = $this->autoMapping->map('array', StoresWithOrdersCountDuringSpecificTimeFilterByAdminResponse::class, $storeInfo);
            }
        }

        return $response;
    }

    // FOR DEBUG ISSUES
//    public function getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByTester(?string $customizedTimezone): array
//    {
//        $response = [];
//
//        $captainsResult = $this->adminCaptainService->getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByTester($customizedTimezone);
//
//        if (count($captainsResult) > 0) {
//            foreach ($captainsResult as $captainInfo) {
//                $captainInfo['image'] = $this->uploadFileHelperService->getImageParams($captainInfo['imagePath']);
//
//                $response[] = $this->autoMapping->map('array', ActiveCaptainWithOrdersCountInLastFinancialCycleGetForAdminResponse::class, $captainInfo);
//            }
//        }
//
//        return $response;
//    }

    /**
     * Get specific object of array by specific parameter's value of this object
     */
    public function getSpecificObjectOfArrayBySpecificPropertyValue(array $mainArray, string $propertyKey, int $comparingValue, string $propertyToBeReturned): string
    {
        foreach ($mainArray as $item) {
            if ($item[$propertyKey] === $comparingValue) {
                return $item[$propertyToBeReturned];
            }
        }

        return $mainArray[0][$propertyToBeReturned];
    }

    /**
     * Sort an array of TopOrdersStoresForCurrentMonthByAdminGetResponse objects by specific parameter
     */
    public function sortTopOrdersStoresForCurrentMonthArrayDescendingBySpecificKey(array $inputArray, string $keyName): array
    {
        usort($inputArray, function($itemOne, $itemTwo) use ($keyName) {
            if($itemOne->$keyName === $itemTwo->$keyName) {
                return 0;

            } elseif ($itemOne->$keyName < $itemTwo->$keyName) {
                return 1;

            } elseif ($itemOne->$keyName > $itemTwo->$keyName) {
                return -1;
            }
        });

        return $inputArray;
    }
}
