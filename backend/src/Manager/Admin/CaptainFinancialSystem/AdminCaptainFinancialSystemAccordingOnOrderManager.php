<?php

namespace App\Manager\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemAccordingOnOrderEntity;
use App\Repository\CaptainFinancialSystemAccordingOnOrderEntityRepository;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingOnOrderCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingOnOrderUpdateRequest;

class AdminCaptainFinancialSystemAccordingOnOrderManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private CaptainFinancialSystemAccordingOnOrderEntityRepository $captainFinancialSystemAccordingOnOrderEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CaptainFinancialSystemAccordingOnOrderEntityRepository $captainFinancialSystemAccordingOnOrderEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->captainFinancialSystemAccordingOnOrderEntityRepository = $captainFinancialSystemAccordingOnOrderEntityRepository;
    }

    public function createCaptainFinancialSystemAccordingOnOrder(AdminCaptainFinancialSystemAccordingOnOrderCreateRequest $request): CaptainFinancialSystemAccordingOnOrderEntity
    {
        $captainFinancialSystemAccordingOnOrderEntity = $this->autoMapping->map(AdminCaptainFinancialSystemAccordingOnOrderCreateRequest::class, CaptainFinancialSystemAccordingOnOrderEntity::class, $request);

        $this->entityManager->persist($captainFinancialSystemAccordingOnOrderEntity);
        $this->entityManager->flush();

        return $captainFinancialSystemAccordingOnOrderEntity;
    }

    public function getAllCaptainFinancialSystemAccordingOnOrder(): ?array
    {
        return $this->captainFinancialSystemAccordingOnOrderEntityRepository->findAll();
    }

    public function updateCaptainFinancialSystemAccordingOnOrder(AdminCaptainFinancialSystemAccordingOnOrderUpdateRequest $request): CaptainFinancialSystemAccordingOnOrderEntity
    {
        $captainFinancialSystemAccordingOnOrderEntity = $this->captainFinancialSystemAccordingOnOrderEntityRepository->find($request->getId());
        if(! $captainFinancialSystemAccordingOnOrderEntity){
           return $captainFinancialSystemAccordingOnOrderEntity;
        }
        
        $captainFinancialSystemAccordingOnOrderEntity = $this->autoMapping->mapToObject(AdminCaptainFinancialSystemAccordingOnOrderUpdateRequest::class, CaptainFinancialSystemAccordingOnOrderEntity::class, $request,  $captainFinancialSystemAccordingOnOrderEntity);

        $this->entityManager->flush();

        return $captainFinancialSystemAccordingOnOrderEntity;
    }
}
