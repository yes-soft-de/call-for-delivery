<?php

namespace App\Manager\CaptainAmountFromOrderCash;

use App\AutoMapping;
use App\Entity\CaptainAmountFromOrderCashEntity;
use App\Repository\CaptainAmountFromOrderCashEntityRepository;
use App\Request\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashRequest;
use Doctrine\ORM\EntityManagerInterface;

class CaptainAmountFromOrderCashManager
{
    private AutoMapping $autoMapping;
    private CaptainAmountFromOrderCashEntityRepository $captainAmountFromOrderCashEntityRepository;
    private EntityManagerInterface $entityManager;

    public function __construct(AutoMapping $autoMapping, CaptainAmountFromOrderCashEntityRepository $captainAmountFromOrderCashEntityRepository, EntityManagerInterface $entityManager)
    {
        $this->captainAmountFromOrderCashEntityRepository = $captainAmountFromOrderCashEntityRepository;
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
    }

    public function createCaptainAmountFromOrderCash(CaptainAmountFromOrderCashRequest $request): ?CaptainAmountFromOrderCashEntity
    {       
        $captainAmountFromOrderCashEntity = $this->autoMapping->map(CaptainAmountFromOrderCashRequest::class, CaptainAmountFromOrderCashEntity::class, $request);

        $this->entityManager->persist($captainAmountFromOrderCashEntity);
        $this->entityManager->flush();

        return $captainAmountFromOrderCashEntity;
    }

    public function updateCaptainAmountFromOrderCash(CaptainAmountFromOrderCashEntity $captainAmountFromOrderCashEntity): ?CaptainAmountFromOrderCashEntity
    {       
        $this->entityManager->flush();

        return $captainAmountFromOrderCashEntity;
    }

    public function getCaptainAmountFromOrderCashByOrderId($orderId): ?CaptainAmountFromOrderCashEntity
    {       
        return $this->captainAmountFromOrderCashEntityRepository->findOneBy(["orderId" => $orderId]);
    }
}
