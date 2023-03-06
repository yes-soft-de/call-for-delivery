<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemThree;

use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemAccordingOnOrderManager;

class CaptainFinancialSystemThreeGetService
{
    private CaptainFinancialSystemAccordingOnOrderManager $captainFinancialSystemAccordingOnOrderManager;

    public function __construct(CaptainFinancialSystemAccordingOnOrderManager $captainFinancialSystemAccordingOnOrderManager)
    {
        $this->captainFinancialSystemAccordingOnOrderManager = $captainFinancialSystemAccordingOnOrderManager;
    }

    public function getAllActiveCaptainFinancialSystemAccordingOnOrder(): ?array
    {
        return $this->captainFinancialSystemAccordingOnOrderManager->getAllCaptainFinancialSystemAccordingOnOrder();
    }

    public function getAllCaptainFinancialSystemThreePlansAsArray(): array
    {
        return $this->captainFinancialSystemAccordingOnOrderManager->getCaptainFinancialSystemAccordingOnOrder();
    }
}
