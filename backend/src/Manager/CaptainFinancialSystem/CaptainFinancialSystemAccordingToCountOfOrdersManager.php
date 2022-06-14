<?php

namespace App\Manager\CaptainFinancialSystem;

use App\Repository\CaptainFinancialSystemAccordingToCountOfOrdersEntityRepository;

class CaptainFinancialSystemAccordingToCountOfOrdersManager
{
    private CaptainFinancialSystemAccordingToCountOfOrdersEntityRepository $captainFinancialSystemAccordingToCountOfOrdersEntityRepository;

    public function __construct(CaptainFinancialSystemAccordingToCountOfOrdersEntityRepository $captainFinancialSystemAccordingToCountOfOrdersEntityRepository)
    {
        $this->captainFinancialSystemAccordingToCountOfOrdersEntityRepository = $captainFinancialSystemAccordingToCountOfOrdersEntityRepository;
    }

    public function getAllCaptainFinancialSystemAccordingToCountOfOrders(): ?array
    {
        return $this->captainFinancialSystemAccordingToCountOfOrdersEntityRepository->findBy(['status' => 1]);
    }
}
