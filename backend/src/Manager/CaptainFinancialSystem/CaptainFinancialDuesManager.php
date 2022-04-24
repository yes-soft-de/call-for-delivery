<?php

namespace App\Manager\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialDuesEntity;
use App\Repository\CaptainFinancialDuesEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\CaptainFinancialSystem\CreateCaptainFinancialDuesRequest;
use App\Manager\Captain\CaptainManager;

class CaptainFinancialDuesManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private CaptainFinancialDuesEntityRepository $captainFinancialDuesRepository;
    private CaptainManager $captainManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CaptainFinancialDuesEntityRepository $captainFinancialDuesRepository, CaptainManager $captainManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainFinancialDuesRepository = $captainFinancialDuesRepository;
        $this->captainManager = $captainManager;
    }

    public function createCaptainFinancialDues(CreateCaptainFinancialDuesRequest $request): CaptainFinancialDuesEntity
    {
        $request->setCaptain($this->captainManager->getCaptainProfileById($request->getCaptain()));
      
        $captainFinancialSystemDetailEntity = $this->autoMapping->map(CreateCaptainFinancialDuesRequest::class, CaptainFinancialDuesEntity::class, $request);

        $this->entityManager->persist($captainFinancialSystemDetailEntity);
        $this->entityManager->flush();

        return $captainFinancialSystemDetailEntity;
    }

    public function getCaptainFinancialDues(int $captainId, array $date): ?CaptainFinancialDuesEntity
    {
        return $this->captainFinancialDuesRepository->findOneBy(["captain" => $captainId, "startDate" => $date['fromDate'], "endDate" => $date['toDate']]);
    } 

    public function updateCaptainFinancialDues(CaptainFinancialDuesEntity $captainFinancialDues): CaptainFinancialDuesEntity
    {
        $this->entityManager->flush();

        return $captainFinancialDues;
    } 
    
    public function getCaptainFinancialDuesByUserId(int $userId): array
    {
        return $this->captainFinancialDuesRepository->getCaptainFinancialDuesByUserId($userId);
    } 
    
    public function getSumCaptainFinancialDuesById(int $captainFinancialDueId): array
    {
        return $this->captainFinancialDuesRepository->getSumCaptainFinancialDuesById($captainFinancialDueId);
    } 
}
