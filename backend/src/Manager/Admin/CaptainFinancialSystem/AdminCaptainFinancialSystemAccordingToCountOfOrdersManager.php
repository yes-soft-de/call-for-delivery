<?php

namespace App\Manager\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemAccordingToCountOfOrdersEntity;
use App\Repository\CaptainFinancialSystemAccordingToCountOfOrdersEntityRepository;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersUpdateRequest;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersUpdateStatusRequest;

class AdminCaptainFinancialSystemAccordingToCountOfOrdersManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private CaptainFinancialSystemAccordingToCountOfOrdersEntityRepository $captainFinancialSystemAccordingToCountOfOrdersEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CaptainFinancialSystemAccordingToCountOfOrdersEntityRepository $captainFinancialSystemAccordingToCountOfOrdersEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainFinancialSystemAccordingToCountOfOrdersEntityRepository = $captainFinancialSystemAccordingToCountOfOrdersEntityRepository;
    }

    public function createCaptainFinancialSystemAccordingToCountOfOrders(AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateRequest $request): CaptainFinancialSystemAccordingToCountOfOrdersEntity
    {
        $captainFinancialSystemAccordingToCountOfOrdersEntity = $this->autoMapping->map(AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateRequest::class, CaptainFinancialSystemAccordingToCountOfOrdersEntity::class, $request);
        $captainFinancialSystemAccordingToCountOfOrdersEntity->setStatus(1);
        
        $this->entityManager->persist($captainFinancialSystemAccordingToCountOfOrdersEntity);
        $this->entityManager->flush();

        return $captainFinancialSystemAccordingToCountOfOrdersEntity;
    }

    public function getAllCaptainFinancialSystemAccordingToCountOfOrders(): ?array
    {
        return $this->captainFinancialSystemAccordingToCountOfOrdersEntityRepository->findAll();
    }
    
    public function updateCaptainFinancialSystemAccordingToCountOfOrders(AdminCaptainFinancialSystemAccordingToCountOfOrdersUpdateRequest $request): ?CaptainFinancialSystemAccordingToCountOfOrdersEntity
    {
        $captainFinancialSystemAccordingToCountOfOrdersEntity =  $this->captainFinancialSystemAccordingToCountOfOrdersEntityRepository->find($request->getId());
       
        if(! $captainFinancialSystemAccordingToCountOfOrdersEntity) {
            return $captainFinancialSystemAccordingToCountOfOrdersEntity;
        }

        $captainFinancialSystemAccordingToCountOfOrdersEntity = $this->autoMapping->mapToObject(AdminCaptainFinancialSystemAccordingToCountOfOrdersUpdateRequest::class, CaptainFinancialSystemAccordingToCountOfOrdersEntity::class, $request,  $captainFinancialSystemAccordingToCountOfOrdersEntity);

        $this->entityManager->flush();

        return $captainFinancialSystemAccordingToCountOfOrdersEntity;
    }
    
    public function deleteCaptainFinancialSystemAccordingToCountOfOrdersByAdmin($id): ?CaptainFinancialSystemAccordingToCountOfOrdersEntity
    {
        $captainFinancialSystem = $this->captainFinancialSystemAccordingToCountOfOrdersEntityRepository->find($id);

        if (! $captainFinancialSystem) {     
            
            return $captainFinancialSystem;
        }
       
        $this->entityManager->remove($captainFinancialSystem);
        $this->entityManager->flush();
       
        return $captainFinancialSystem;
    }
    
    public function updateStatusCaptainFinancialSystemAccordingToCountOfOrders(AdminCaptainFinancialSystemAccordingToCountOfOrdersUpdateStatusRequest $request): ?CaptainFinancialSystemAccordingToCountOfOrdersEntity
    {
        $captainFinancialSystemAccordingToCountOfOrdersEntity =  $this->captainFinancialSystemAccordingToCountOfOrdersEntityRepository->find($request->getId());
       
        if(! $captainFinancialSystemAccordingToCountOfOrdersEntity) {
            return $captainFinancialSystemAccordingToCountOfOrdersEntity;
        }

        $captainFinancialSystemAccordingToCountOfOrdersEntity = $this->autoMapping->mapToObject(AdminCaptainFinancialSystemAccordingToCountOfOrdersUpdateStatusRequest::class, CaptainFinancialSystemAccordingToCountOfOrdersEntity::class, $request,  $captainFinancialSystemAccordingToCountOfOrdersEntity);

        $this->entityManager->flush();

        return $captainFinancialSystemAccordingToCountOfOrdersEntity;
    }
}
