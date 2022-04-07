<?php

namespace App\Manager\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemAccordingOnOrderEntity;
use App\Repository\CaptainFinancialSystemAccordingOnOrderEntityRepository;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingOnOrderCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

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
}
