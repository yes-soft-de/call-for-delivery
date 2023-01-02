<?php

namespace App\Service\CaptainOrderFinancialService;

use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemDetail\CaptainFinancialSystemDetailGetService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemOne\OrderFinancialValueAccordingToSystemOneCalculationService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemThree\OrderFinancialValueAccordingToSystemThreeCalculationService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo\OrderFinancialValueAccordingToSystemTwoCalculationService;

class OrderFinancialValueGetService
{
    private CaptainFinancialSystemDetailGetService $captainFinancialSystemDetailGetService;
    private OrderFinancialValueAccordingToSystemTwoCalculationService $orderFinancialValueAccordingToSystemTwoCalculationService;
    private OrderFinancialValueAccordingToSystemThreeCalculationService $orderFinancialValueAccordingToSystemThreeCalculationService;
    private OrderFinancialValueAccordingToSystemOneCalculationService $orderFinancialValueAccordingToSystemOneCalculationService;

    public function __construct(CaptainFinancialSystemDetailGetService $captainFinancialSystemDetailGetService, OrderFinancialValueAccordingToSystemTwoCalculationService $orderFinancialValueAccordingToSystemTwoCalculationService,
                                OrderFinancialValueAccordingToSystemThreeCalculationService $orderFinancialValueAccordingToSystemThreeCalculationService, OrderFinancialValueAccordingToSystemOneCalculationService $orderFinancialValueAccordingToSystemOneCalculationService)
    {
        $this->captainFinancialSystemDetailGetService = $captainFinancialSystemDetailGetService;
        $this->orderFinancialValueAccordingToSystemTwoCalculationService = $orderFinancialValueAccordingToSystemTwoCalculationService;
        $this->orderFinancialValueAccordingToSystemThreeCalculationService = $orderFinancialValueAccordingToSystemThreeCalculationService;
        $this->orderFinancialValueAccordingToSystemOneCalculationService = $orderFinancialValueAccordingToSystemOneCalculationService;
    }

    public function getSingleOrderFinancialValueByCaptainUserId(int $captainProfileId, int $captainUserId, float $orderDistance = null): float
    {
        // First, get the captain financial system type and id
        $captainFinancialSystemDetails = $this->captainFinancialSystemDetailGetService->getLastCaptainFinancialSystemDetailByCaptainUserId($captainUserId);

        if (count($captainFinancialSystemDetails) > 0) {
            // Depending on financial system type and id, calculate the expected financial value of the order
            if ($captainFinancialSystemDetails['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
                // Captain financial system is the third one
                return $this->getOrderFinancialValueAccordingOnCountOfHours($captainFinancialSystemDetails['compensationForEveryOrder'], $orderDistance);

            } elseif ($captainFinancialSystemDetails['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {
                // Captain financial system is the second one
                return $this->getOrderFinancialValueAccordingToCountOfOrders($captainProfileId, $captainFinancialSystemDetails, $orderDistance);

            } elseif ($captainFinancialSystemDetails['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
                // Captain financial system is the third one
                return $this->getOrderFinancialValueAccordingOnOrders($captainProfileId, $orderDistance);
            }
        }

        return 0.0;
    }

    public function getOrderFinancialValueAccordingToCountOfOrders(int $captainProfileId, array $captainFinancialSystemDetails,
                                                                   float $orderDistance = null): float
    {
        return $this->orderFinancialValueAccordingToSystemTwoCalculationService->getOrderFinancialValueAccordingToCountOfOrders($captainProfileId,
            $captainFinancialSystemDetails, $orderDistance);
    }

    public function getOrderFinancialValueAccordingOnOrders(int $captainProfileId, float $orderDistance = null): float
    {
        return $this->orderFinancialValueAccordingToSystemThreeCalculationService->getOrderFinancialValueAccordingOnOrders($captainProfileId,
            $orderDistance);
    }

    public function getOrderFinancialValueAccordingOnCountOfHours(float $compensationForEveryOrder, float $orderDistance = null): float
    {
        return $this->orderFinancialValueAccordingToSystemOneCalculationService->getOrderFinancialValueAccordingOnCountOfHours($compensationForEveryOrder,
            $orderDistance);
    }
}
