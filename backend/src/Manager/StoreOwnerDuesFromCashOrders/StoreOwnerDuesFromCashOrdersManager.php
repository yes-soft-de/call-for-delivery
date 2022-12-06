<?php

namespace App\Manager\StoreOwnerDuesFromCashOrders;

use App\AutoMapping;
use App\Entity\StoreOwnerDuesFromCashOrdersEntity;
use App\Repository\StoreOwnerDuesFromCashOrdersEntityRepository;
use App\Request\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersRequest;
use Doctrine\ORM\EntityManagerInterface;

class StoreOwnerDuesFromCashOrdersManager
{
    private AutoMapping $autoMapping;
    private StoreOwnerDuesFromCashOrdersEntityRepository $storeOwnerDuesFromCashOrdersEntityRepository;
    private EntityManagerInterface $entityManager;

    public function __construct(AutoMapping $autoMapping, StoreOwnerDuesFromCashOrdersEntityRepository $storeOwnerDuesFromCashOrdersEntityRepository, EntityManagerInterface $entityManager)
    {
        $this->storeOwnerDuesFromCashOrdersEntityRepository = $storeOwnerDuesFromCashOrdersEntityRepository;
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
    }

    public function createStoreOwnerDuesFromCashOrders(StoreOwnerDuesFromCashOrdersRequest $request): ?StoreOwnerDuesFromCashOrdersEntity
    {       
        $storeOwnerDuesFromCashOrdersEntity = $this->autoMapping->map(StoreOwnerDuesFromCashOrdersRequest::class, StoreOwnerDuesFromCashOrdersEntity::class, $request);

        $this->entityManager->persist($storeOwnerDuesFromCashOrdersEntity);
        $this->entityManager->flush();

        return $storeOwnerDuesFromCashOrdersEntity;
    }

    public function updateStoreOwnerDuesFromCashOrders(StoreOwnerDuesFromCashOrdersEntity $storeOwnerDuesFromCashOrdersEntity): ?StoreOwnerDuesFromCashOrdersEntity
    {       
        $this->entityManager->flush();

        return $storeOwnerDuesFromCashOrdersEntity;
    }

    public function getStoreOwnerDuesFromCashOrdersByOrderId($orderId): ?StoreOwnerDuesFromCashOrdersEntity
    {       
        return $this->storeOwnerDuesFromCashOrdersEntityRepository->findOneBy(["orderId" => $orderId]);
    }

    public function getStoreOwnerDuesFromCashOrdersByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->storeOwnerDuesFromCashOrdersEntityRepository->getStoreOwnerDuesFromCashOrdersByStoreOwnerId($storeOwnerId);
    }

    // Get the dues of unpaid cash orders (for group of orders)
    public function getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->storeOwnerDuesFromCashOrdersEntityRepository->getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime($captainId, $fromDate, $toDate);
    }
}
