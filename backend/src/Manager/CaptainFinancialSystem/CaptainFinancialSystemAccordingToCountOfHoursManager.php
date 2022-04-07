<?php

namespace App\Manager\CaptainFinancialSystem;

use App\Repository\CaptainFinancialSystemAccordingToCountOfHoursEntityRepository;


class CaptainFinancialSystemAccordingToCountOfHoursManager
{
    private CaptainFinancialSystemAccordingToCountOfHoursEntityRepository $captainFinancialSystemAccordingToCountOfHoursEntityRepository;

    public function __construct(CaptainFinancialSystemAccordingToCountOfHoursEntityRepository $captainFinancialSystemAccordingToCountOfHoursEntityRepository)
    {
        $this->captainFinancialSystemAccordingToCountOfHoursEntityRepository = $captainFinancialSystemAccordingToCountOfHoursEntityRepository;
    }

    public function getAllCaptainFinancialSystemAccordingToCountOfHours(): ?array
    {
        return $this->captainFinancialSystemAccordingToCountOfHoursEntityRepository->findAll();
    }
}
