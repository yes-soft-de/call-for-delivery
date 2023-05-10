<?php

namespace App\Manager\Admin\StoreOwnerPayment;

use App\AutoMapping;
use App\Entity\StoreOwnerPaymentFromCompanyEntity;
use App\Repository\StoreOwnerPaymentFromCompanyEntityRepository;
use App\Request\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentFromCompanyForOrderCashCreateRequest;
use App\Service\DateFactory\DateFactoryService;
use DateTime;
use DateTimeInterface;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\Payment\PaymentConstant;
use App\Constant\Order\OrderAmountCashConstant;
use App\Manager\Admin\StoreOwnerDuesFromCashOrders\AdminStoreOwnerDuesFromCashOrdersManager;

class AdminStoreOwnerPaymentFromCompanyManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private StoreOwnerPaymentFromCompanyEntityRepository $storeOwnerPaymentFromCompanyEntityRepository,
        private StoreOwnerProfileManager $storeOwnerProfileManager,
        private AdminStoreOwnerDuesFromCashOrdersManager $adminStoreOwnerDuesFromCashOrdersManager,
        private DateFactoryService $dateFactoryService
    )
    {
    }

    public function createStoreOwnerPaymentFromCompany(AdminStoreOwnerPaymentFromCompanyForOrderCashCreateRequest $request): StoreOwnerPaymentFromCompanyEntity|string
    {
        $store = $this->storeOwnerProfileManager->getStoreOwnerProfile($request->getStore());
       
        if (! $store) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $request->setStore($store);

        $amountFromOrderCash = $this->adminStoreOwnerDuesFromCashOrdersManager->getStoreAmountFromOrderCashBySpecificDateOnUnpaidCondition($request->getFromDate(),
            $request->getToDate(), $request->getStore()->getId());
        //dd($amountFromOrderCash);
        if ($amountFromOrderCash) {
            $storeOwnerPaymentFromCompanyEntity = $this->autoMapping->map(AdminStoreOwnerPaymentFromCompanyForOrderCashCreateRequest::class,
                StoreOwnerPaymentFromCompanyEntity::class, $request);

            // save the month which the store order due belong to
            $month = $this->getDateOnlyFromStringDateTime($request->getToDate());

            $storeOwnerPaymentFromCompanyEntity->setMonth($month);

            $this->entityManager->persist($storeOwnerPaymentFromCompanyEntity);
            $this->entityManager->flush();

            // Update Flag of each store owner due record according to the due sum and payment sum of the same month
            if ($storeOwnerPaymentFromCompanyEntity) {
                if ($storeOwnerPaymentFromCompanyEntity->getId()) {
                    $isPaidFlag = $this->compareStoreDueFromCashOrdersAmountWithPaymentFromCompanyAmount($amountFromOrderCash,
                        $month, $storeOwnerPaymentFromCompanyEntity->getStore()->getId());

                    $this->adminStoreOwnerDuesFromCashOrdersManager->updateFlagBySpecificDate($amountFromOrderCash,
                        $isPaidFlag, $storeOwnerPaymentFromCompanyEntity);
                }
            }

            return $storeOwnerPaymentFromCompanyEntity;
       }
  
       return OrderAmountCashConstant::NOT_ORDER_CASH;  
    }

    public function deleteStoreOwnerPaymentFromCompany($id): StoreOwnerPaymentFromCompanyEntity|string
    {
        $storeOwnerPaymentFromCompanyEntity = $this->storeOwnerPaymentFromCompanyEntityRepository->find($id);
              
        if (! $storeOwnerPaymentFromCompanyEntity) {
            return PaymentConstant::PAYMENT_NOT_EXISTS;
        }

        // get the month of the payment in order to update Flag of the store owner due which belong to the same month
        $month = $storeOwnerPaymentFromCompanyEntity->getMonth();
        $storeOwnerProfileId = $storeOwnerPaymentFromCompanyEntity->getStore()->getId();
       
        $this->entityManager->remove($storeOwnerPaymentFromCompanyEntity);
        $this->entityManager->flush();

        $this->updateStoreOwnerDueFromCashOrderFlagByMonthAfterDeletePayment($storeOwnerProfileId,
            $this->getDateTimeObjectFromDateTimeInterface($month));
       
        return $storeOwnerPaymentFromCompanyEntity;
    }

    public function getAllStorePaymentsFromCompany(int $storeId): ?array
    {
        return $this->storeOwnerPaymentFromCompanyEntityRepository->getAllStorePaymentsFromCompany($storeId);
    }

    public function getSumPaymentsFromCompany(int $storeOwnerProfileId): ?array
    {
        return $this->storeOwnerPaymentFromCompanyEntityRepository->getSumPaymentsFromCompany($storeOwnerProfileId);
    }

//    public function updateStoreOwnerPaymentFromCompanyBySpecificAmount(StoreOwnerPaymentFromCompanyUpdateAmountByAdminRequest $request): int|StoreOwnerPaymentFromCompanyEntity
//    {
//        $storeOwnerPaymentFromCompanyEntity = $this->storeOwnerPaymentFromCompanyEntityRepository->findOneBy(['id' => $request->getId()]);
//
//        if (! $storeOwnerPaymentFromCompanyEntity) {
//            return StoreOwnerPaymentFromCompanyConstant::STORE_OWNER_PAYMENT_FROM_COMPANY_NOT_EXIST_CONST;
//        }
//
//        if ($request->getOperationType() === OrderAmountCashConstant::AMOUNT_ADDITION_TYPE_OPERATION_CONST) {
//            $storeOwnerPaymentFromCompanyEntity->setAmount($storeOwnerPaymentFromCompanyEntity->getAmount() + $request->getCashAmount());
//
//        } elseif ($request->getOperationType() === OrderAmountCashConstant::AMOUNT_SUBTRACTION_TYPE_OPERATION_CONST) {
//            $storeOwnerPaymentFromCompanyEntity->setAmount($storeOwnerPaymentFromCompanyEntity->getAmount() - $request->getCashAmount());
//        }
//
//        $this->entityManager->flush();
//
//        return $storeOwnerPaymentFromCompanyEntity;
//    }

    public function getStorePaymentFromCompanyAmountById(int $id): float
    {
        $payment = $this->storeOwnerPaymentFromCompanyEntityRepository->findOneBy(['id' => $id]);

        if ($payment) {
            return $payment->getAmount();
        }

        return 0.0;
    }

    public function compareStoreDueFromCashOrdersAmountWithPaymentFromCompanyAmount(array $storeDueArray, DateTime $month, int $storeOwnerProfileId): int
    {
        if (count($storeDueArray) === 0) {
            return OrderAmountCashConstant::ORDER_PAYMENT_BIGGER_THAN_DUE_CONST;
        }

        $dueSum = 0.0;
        $paymentAmount = 0.0;

        foreach ($storeDueArray as $singleOrderDueValue) {
            $dueSum += $singleOrderDueValue['storeAmount'];
        }

        // Get payment from company sum
        $firstDayOfMonth = clone $month;
        $firstDayOfMonth->modify('first day of this month');
        $lastDayOfMonth = clone $month;
        $lastDayOfMonth->modify('last day of this month');

        $paymentSumResult = $this->getStorePaymentFromCompanySumByMonth($storeOwnerProfileId, $firstDayOfMonth, $lastDayOfMonth);

        if (count($paymentSumResult) > 0) {
            $paymentAmount += $paymentSumResult[0];
        }

        if ($paymentAmount < $dueSum) {
            return OrderAmountCashConstant::ORDER_PAID_FLAG_PARTIALLY_CONST;

        } elseif ($paymentAmount === $dueSum) {
            return OrderAmountCashConstant::ORDER_PAID_FLAG_YES;

        } else {
            // $paymentAmount > $dueSum
            return OrderAmountCashConstant::ORDER_PAYMENT_BIGGER_THAN_DUE_CONST;
        }
    }

    public function getStorePaymentFromCompanySumByMonth(int $storeOwnerProfileId, DateTime $firstDayOfMonth, DateTime $lastDayOfMonth): array
    {
        return $this->storeOwnerPaymentFromCompanyEntityRepository->getStorePaymentFromCompanySumByMonth($storeOwnerProfileId,
            $firstDayOfMonth, $lastDayOfMonth);
    }

    public function getDateOnlyFromStringDateTime(string $dateTime): DateTime
    {
        return $this->dateFactoryService->getDateOnlyFromStringDateTime($dateTime);
    }

    public function updateStoreOwnerDueFromCashOrderFlagByMonthAfterDeletePayment(int $storeOwnerProfileId, DateTime $month)
    {
        $firstDayOfMonth = clone $month;
        $firstDayOfMonth->modify('first day of this month');
        $lastDayOfMonth = clone $month;
        $lastDayOfMonth->modify('last day of this month')->setTime(23, 59, 59);
        // Get all store owner due from cash orders which belong to the month
        // Get all payment/s sum which belong to the month
        $paymentsSum = 0.0;

        $paymentsSum = $this->getStorePaymentFromCompanySumByMonth($storeOwnerProfileId, $firstDayOfMonth, $lastDayOfMonth);

        if (count($paymentsSum) > 0) {
            $paymentsSum = $paymentsSum[0];
        }

        // Check if payment/s sum is smaller, equal, or larger than the due sum
        $this->adminStoreOwnerDuesFromCashOrdersManager->updateStoreOwnerDueFromCashOrderFlagByMonthAfterDeletePayment($storeOwnerProfileId,
            $paymentsSum, $firstDayOfMonth, $lastDayOfMonth);
    }

    public function getDateTimeObjectFromDateTimeInterface(DateTimeInterface $dateTime): DateTime
    {
        return $this->dateFactoryService->getDateTimeObjectFromDateTimeInterface($dateTime);
    }
}
