<?php

namespace App\Manager\Admin\CaptainFinancialSystem;

use App\Repository\CaptainFinancialSystemDetailEntityRepository;
use App\Manager\Captain\CaptainManager;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailUpdateRequest;
use App\AutoMapping;
use Doctrine\ORM\EntityManagerInterface;

class AdminCaptainFinancialSystemDetailManager
{
    private CaptainFinancialSystemDetailEntityRepository $captainFinancialSystemDetailEntityRepository;
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;

    public function __construct(CaptainFinancialSystemDetailEntityRepository $captainFinancialSystemDetailEntityRepository, CaptainManager $captainManager, AutoMapping $autoMapping, EntityManagerInterface $entityManager,)
    {
        $this->captainFinancialSystemDetailEntityRepository = $captainFinancialSystemDetailEntityRepository;
        $this->captainManager = $captainManager;
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
    }

    public function getCaptainFinancialSystemDetailForAdmin(int $captainId): ?array
    {      
        return $this->captainFinancialSystemDetailEntityRepository->getCaptainFinancialSystemDetailCurrent($captainId);
    }

    public function getLatestFinancialCaptainSystemDetails(int $captainId): ?array
    {      
        return $this->captainFinancialSystemDetailEntityRepository->getLatestFinancialCaptainSystemDetailsForAdmin($captainId);
    }

    public function updateStatusCaptainFinancialSystemDetail(AdminCaptainFinancialSystemDetailUpdateRequest $request): ?CaptainFinancialSystemDetailEntity
    {
        $captainFinancialSystemDetailEntity =  $this->captainFinancialSystemDetailEntityRepository->find($request->getId());
       
        if(! $captainFinancialSystemDetailEntity) {
            return $captainFinancialSystemDetailEntity;
        }
   
        $captainFinancialSystemDetailEntity = $this->autoMapping->mapToObject(AdminCaptainFinancialSystemDetailUpdateRequest::class, CaptainFinancialSystemDetailEntity::class, $request,  $captainFinancialSystemDetailEntity);

        $this->entityManager->flush();

        return $captainFinancialSystemDetailEntity;
    }
}
