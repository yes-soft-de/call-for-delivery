<?php

namespace App\Manager\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialDuesEntity;
use App\Repository\CaptainFinancialDuesEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\CaptainFinancialSystem\CreateCaptainFinancialDuesRequest;
use App\Manager\Captain\CaptainManager;
use DateTime;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;

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
      
        $captainFinancialDuesEntity = $this->autoMapping->map(CreateCaptainFinancialDuesRequest::class, CaptainFinancialDuesEntity::class, $request);
       
        $captainFinancialDuesEntity->setState(CaptainFinancialDues::FINANCIAL_STATE_ACTIVE);
       
        $this->entityManager->persist($captainFinancialDuesEntity);
        $this->entityManager->flush();

        return $captainFinancialDuesEntity;
    }

    public function getCaptainFinancialDues(int $captainId, int $state): ?CaptainFinancialDuesEntity
    {
        return $this->captainFinancialDuesRepository->findOneBy(["captain" => $captainId, "state" => $state]);
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

    public function getLatestCaptainFinancialDues(int $captainId): ?array
    {
        return $this->captainFinancialDuesRepository->getLatestCaptainFinancialDues($captainId);
    } 

    public function getCaptainFinancialDuesByEndDate(int $userId, DateTime $date): ?array
    {
        return $this->captainFinancialDuesRepository->getCaptainFinancialDuesByEndDate($userId, $date);
    }

    public function getFinancialDuesByCaptainId(int $captainId): array
    {
        return $this->captainFinancialDuesRepository->getFinancialDuesByCaptainId($captainId);
    }

    public function updateCaptainFinancialDuesStateToInactive(int $id): ?CaptainFinancialDuesEntity
    {
        $captainFinancialDuesEntity = $this->captainFinancialDuesRepository->find($id);
     
        if(! $captainFinancialDuesEntity) {
            return $captainFinancialDuesEntity;
        }

        $captainFinancialDuesEntity->setState(CaptainFinancialDues::FINANCIAL_STATE_INACTIVE);
      
        $this->entityManager->flush();

        return $captainFinancialDuesEntity;
    }
    
    public function getCaptainFinancialDuesByUserIDAndState(int $userId, int $state): ?CaptainFinancialDuesEntity
    {
        $captain = $this->captainManager->getCaptainProfileByUserId($userId);
  
        return $this->getCaptainFinancialDues($captain->getId(), $state);
    } 
}
