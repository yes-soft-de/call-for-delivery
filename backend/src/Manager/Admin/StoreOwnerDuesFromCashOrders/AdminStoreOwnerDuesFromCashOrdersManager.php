<?php

namespace App\Manager\Admin\StoreOwnerDuesFromCashOrders;

use App\Repository\StoreOwnerDuesFromCashOrdersEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersFilterGetRequest;
use App\Entity\StoreOwnerProfileEntity;

class AdminStoreOwnerDuesFromCashOrdersManager
{
    private StoreOwnerDuesFromCashOrdersEntityRepository $storeOwnerDuesFromCashOrdersEntityRepository;
    private EntityManagerInterface $entityManager;

    public function __construct(StoreOwnerDuesFromCashOrdersEntityRepository $storeOwnerDuesFromCashOrdersEntityRepository, EntityManagerInterface $entityManager)
    {
        $this->storeOwnerDuesFromCashOrdersEntityRepository = $storeOwnerDuesFromCashOrdersEntityRepository;
        $this->entityManager = $entityManager;
    }

    public function filterStoreOwnerDuesFromCashOrders(StoreOwnerDuesFromCashOrdersFilterGetRequest $request): ?array
    {       
        return $this->storeOwnerDuesFromCashOrdersEntityRepository->filterStoreOwnerDuesFromCashOrders($request->getStoreId(), $request->getFromDate(), $request->getToDate());
    }
    
    public function updateFlagBySpecificDate(string $fromDate, string $toDate, int $flag, StoreOwnerProfileEntity $storeOwnerProfile)
    {      
      $items = $this->storeOwnerDuesFromCashOrdersEntityRepository->getStoreOwnerDuesFromCashOrders($storeOwnerProfile->getId(), $fromDate, $toDate);
     
      foreach($items as $item) {
        $storeOwnerDuesFromCashOrdersEntity = $this->storeOwnerDuesFromCashOrdersEntityRepository->find($item['id']);

        $storeOwnerDuesFromCashOrdersEntity->setFlag($flag);
       
        $this->entityManager->flush();
      }
    }
}
