<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Constant\Order\OrderAmountCashConstant;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialDuesManager;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialDuesResponse;
use App\Service\CaptainPayment\CaptainPaymentService;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Entity\CaptainFinancialDuesEntity;

class AdminCaptainFinancialDuesService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminCaptainFinancialDuesManager $adminCaptainFinancialDuesManager,
        private CaptainPaymentService $captainPaymentService
    )
    {
    }

    public function getCaptainFinancialDues(int $captainId): array
    {        
        $response = [];

        $captainFinancialDues = $this->adminCaptainFinancialDuesManager->getCaptainFinancialDuesByCaptainId($captainId);

        foreach ($captainFinancialDues as $captainFinancialDue) {
           
            $captainFinancialDue['amount'] = round($captainFinancialDue['amount'], 2); 
            $captainFinancialDue['paymentsToCaptain'] = $this->captainPaymentService->getPaymentsByCaptainFinancialDues($captainFinancialDue['id']);
          
            $captainFinancialDue['total'] = $this->getCaptainFinancialTotal($captainFinancialDue['id']);

            $response[] = $this->autoMapping->map('array', AdminCaptainFinancialDuesResponse::class, $captainFinancialDue);
        }

        return $response;
    }

    public function getCaptainFinancialTotal(int $captainFinancialDueId): array
    {
        $captainFinancialDues = [];
        
        $sumCaptainFinancialDues = $this->adminCaptainFinancialDuesManager->getSumCaptainFinancialDuesById($captainFinancialDueId);
        
        $sumPaymentsToCaptain = $this->captainPaymentService->getSumPaymentsToCaptainByCaptainFinancialDuesId($captainFinancialDueId);
   
        $total = $sumPaymentsToCaptain['sumPaymentsToCaptain'] - $sumCaptainFinancialDues['sumCaptainFinancialDues'];
       
        $captainFinancialDues['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_BALANCE_CONST;
    
        if($total <= 0 ) {
            $captainFinancialDues['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_EXIST_CONST;
        }

        $captainFinancialDues['sumCaptainFinancialDues'] =  round($sumCaptainFinancialDues['sumCaptainFinancialDues'], 2);
        $captainFinancialDues['sumPaymentsToCaptain'] = $sumPaymentsToCaptain['sumPaymentsToCaptain'];
        $captainFinancialDues['total'] = abs(round($total, 2));

        return $captainFinancialDues;
    }

    public function updateCaptainFinancialDuesStatus(CaptainFinancialDuesEntity $captainFinancialDue, int $status)
    {
        return $this->adminCaptainFinancialDuesManager->updateCaptainFinancialDuesStatus($captainFinancialDue, $status); 
    }

    public function stateToActive()
    {
        return $this->adminCaptainFinancialDuesManager->stateToActive(); 
    }

    public function getCaptainFinancialDueByCaptainProfileIdAndOrderCreationDate(int $captainProfileId, \DateTimeInterface $orderCreationDate): int|CaptainFinancialDuesEntity
    {
        $captainFinancialDue = $this->adminCaptainFinancialDuesManager->getCaptainFinancialDueByCaptainProfileIdAndOrderCreationDate($captainProfileId,
            $orderCreationDate);

        if (count($captainFinancialDue) === 0) {
            return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
        }

        return $captainFinancialDue[0];
    }

    public function subtractValueFromCaptainFinancialDueAmountForStore(CaptainFinancialDuesEntity $captainFinancialDuesEntity, float $value): CaptainFinancialDuesEntity
    {
        return $this->adminCaptainFinancialDuesManager->subtractValueFromCaptainFinancialDueAmountForStore($captainFinancialDuesEntity,
            $value);
    }

    public function handleSubtractingValueFromCaptainFinancialDueAmountForStore(float $value, int $captainProfileId, \DateTimeInterface $orderCreatedAt): CaptainFinancialDuesEntity|int
    {
        // 1 Get captain financial due which order belongs to
        $captainFinancialDue = $this->getCaptainFinancialDueByCaptainProfileIdAndOrderCreationDate($captainProfileId,
            $orderCreatedAt);

        if ($captainFinancialDue === CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
            return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
        }

        // Update amountForStore field by subtracting "value" from it
        return $this->subtractValueFromCaptainFinancialDueAmountForStore($captainFinancialDue, $value);
    }

    /**
     * Updates amountForStore field of Captain Financial Due according to group of Captain Amount from Cash Orders
     */
    public function updateCaptainFinancialDueAmountForStoreByGroupOfCaptainAmountFromCashOrder(array $captainAmountFromCashOrders)
    {
        foreach ($captainAmountFromCashOrders as $captainAmountFromCashOrderEntity) {
            // Subtract amount field of the related captain financial daily, depending on captain and order creation date
            // and only if the amount is paid from captain to admin
            if (($captainAmountFromCashOrderEntity->getFlag() === OrderAmountCashConstant::ORDER_PAID_FLAG_YES)
                && ($captainAmountFromCashOrderEntity->getEditingByCaptain() === false)) {
                $this->handleSubtractingValueFromCaptainFinancialDueAmountForStore($captainAmountFromCashOrderEntity->getAmount(),
                    $captainAmountFromCashOrderEntity->getCaptain()->getId(), $captainAmountFromCashOrderEntity->getOrderId()->getCreatedAt());
            }
        }
    }
}
