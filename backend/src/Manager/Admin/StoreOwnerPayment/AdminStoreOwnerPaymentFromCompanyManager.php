<?php

namespace App\Manager\Admin\StoreOwnerPayment;

use App\AutoMapping;
use App\Entity\StoreOwnerPaymentFromCompanyEntity;
use App\Repository\StoreOwnerPaymentFromCompanyEntityRepository;
use App\Request\Admin\StoreOwnerPayment\AdminStoreOwnerPaymentFromCompanyForOrderCashCreateRequest;
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
    )
    {
    }

    public function createStoreOwnerPaymentFromCompany(AdminStoreOwnerPaymentFromCompanyForOrderCashCreateRequest $request): StoreOwnerPaymentFromCompanyEntity|string
    {
        $store = $this->storeOwnerProfileManager->getStoreOwnerProfile($request->getStore());
       
        if(! $store) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $request->setStore($store);

        $amountFromOrderCash = $this->adminStoreOwnerDuesFromCashOrdersManager->getStoreAmountFromOrderCashBySpecificDateOnUnpaidCondition($request->getFromDate(), $request->getToDate(), $request->getStore()->getId());
        //dd($amountFromOrderCash);
        if($amountFromOrderCash) {
            $storeDueFromCashOrderIDs = [];

            $storeOwnerPaymentFromCompanyEntity = $this->autoMapping->map(AdminStoreOwnerPaymentFromCompanyForOrderCashCreateRequest::class,
                StoreOwnerPaymentFromCompanyEntity::class, $request);

            // save store due from cash orders IDs in toreDueFromCashOrder filed
            foreach ($amountFromOrderCash as $storeDueFromCashOrder) {
                $storeDueFromCashOrderIDs = $storeOwnerPaymentFromCompanyEntity->getStoreDueFromCashOrder();
                $storeDueFromCashOrderIDs[] = $storeDueFromCashOrder['id'];
            }

            $storeOwnerPaymentFromCompanyEntity->setStoreDueFromCashOrder($storeDueFromCashOrderIDs);

            $this->entityManager->persist($storeOwnerPaymentFromCompanyEntity);
            $this->entityManager->flush();

            $isPaidFlag = $this->compareStoreDueFromCashOrdersAmountWithPaymentFromCompanyAmount($amountFromOrderCash,
                $storeOwnerPaymentFromCompanyEntity->getAmount());

            $this->adminStoreOwnerDuesFromCashOrdersManager->updateFlagBySpecificDate($amountFromOrderCash,
                $isPaidFlag, $storeOwnerPaymentFromCompanyEntity);

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
       
        $this->entityManager->remove($storeOwnerPaymentFromCompanyEntity);
        $this->entityManager->flush();

        //$this->adminStoreOwnerDuesFromCashOrdersManager->getStoreOwnerDuesFromCashOrdersByStoreOwnerPaymentFromCompanyId($storeOwnerPaymentFromCompanyEntity);
       
        return $storeOwnerPaymentFromCompanyEntity;
    }

    public function getAllStorePaymentsFromCompany(int $storeId): ?array
    {
        return $this->storeOwnerPaymentFromCompanyEntityRepository->getAllStorePaymentsFromCompany($storeId);
    }

    public function getSumPaymentsFromCompany(int $storeId): ?array
    {
        return $this->storeOwnerPaymentFromCompanyEntityRepository->getSumPaymentsFromCompany($storeId);
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

    public function compareStoreDueFromCashOrdersAmountWithPaymentFromCompanyAmount(array $storeDueArray, float $paymentAmount): int
    {
        if (count($storeDueArray) === 0) {
            return OrderAmountCashConstant::ORDER_PAYMENT_BIGGER_THAN_DUE_CONST;
        }

        $dueSum = 0.0;

        foreach ($storeDueArray as $singleOrderDueValue) {
            $dueSum += $singleOrderDueValue['storeAmount'];
            // check if there is previous payment/s
            if ($singleOrderDueValue['paymentsFromCompany']) {
                if (count($singleOrderDueValue['paymentsFromCompany']) > 0) {
                    foreach ($singleOrderDueValue['paymentsFromCompany'] as $paymentId) {
                        $paymentAmount += $this->getStorePaymentFromCompanyAmountById($paymentId);
                    }
                }
            }
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
}
