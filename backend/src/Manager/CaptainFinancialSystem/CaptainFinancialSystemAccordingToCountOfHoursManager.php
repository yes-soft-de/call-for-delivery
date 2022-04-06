<?php

namespace App\Manager\CaptainFinancialSystem;

use App\Repository\CaptainFinancialSystemAccordingToCountOfHoursEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class CaptainFinancialSystemAccordingToCountOfHoursManager
{
    private CaptainFinancialSystemAccordingToCountOfHoursEntityRepository $captainFinancialSystemAccordingToCountOfHoursEntityRepository;

    public function __construct(EntityManagerInterface $entityManager, CaptainFinancialSystemAccordingToCountOfHoursEntityRepository $captainFinancialSystemAccordingToCountOfHoursEntityRepository)
    {
        $this->entityManager = $entityManager;
        $this->captainFinancialSystemAccordingToCountOfHoursEntityRepository = $captainFinancialSystemAccordingToCountOfHoursEntityRepository;
    }

    public function getAllCaptainFinancialSystemAccordingToCountOfHours(): ?array
    {
        return $this->captainFinancialSystemAccordingToCountOfHoursEntityRepository->findAll();
    }
}
