<?php

namespace App\Manager\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Repository\CaptainFinancialSystemDetailEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\CaptainFinancialSystem\CaptainFinancialSystemDetailRequest;
use App\Manager\Captain\CaptainManager;

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

    public function createCaptainFinancialSystemDetail(CaptainFinancialSystemDetailRequest $request): CaptainFinancialSystemDetailEntity
    {
        $request->setCaptain($this->captainManager->getCaptainProfileByUserId($request->getCaptain()));
       
        $captainFinancialSystemDetailEntity = $this->autoMapping->map(CaptainFinancialSystemDetailRequest::class, CaptainFinancialSystemDetailEntity::class, $request);
      
        $this->entityManager->persist($captainFinancialSystemDetailEntity);
        $this->entityManager->flush();

        return $captainFinancialSystemDetailEntity;
    }
}
