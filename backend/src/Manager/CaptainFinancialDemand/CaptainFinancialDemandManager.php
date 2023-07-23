<?php

namespace App\Manager\CaptainFinancialDemand;

use App\AutoMapping;
use App\Entity\CaptainFinancialDemandEntity;
use App\Repository\CaptainFinancialDemandEntityRepository;
use App\Request\CaptainFinancialDemand\CaptainFinancialDemandCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class CaptainFinancialDemandManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private CaptainFinancialDemandEntityRepository $captainFinancialDemandEntityRepository
    )
    {
    }

    public function createCaptainFinancialDemand(CaptainFinancialDemandCreateRequest $request): CaptainFinancialDemandEntity
    {
        $captainFinancialDemand = $this->autoMapping->map(CaptainFinancialDemandCreateRequest::class,
            CaptainFinancialDemandEntity::class, $request);

        //$captainFinancialDemand->setIsPaid(false);

        $this->entityManager->persist($captainFinancialDemand);
        $this->entityManager->flush();

        return $captainFinancialDemand;
    }

    public function getCaptainFinancialDemandByCaptainFinancialDueId(int $captainFinancialDueId): array
    {
        return $this->captainFinancialDemandEntityRepository->findBy(['captainFinancialDueId' => $captainFinancialDueId]);
    }
}
