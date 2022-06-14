<?php

namespace App\Manager\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemAccordingToCountOfHoursEntity;
use App\Repository\CaptainFinancialSystemAccordingToCountOfHoursEntityRepository;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursUpdateRequest;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursUpdateStatusRequest;

class AdminCaptainFinancialSystemAccordingToCountOfHoursManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private CaptainFinancialSystemAccordingToCountOfHoursEntityRepository $captainFinancialSystemAccordingToCountOfHoursEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CaptainFinancialSystemAccordingToCountOfHoursEntityRepository $captainFinancialSystemAccordingToCountOfHoursEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainFinancialSystemAccordingToCountOfHoursEntityRepository = $captainFinancialSystemAccordingToCountOfHoursEntityRepository;
    }

    public function createCaptainFinancialSystemAccordingToCountOfHours(AdminCaptainFinancialSystemAccordingToCountOfHoursCreateRequest $request): CaptainFinancialSystemAccordingToCountOfHoursEntity
    {
        $captainFinancialSystemAccordingToCountOfHoursEntity = $this->autoMapping->map(AdminCaptainFinancialSystemAccordingToCountOfHoursCreateRequest::class, CaptainFinancialSystemAccordingToCountOfHoursEntity::class, $request);
        $captainFinancialSystemAccordingToCountOfHoursEntity->setStatus(1);
        
        $this->entityManager->persist($captainFinancialSystemAccordingToCountOfHoursEntity);
        $this->entityManager->flush();

        return $captainFinancialSystemAccordingToCountOfHoursEntity;
    }

    public function getAllCaptainFinancialSystemAccordingToCountOfHours(): ?array
    {
        return $this->captainFinancialSystemAccordingToCountOfHoursEntityRepository->findAll();
    }
    
    public function updateCaptainFinancialSystemAccordingToCountOfHours(AdminCaptainFinancialSystemAccordingToCountOfHoursUpdateRequest $request): ?CaptainFinancialSystemAccordingToCountOfHoursEntity
    {
        $captainFinancialSystemAccordingToCountOfHoursEntity = $this->captainFinancialSystemAccordingToCountOfHoursEntityRepository->find($request->getId());

        if(! $captainFinancialSystemAccordingToCountOfHoursEntity) {
            
            return $captainFinancialSystemAccordingToCountOfHoursEntity;
        }
        
        $captainFinancialSystemAccordingToCountOfHoursEntity = $this->autoMapping->mapToObject(AdminCaptainFinancialSystemAccordingToCountOfHoursUpdateRequest::class, CaptainFinancialSystemAccordingToCountOfHoursEntity::class, $request, $captainFinancialSystemAccordingToCountOfHoursEntity);

        $this->entityManager->flush();

        return $captainFinancialSystemAccordingToCountOfHoursEntity;
    }
    
    public function deleteCaptainFinancialSystemAccordingToCountOfHoursByAdmin($id): ?CaptainFinancialSystemAccordingToCountOfHoursEntity
    {
        $captainFinancialSystem = $this->captainFinancialSystemAccordingToCountOfHoursEntityRepository->find($id);

        if (! $captainFinancialSystem) {     
            
            return $captainFinancialSystem;
        }
       
        $this->entityManager->remove($captainFinancialSystem);
        $this->entityManager->flush();
       
        return $captainFinancialSystem;
    }
  
    public function updateStatusCaptainFinancialSystemAccordingToCountOfHours(AdminCaptainFinancialSystemAccordingToCountOfHoursUpdateStatusRequest $request): ?CaptainFinancialSystemAccordingToCountOfHoursEntity
    {
        $captainFinancialSystemAccordingToCountOfHoursEntity = $this->captainFinancialSystemAccordingToCountOfHoursEntityRepository->find($request->getId());

        if(! $captainFinancialSystemAccordingToCountOfHoursEntity) {
            
            return $captainFinancialSystemAccordingToCountOfHoursEntity;
        }
        
        $captainFinancialSystemAccordingToCountOfHoursEntity = $this->autoMapping->mapToObject(AdminCaptainFinancialSystemAccordingToCountOfHoursUpdateStatusRequest::class, CaptainFinancialSystemAccordingToCountOfHoursEntity::class, $request, $captainFinancialSystemAccordingToCountOfHoursEntity);

        $this->entityManager->flush();

        return $captainFinancialSystemAccordingToCountOfHoursEntity;
    }
}
