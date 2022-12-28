<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemThree;

use App\Service\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueGetService;
use App\Service\CaptainFinancialSystemDate\CaptainFinancialSystemDateService;

class OrderFinancialValueAccordingToSystemThreeCalculationService
{
    private CaptainFinancialSystemThreeGetService $captainFinancialSystemThreeGetService;
    private CaptainFinancialDueGetService $captainFinancialDueGetService;
    private CaptainFinancialSystemDateService $captainFinancialSystemDateService;
    private CaptainFinancialSystemThreeBalanceDetailsGetService $captainFinancialSystemThreeBalanceDetailsGetService;

    public function __construct(CaptainFinancialSystemThreeGetService $captainFinancialSystemThreeGetService, CaptainFinancialDueGetService $captainFinancialDueGetService,
                                CaptainFinancialSystemDateService $captainFinancialSystemDateService, CaptainFinancialSystemThreeBalanceDetailsGetService $captainFinancialSystemThreeBalanceDetailsGetService)
    {
        $this->captainFinancialSystemThreeGetService = $captainFinancialSystemThreeGetService;
        $this->captainFinancialDueGetService = $captainFinancialDueGetService;
        $this->captainFinancialSystemDateService = $captainFinancialSystemDateService;
        $this->captainFinancialSystemThreeBalanceDetailsGetService = $captainFinancialSystemThreeBalanceDetailsGetService;
    }

    // Calculate the expected financial value of an order and return it
    // Get all categories of the third financial system
    // For each category:
    //      Check if order belong to it (according to distance) and if it is, then get its value
    //      Get the delivered orders count in this category kilometers range:
    //          Check if the count meet the required one for getting a bonus after delivering the order
    public function getOrderFinancialValueAccordingOnOrders(int $captainProfileId, float $orderDistance = null): float
    {
        $thirdFinancialSystemCategories = $this->captainFinancialSystemThreeGetService->getAllActiveCaptainFinancialSystemAccordingOnOrder();

        if (($thirdFinancialSystemCategories) && (count($thirdFinancialSystemCategories) > 0)) {
            // First, check if the distance is calculated
            if (! $orderDistance) {
                return 0.0;
            }

            // final captain profit of the order
            $captainProfit = 0.0;

            foreach ($thirdFinancialSystemCategories as $thirdFinancialSystemCategory) {//dd($thirdFinancialSystemCategory);
                // Check if order belong to the category
                if (($orderDistance >= $thirdFinancialSystemCategory->getCountKilometersFrom()) &&
                    ($orderDistance <= $thirdFinancialSystemCategory->getCountKilometersTo())) {
                    // As long as the order belong to the category, then get its value
                    $captainProfit += $thirdFinancialSystemCategory->getAmount();

                    // Also, check if there is bonus for this category
                    if (($thirdFinancialSystemCategory->getBounceCountOrdersInMonth()) &&
                        ($thirdFinancialSystemCategory->getBounceCountOrdersInMonth() > 0)) {
                        $ordersCount = $this->getCountOrdersByFinancialSystemThreeDuringCurrentAndActiveFinancialCycle($captainProfileId,
                            $thirdFinancialSystemCategory->getCountKilometersFrom(), $thirdFinancialSystemCategory->getCountKilometersTo());

                        if ($ordersCount) {
                            if (($ordersCount['countOrder'] + 1) >= $thirdFinancialSystemCategory->getBounceCountOrdersInMonth()) {
                                $captainProfit += $thirdFinancialSystemCategory->getBounce();
                            }
                        }
                    }
                }
            }

            return $captainProfit;
        }

        return 0.0;
    }

    public function getCountOrdersByFinancialSystemThreeDuringCurrentAndActiveFinancialCycle(int $captainProfileId, float $countKilometersFrom,
                                                                                             float $countKilometersTo): ?array
    {
        $dates = $this->getLatestCaptainFinancialDuesStartAndEndDates($captainProfileId);

        return $this->getCountOrdersByFinancialSystemThree($captainProfileId, $dates['fromDate'], $dates['toDate'], $countKilometersFrom, $countKilometersTo);
    }

    public function getCountOrdersByFinancialSystemThree(int $captainProfileId, string $fromDate, string $toDate, float $countKilometersFrom,
                                                         float $countKilometersTo): ?array
    {
        return $this->captainFinancialSystemThreeBalanceDetailsGetService->getCountOrdersByFinancialSystemThree($captainProfileId,
            $fromDate, $toDate, $countKilometersFrom, $countKilometersTo);
    }

    public function getLatestCaptainFinancialDues(int $captainProfileId): ?array
    {
        return $this->captainFinancialDueGetService->getLatestCaptainFinancialDues($captainProfileId);
    }

    public function getLatestCaptainFinancialDuesStartAndEndDates(int $captainProfileId): array
    {
        $captainFinancialDues = $this->getLatestCaptainFinancialDues($captainProfileId);

        if ($captainFinancialDues) {
            return [
                "fromDate" => $captainFinancialDues['startDate']->format('Y-m-d 00:00:00'),
                "toDate" => $captainFinancialDues['endDate']->format('y-m-d 23:59:59')
            ];

        } else {
            return $this->captainFinancialSystemDateService->getFromDateAndToDate();
        }
    }
}
