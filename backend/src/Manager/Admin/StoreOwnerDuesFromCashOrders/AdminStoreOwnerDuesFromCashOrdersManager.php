<?php

namespace App\Manager\Admin\StoreOwnerDuesFromCashOrders;

use App\Repository\StoreOwnerDuesFromCashOrdersEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersFilterGetRequest;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\StoreOwnerPaymentFromCompanyEntity;
use App\Constant\Order\OrderAmountCashConstant;

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
    
    public function updateFlagBySpecificDate(array $ids, int $flag, $storeOwnerPaymentFromCompanyEntity)
    {      
      foreach($ids as $item) {
        $storeOwnerDuesFromCashOrdersEntity = $this->storeOwnerDuesFromCashOrdersEntityRepository->find($item['id']);

        $storeOwnerDuesFromCashOrdersEntity->setFlag($flag);
        $storeOwnerDuesFromCashOrdersEntity->setStoreOwnerPaymentFromCompany($storeOwnerPaymentFromCompanyEntity);
       
        $this->entityManager->flush();
      }
    }

    public function getStoreOwnerDuesFromCashOrdersByStoreOwnerPaymentFromCompanyId(StoreOwnerPaymentFromCompanyEntity $storeOwnerPaymentFromCompany): ?array
    {                   
        $items = $this->storeOwnerDuesFromCashOrdersEntityRepository->findBy(['storeOwnerPaymentFromCompany' =>$storeOwnerPaymentFromCompany->getId()]);

        foreach($items as $storeOwnerDuesFromCashOrder) {
         
          $storeOwnerDuesFromCashOrder->setStoreOwnerPaymentFromCompany(null);
          $storeOwnerDuesFromCashOrder->setFlag(OrderAmountCashConstant::ORDER_PAID_FLAG_NO);

          $this->entityManager->flush();
        }

        return $items;
    }
    
    //Get the store's amount from the cash system according to a specific date on an unpaid condition
    public function getStoreAmountFromOrderCashBySpecificDateOnUnpaidCondition(string $fromDate, string $toDate, int $storeId): ?array
    {      
      return $this->storeOwnerDuesFromCashOrdersEntityRepository->getStoreOwnerDuesFromCashOrders($storeId, $fromDate, $toDate);
    }
}
