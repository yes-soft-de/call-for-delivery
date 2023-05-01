<?php

namespace App\Manager\Admin\StoreOwnerDuesFromCashOrders;

use App\Repository\StoreOwnerDuesFromCashOrdersEntityRepository;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreDueSumFromCashOrderFilterByAdminRequest;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrderDeleteByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersFilterGetRequest;
use App\Entity\StoreOwnerPaymentFromCompanyEntity;
use App\Constant\Order\OrderAmountCashConstant;

class AdminStoreOwnerDuesFromCashOrdersManager
{
    public function __construct(
        private StoreOwnerDuesFromCashOrdersEntityRepository $storeOwnerDuesFromCashOrdersEntityRepository,
        private EntityManagerInterface $entityManager
    )
    {
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

    public function deleteStoreOwnerDuesFromCashOrderByAdmin(StoreOwnerDuesFromCashOrderDeleteByAdminRequest $request): array|int
    {
        $storeDuesFromCashOrder = $this->storeOwnerDuesFromCashOrdersEntityRepository->findOneBy(['store' => $request->getStoreOwnerProfileId(),
            'orderId' => $request->getOrderId()]);

        if (! $storeDuesFromCashOrder) {
            return OrderAmountCashConstant::STORE_DUES_FROM_CASH_ORDER_NOT_EXIST_CONST;
        }

        $payment = $storeDuesFromCashOrder->getStoreOwnerPaymentFromCompany();

        $storeDuesFromCashOrder->setStoreOwnerPaymentFromCompany(null);

        $this->entityManager->remove($storeDuesFromCashOrder);
        $this->entityManager->flush();

        return [$storeDuesFromCashOrder, $payment];
    }

    /**
     * Get all stores due sum from cash orders depending on filtering options
     */
    public function filterStoreDueFromCashOrdersByAdmin(StoreDueSumFromCashOrderFilterByAdminRequest $request): array
    {
        return $this->storeOwnerDuesFromCashOrdersEntityRepository->filterStoreDueFromCashOrdersByAdmin($request);
    }

    /**
     * Get the sum of a specific store due and depending on paid flag
     */
    public function getStoreOwnerDueSumFromCashOrderByIsPaidFlagAndStoreOwnerProfileId(int $storeOwnerProfileId, int $isPaid = null): array
    {
        return $this->storeOwnerDuesFromCashOrdersEntityRepository->getStoreOwnerDueSumFromCashOrderByIsPaidFlagAndStoreOwnerProfileId($storeOwnerProfileId,
            $isPaid);
    }
}
