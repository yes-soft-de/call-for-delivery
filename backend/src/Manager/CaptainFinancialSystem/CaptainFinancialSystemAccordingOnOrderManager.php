<?php

namespace App\Manager\CaptainFinancialSystem;

use App\Repository\CaptainFinancialSystemAccordingOnOrderEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class CaptainFinancialSystemAccordingOnOrderManager
{
    private CaptainFinancialSystemAccordingOnOrderEntityRepository $captainFinancialSystemAccordingOnOrderEntityRepository;

    public function __construct(EntityManagerInterface $entityManager, CaptainFinancialSystemAccordingOnOrderEntityRepository $captainFinancialSystemAccordingOnOrderEntityRepository)
    {
        $this->entityManager = $entityManager;
        $this->captainFinancialSystemAccordingOnOrderEntityRepository = $captainFinancialSystemAccordingOnOrderEntityRepository;
    }

    public function getAllCaptainFinancialSystemAccordingOnOrder(): ?array
    {
        return $this->captainFinancialSystemAccordingOnOrderEntityRepository->findAll();
    }
}
