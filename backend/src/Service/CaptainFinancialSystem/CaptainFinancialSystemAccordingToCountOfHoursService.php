<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemAccordingToCountOfHoursEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfHoursManager;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfHoursResponse;

class CaptainFinancialSystemAccordingToCountOfHoursService
{
    private CaptainFinancialSystemAccordingToCountOfHoursManager $CaptainFinancialSystemAccordingToCountOfHoursManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemAccordingToCountOfHoursManager $CaptainFinancialSystemAccordingToCountOfHoursManager)
    {
        $this->autoMapping = $autoMapping;
        $this->CaptainFinancialSystemAccordingToCountOfHoursManager = $CaptainFinancialSystemAccordingToCountOfHoursManager;
    }

    public function getAllCaptainFinancialSystemAccordingToCountOfHours(): array
    {
        $response = [];

        $items = $this->CaptainFinancialSystemAccordingToCountOfHoursManager->getAllCaptainFinancialSystemAccordingToCountOfHours();

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map(CaptainFinancialSystemAccordingToCountOfHoursEntity::class, CaptainFinancialSystemAccordingToCountOfHoursResponse::class, $item);
        }

        return $response;
    }
}
