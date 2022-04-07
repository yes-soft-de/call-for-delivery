<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemAccordingToCountOfHoursEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfHoursManager;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfHoursResponse;

class CaptainFinancialSystemAccordingToCountOfHoursService
{
    private CaptainFinancialSystemAccordingToCountOfHoursManager $captainFinancialSystemAccordingToCountOfHoursManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemAccordingToCountOfHoursManager $captainFinancialSystemAccordingToCountOfHoursManager)
    {
        $this->autoMapping = $autoMapping;
        $this->captainFinancialSystemAccordingToCountOfHoursManager = $captainFinancialSystemAccordingToCountOfHoursManager;
    }

    public function getAllCaptainFinancialSystemAccordingToCountOfHours(): array
    {
        $response = [];

        $items = $this->captainFinancialSystemAccordingToCountOfHoursManager->getAllCaptainFinancialSystemAccordingToCountOfHours();

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map(CaptainFinancialSystemAccordingToCountOfHoursEntity::class, CaptainFinancialSystemAccordingToCountOfHoursResponse::class, $item);
        }

        return $response;
    }
}
