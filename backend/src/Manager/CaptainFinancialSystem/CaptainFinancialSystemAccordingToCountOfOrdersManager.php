<?php

namespace App\Manager\CaptainFinancialSystem;

use Doctrine\ORM\EntityManagerInterface;
use App\Repository\CaptainFinancialSystemAccordingToCountOfOrdersEntityRepository;

class CaptainFinancialSystemAccordingToCountOfOrdersManager
{
    private CaptainFinancialSystemAccordingToCountOfOrdersEntityRepository $captainFinancialSystemAccordingToCountOfOrdersEntityRepository;

    public function __construct(EntityManagerInterface $entityManager, CaptainFinancialSystemAccordingToCountOfOrdersEntityRepository $captainFinancialSystemAccordingToCountOfOrdersEntityRepository)
    {
        $this->entityManager = $entityManager;
        $this->captainFinancialSystemAccordingToCountOfOrdersEntityRepository = $captainFinancialSystemAccordingToCountOfOrdersEntityRepository;
    }

    public function getAllCaptainFinancialSystemAccordingToCountOfOrders(): ?array
    {
        return $this->captainFinancialSystemAccordingToCountOfOrdersEntityRepository->findAll();
    }
}
