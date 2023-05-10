<?php

namespace App\Manager\Admin\StoreOwnerDuesFromCashOrders;

use App\Repository\StoreOwnerDuesFromCashOrdersEntityRepository;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreDueSumFromCashOrderFilterByAdminRequest;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDueFromCashOrderFilterByAdminRequest;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrderDeleteByAdminRequest;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersFilterGetRequest;
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
        return $this->storeOwnerDuesFromCashOrdersEntityRepository->filterStoreOwnerDuesFromCashOrders($request->getStoreId(),
            $request->getFromDate(), $request->getToDate());
    }
    
    public function updateFlagBySpecificDate(array $ids, int $flag, $storeOwnerPaymentFromCompanyEntity)
    {
        foreach ($ids as $item) {
            $storeOwnerDuesFromCashOrdersEntity = $this->storeOwnerDuesFromCashOrdersEntityRepository->find($item['id']);

            $storeOwnerDuesFromCashOrdersEntity->setFlag($flag);

            $this->entityManager->flush();
        }
    }

//    public function getStoreOwnerDuesFromCashOrdersByStoreOwnerPaymentFromCompanyId(int $paymentId): ?array
//    {
//        // $items = $this->storeOwnerDuesFromCashOrdersEntityRepository->findBy(['storeOwnerPaymentFromCompany' =>$storeOwnerPaymentFromCompany->getId()]);
//        $items = $this->storeOwnerDuesFromCashOrdersEntityRepository->getStoreOwnerDueFromCashOrderByStorePaymentFromCompanyId($paymentId);
//
//        if (count($items) > 0) {
//            foreach ($items as $storeOwnerDuesFromCashOrder) {
//
//                $this->entityManager->flush();
//            }
//        }
//
//        return $items;
//    }
    
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

        $this->entityManager->remove($storeDuesFromCashOrder);
        $this->entityManager->flush();

        return [$storeDuesFromCashOrder];
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

    /**
     * Filter all store owners due from cash orders by admin
     */
    public function filterStoreOwnerDueFromCashOrderByAdmin(StoreOwnerDueFromCashOrderFilterByAdminRequest $request): array
    {
        return $this->storeOwnerDuesFromCashOrdersEntityRepository->filterStoreOwnerDueFromCashOrderByAdmin($request);
    }

    /**
     * Get the sum of a specific store due and depending on dates
     */
    public function getStoreOwnerDueSumFromCashOrderByStoreOwnerProfileIdAndTwoDates(int $storeOwnerProfileId, DateTime $firstDayOfMonth, DateTime $lastDayOfMonth): array
    {
        return $this->storeOwnerDuesFromCashOrdersEntityRepository->getStoreOwnerDueSumFromCashOrderByStoreOwnerProfileIdAndTwoDates($storeOwnerProfileId,
            $firstDayOfMonth, $lastDayOfMonth);
    }

    public function updateStoreOwnerDueFromCashOrderFlagByMonthAfterDeletePayment(int $storeOwnerProfileId, float $paymentSum, DateTime $firstDayOfMonth, DateTime $lastDayOfMonth)
    {
        // Check if payment/s sum is smaller, equal, or larger than the due sum
        $dueSum = 0.0;

        $dueSumArrayResult = $this->getStoreOwnerDueSumFromCashOrderByStoreOwnerProfileIdAndTwoDates($storeOwnerProfileId,
            $firstDayOfMonth,$lastDayOfMonth);

        if (count($dueSumArrayResult) > 0) {
            $dueSum = (float) $dueSumArrayResult[0];
        }

        if ($paymentSum < $dueSum) {
            $isPaidFlag = OrderAmountCashConstant::ORDER_PAID_FLAG_PARTIALLY_CONST;

        } elseif ($paymentSum === $dueSum) {
            $isPaidFlag = OrderAmountCashConstant::ORDER_PAID_FLAG_YES;

        } else {
            // $paymentAmount > $dueSum
            $isPaidFlag = OrderAmountCashConstant::ORDER_PAYMENT_BIGGER_THAN_DUE_CONST;
        }

        $this->updateStoreOwnerDueFromCashOrderFlagBySpecificDate($storeOwnerProfileId, $isPaidFlag, $firstDayOfMonth,
            $lastDayOfMonth);
    }

    public function updateStoreOwnerDueFromCashOrderFlagBySpecificDate(int $storeOwnerProfileId, int $flag, DateTime $firstDayOfMonth, DateTime $lastDayOfMonth): array
    {
        $storeOwnerDueFromCashOrderArrayResult = $this->storeOwnerDuesFromCashOrdersEntityRepository->getStoreOwnerDueFromCashOrderByStoreOwnerProfileIdAndTwoDates($storeOwnerProfileId,
            $firstDayOfMonth, $lastDayOfMonth);

        if (count($storeOwnerDueFromCashOrderArrayResult) > 0) {
            foreach ($storeOwnerDueFromCashOrderArrayResult as $item) {
                $item->setFlag($flag);

                $this->entityManager->flush();
            }
        }

        return $storeOwnerDueFromCashOrderArrayResult;
    }
}
