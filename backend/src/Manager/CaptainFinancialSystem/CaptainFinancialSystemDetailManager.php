<?php

namespace App\Manager\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Repository\CaptainFinancialSystemDetailEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\CaptainFinancialSystem\CaptainFinancialSystemDetailRequest;
use App\Manager\Captain\CaptainManager;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;

class CaptainFinancialSystemDetailManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private CaptainFinancialSystemDetailEntityRepository $captainFinancialSystemDetailEntityRepository;
    private CaptainManager $captainManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CaptainFinancialSystemDetailEntityRepository $captainFinancialSystemDetailEntityRepository, CaptainManager $captainManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainFinancialSystemDetailEntityRepository = $captainFinancialSystemDetailEntityRepository;
        $this->captainManager = $captainManager;
    }

    public function createCaptainFinancialSystemDetail(CaptainFinancialSystemDetailRequest $request): CaptainFinancialSystemDetailEntity|string
    {
        $request->setCaptain($this->captainManager->getCaptainProfileByUserId($request->getCaptain()));

        $captainFinancialSystemDetailEntity = $this->captainFinancialSystemDetailEntityRepository->findOneBy(["captain" => $request->getCaptain()]);
        
        if($captainFinancialSystemDetailEntity) {
            return CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE;
        }
       
        $captainFinancialSystemDetailEntity = $this->autoMapping->map(CaptainFinancialSystemDetailRequest::class, CaptainFinancialSystemDetailEntity::class, $request);
      
        $captainFinancialSystemDetailEntity->setStatus(CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_INACTIVE);
        $this->entityManager->persist($captainFinancialSystemDetailEntity);
        $this->entityManager->flush();

        return $captainFinancialSystemDetailEntity;
    }

    public function getCaptainFinancialSystemDetailCurrent(int $userId): ?array
    {
        $captainId = $this->captainManager->getCaptainProfileByUserId($userId)->getId();
      
        $financialSystemDetail = $this->captainFinancialSystemDetailEntityRepository->getCaptainFinancialSystemDetailCurrent($captainId);
        
        if($financialSystemDetail) {
            $financialSystemDetail['captainId'] = $captainId;
        }
      
        return $financialSystemDetail;
    }

    public function getCaptainFinancialSystemDetailForAdmin(int $captainId): ?array
    {      
        return $this->captainFinancialSystemDetailEntityRepository->getCaptainFinancialSystemDetailCurrent($captainId);
    }
}
