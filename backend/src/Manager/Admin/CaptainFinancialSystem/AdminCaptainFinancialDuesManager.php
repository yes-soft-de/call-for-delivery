<?php

namespace App\Manager\Admin\CaptainFinancialSystem;

use App\Entity\CaptainFinancialDuesEntity;
use App\Repository\CaptainFinancialDuesEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class AdminCaptainFinancialDuesManager
{
    private CaptainFinancialDuesEntityRepository $captainFinancialDuesRepository;
    private EntityManagerInterface $entityManager;

    public function __construct(CaptainFinancialDuesEntityRepository $captainFinancialDuesRepository, EntityManagerInterface $entityManager)
    {
        $this->captainFinancialDuesRepository = $captainFinancialDuesRepository;
        $this->entityManager = $entityManager;
    }
    
    public function getCaptainFinancialDuesByCaptainId(int $captainId): array
    {
        return $this->captainFinancialDuesRepository->getCaptainFinancialDuesByCaptainId($captainId);
    } 
    
    public function updateCaptainFinancialDuesStatus(int $id, int $status): CaptainFinancialDuesEntity
    {
        $captainFinancialDuesEntity = $this->captainFinancialDuesRepository->find($id);
        $captainFinancialDuesEntity->setStatus($status);

        $this->entityManager->flush();

        return $captainFinancialDuesEntity;
    } 
}
