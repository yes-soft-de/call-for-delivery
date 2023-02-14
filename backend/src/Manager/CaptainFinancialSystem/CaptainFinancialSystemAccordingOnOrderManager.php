<?php

namespace App\Manager\CaptainFinancialSystem;

use App\Repository\CaptainFinancialSystemAccordingOnOrderEntityRepository;

class CaptainFinancialSystemAccordingOnOrderManager
{
    private CaptainFinancialSystemAccordingOnOrderEntityRepository $captainFinancialSystemAccordingOnOrderEntityRepository;

    public function __construct(CaptainFinancialSystemAccordingOnOrderEntityRepository $captainFinancialSystemAccordingOnOrderEntityRepository)
    {
        $this->captainFinancialSystemAccordingOnOrderEntityRepository = $captainFinancialSystemAccordingOnOrderEntityRepository;
    }

    public function getAllCaptainFinancialSystemAccordingOnOrder(): ?array
    {
        return $this->captainFinancialSystemAccordingOnOrderEntityRepository->findBy(['status' => 1]);
    }
    
    public function getCaptainFinancialSystemAccordingOnOrder(): array
    {
        return $this->captainFinancialSystemAccordingOnOrderEntityRepository->getCaptainFinancialSystemAccordingOnOrder();
    }
}
