<?php

namespace App\Service\CaptainOrderFinancialService;

use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemDetail\CaptainFinancialSystemDetailGetService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo\OrderFinancialValueAccordingToSystemTwoCalculationService;

class OrderFinancialValueGetService
{
    private CaptainFinancialSystemDetailGetService $captainFinancialSystemDetailGetService;
    private OrderFinancialValueAccordingToSystemTwoCalculationService $orderFinancialValueAccordingToSystemTwoCalculationService;

    public function __construct(CaptainFinancialSystemDetailGetService $captainFinancialSystemDetailGetService, OrderFinancialValueAccordingToSystemTwoCalculationService $orderFinancialValueAccordingToSystemTwoCalculationService)
    {
        $this->captainFinancialSystemDetailGetService = $captainFinancialSystemDetailGetService;
        $this->orderFinancialValueAccordingToSystemTwoCalculationService = $orderFinancialValueAccordingToSystemTwoCalculationService;
    }

    public function getSingleOrderFinancialValueByCaptainUserId(int $captainProfileId, int $captainUserId, float $orderDistance = null): float
    {
        // First, get the captain financial system type and id
        $captainFinancialSystemDetails = $this->captainFinancialSystemDetailGetService->getLastCaptainFinancialSystemDetailByCaptainUserId($captainUserId);

        if (count($captainFinancialSystemDetails) > 0) {
            // Depending on financial system type and id, calculate the expected financial value of the order
            if ($captainFinancialSystemDetails['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
                // Captain financial system is the third one
                ////TODO TO BE CONTINUED

            } elseif ($captainFinancialSystemDetails['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {
                // Captain financial system is the second one
                return $this->getOrderFinancialValueAccordingToCountOfOrders($captainProfileId, $captainUserId, $captainFinancialSystemDetails['countOrdersInMonth'],
                    $captainFinancialSystemDetails['monthCompensation'], $orderDistance);

            } elseif ($captainFinancialSystemDetails['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
                // Captain financial system is the third one
                ////TODO TO BE CONTINUED
            }
        }

        return 0.0;
    }

    public function getOrderFinancialValueAccordingToCountOfOrders(int $captainProfileId, int $captainUserId, int $countOrdersInMonth, float $monthCompensation, float $orderDistance = null): float
    {
        return $this->orderFinancialValueAccordingToSystemTwoCalculationService->getOrderFinancialValueAccordingToCountOfOrders($captainProfileId, $captainUserId,
            $countOrdersInMonth, $monthCompensation, $orderDistance);
    }
}
