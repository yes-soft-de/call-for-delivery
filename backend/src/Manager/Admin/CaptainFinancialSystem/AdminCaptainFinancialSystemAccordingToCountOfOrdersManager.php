<?php

namespace App\Manager\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemAccordingToCountOfOrdersEntity;
use App\Repository\CaptainFinancialSystemAccordingToCountOfOrdersEntityRepository;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

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

        $this->entityManager->persist($captainFinancialSystemAccordingToCountOfOrdersEntity);
        $this->entityManager->flush();

        return $captainFinancialSystemAccordingToCountOfOrdersEntity;
    }

    public function getAllCaptainFinancialSystemAccordingToCountOfOrders(): ?array
    {
        return $this->captainFinancialSystemAccordingToCountOfOrdersEntityRepository->findAll();
    }
}
