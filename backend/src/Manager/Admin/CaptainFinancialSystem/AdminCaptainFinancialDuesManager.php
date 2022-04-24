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
    
    public function updateCaptainFinancialDuesStatus(CaptainFinancialDuesEntity $captainFinancialDuesEntity, int $status): CaptainFinancialDuesEntity
    {
        $captainFinancialDuesEntity->setStatus($status);

        $this->entityManager->flush();

        return $captainFinancialDuesEntity;
    } 
    
    public function getCaptainFinancialDuesById(int $id): CaptainFinancialDuesEntity
    {
        return $this->captainFinancialDuesRepository->find($id);
    } 
    
    public function getSumCaptainFinancialDuesAndsumPaymentsToCaptainBycaptainFinancialDueId(int $id): array
    {
        return $this->captainFinancialDuesRepository->getSumCaptainFinancialDuesAndsumPaymentsToCaptainBycaptainFinancialDueId($id);
    } 
}
