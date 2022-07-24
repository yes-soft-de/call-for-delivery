<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Order\OrderTypeConstant;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemOneBalanceDetailManager;

class CaptainFinancialSystemOneBalanceDetailService
{
    private AutoMapping $autoMapping;
    private CaptainFinancialSystemOneBalanceDetailManager $captainFinancialSystemOneBalanceDetailManager;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemOneBalanceDetailManager $captainFinancialSystemOneBalanceDetailManager)
    {
        $this->autoMapping = $autoMapping;
        $this->captainFinancialSystemOneBalanceDetailManager = $captainFinancialSystemOneBalanceDetailManager;
    }

    public function getBalanceDetailWithSystemOne(array $financialSystemDetail, int $captainId, float $sumPayments, array $date, int $countWorkdays): CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse
    {
        $countOrdersMaxFromNineteen = 0;
        //get Count Orders
        //The amount received by the captain in cash from the orders, this amount will be handed over to the admin
        $amountForStore = 0;
      
        $countOrders = $this->captainFinancialSystemOneBalanceDetailManager->getCountOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);

        //get Orders Details On Specific Date
        $detailsOrders = $this->captainFinancialSystemOneBalanceDetailManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);

        foreach($detailsOrders as $detailOrder) {
           if($detailOrder['kilometer'] > CaptainFinancialSystem::KILOMETER_TO_DOUBLE_ORDER ) {
                $countOrdersMaxFromNineteen = $countOrdersMaxFromNineteen + 1;
           }

           if($detailOrder['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH && $detailOrder['paidToProvider'] === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
            $amountForStore += $detailOrder['captainOrderCost'];
           }
        }
 
        $financialSystemDetail['financialDues'] = $this->financialDuesCalculator($countWorkdays, $countOrders['countOrder'], $countOrdersMaxFromNineteen, $financialSystemDetail['compensationForEveryOrder'], $financialSystemDetail['salary']);
     
        $financialSystemDetail['sumPayments'] = $sumPayments;
             
        $financialSystemDetail['countOrders'] = $countOrders['countOrder'];

        $financialSystemDetail['countOrdersMaxFromNineteen'] = $countOrdersMaxFromNineteen;

        $total = $financialSystemDetail['financialDues'] - $sumPayments;
        
        $financialSystemDetail['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;
        
        if($total <= 0 ) {
            $financialSystemDetail['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $financialSystemDetail['total'] = abs($total);

        $financialSystemDetail['amountForStore'] = $amountForStore;

        return $this->autoMapping->map('array', CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse::class, $financialSystemDetail);
    }

    public function getFinancialDuesWithSystemOne(array $financialSystemDetail, int $captainId, array $date, int $countWorkdays): array
    {
        $countOrdersMaxFromNineteen = 0;
        //get Count Orders
        //The amount received by the captain in cash from the orders, this amount will be handed over to the admin
        $amountForStore = 0;
      
        $countOrders = $this->captainFinancialSystemOneBalanceDetailManager->getCountOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);
   
        //get Orders Details On Specific Date
        $detailsOrders = $this->captainFinancialSystemOneBalanceDetailManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);

        foreach($detailsOrders as $detailOrder) {
           if($detailOrder['kilometer'] > CaptainFinancialSystem::KILOMETER_TO_DOUBLE_ORDER ) {
                $countOrdersMaxFromNineteen = $countOrdersMaxFromNineteen + 1;
           }

           if($detailOrder['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH && $detailOrder['paidToProvider'] === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
            $amountForStore += $detailOrder['captainOrderCost'];
           }
        }

        $financialSystemDetail['financialDues'] = $this->financialDuesCalculator($countWorkdays, $countOrders['countOrder'], $countOrdersMaxFromNineteen, $financialSystemDetail['compensationForEveryOrder'], $financialSystemDetail['salary']);
     
        $financialSystemDetail['amountForStore'] = $amountForStore;

        return $financialSystemDetail;
    }
    //If the captain works 25 days he gets the monthly salary, if he works less than 25 days the captain gets the daily salary
    public function financialDuesCalculator(int $countWorkdays, int $countOrdersCompleted, int $countOrdersMaxFromNineteen, float $compensationForEveryOrder, float $salary)
    {
         if($countWorkdays >= 25){
             
            return round((($countOrdersCompleted + $countOrdersMaxFromNineteen) * $compensationForEveryOrder ) + $salary, 2);
         }

         $dailySalary = $salary / 30;
         return round((($countOrdersCompleted + $countOrdersMaxFromNineteen) * $compensationForEveryOrder ) + $dailySalary, 2);
    }
}
