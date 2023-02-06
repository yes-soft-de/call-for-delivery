<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Order\OrderTypeConstant;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemOneBalanceDetailManager;
use App\Constant\GeoDistance\GeoDistanceResultConstant;

class AdminCaptainFinancialSystemOneBalanceDetailService
{
    private AutoMapping $autoMapping;
    private AdminCaptainFinancialSystemOneBalanceDetailManager $adminCaptainFinancialSystemOneBalanceDetailManager;

    public function __construct(AutoMapping $autoMapping, AdminCaptainFinancialSystemOneBalanceDetailManager $adminCaptainFinancialSystemOneBalanceDetailManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminCaptainFinancialSystemOneBalanceDetailManager = $adminCaptainFinancialSystemOneBalanceDetailManager;
    }

    public function getBalanceDetailWithSystemOne(array $financialSystemDetail, int $captainId, float $sumPayments, array $date, int $countWorkdays): AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse
    {
        $countOrdersMaxFromNineteen = 0;
        //The amount received by the captain in cash from the orders, this amount will be handed over to the admin
        $amountForStore = 0;
        $countOrdersWithoutDistance = 0;
        //get Count Orders On Specific Date
        $countOrders = $this->adminCaptainFinancialSystemOneBalanceDetailManager->getCountOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);
        //get Orders Details On Specific Date
        $detailsOrders = $this->adminCaptainFinancialSystemOneBalanceDetailManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);
        //get Orders Details On Specific Date
        $orders = $this->adminCaptainFinancialSystemOneBalanceDetailManager->getOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);

        foreach($detailsOrders as $detailOrder) {
           if($detailOrder['storeBranchToClientDistance'] >= CaptainFinancialSystem::KILOMETER_TO_DOUBLE_ORDER ) {
                $countOrdersMaxFromNineteen = $countOrdersMaxFromNineteen + 1;
           }
          
           if($detailOrder['storeBranchToClientDistance'] === null || $detailOrder['storeBranchToClientDistance'] === (float)GeoDistanceResultConstant::ZERO_DISTANCE_CONST ) {
             
            $countOrdersWithoutDistance += 1;
            }

           if($detailOrder['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH && $detailOrder['paidToProvider'] === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO ) {
                $amountForStore += $detailOrder['captainOrderCost'];
           }
        }

        $financialSystemDetail['financialDues'] = $this->financialDuesCalculator($countWorkdays, $countOrders['countOrder'], $countOrdersMaxFromNineteen, $financialSystemDetail['compensationForEveryOrder'], $financialSystemDetail['salary']);
     
        $financialSystemDetail['sumPayments'] = $sumPayments;
             
        $financialSystemDetail['countOrders'] = $countOrders['countOrder'];

        $financialSystemDetail['orders'] = $orders;

        $financialSystemDetail['countOrdersMaxFromNineteen'] = $countOrdersMaxFromNineteen;

        $financialSystemDetail['countOrdersWithoutDistance'] = $countOrdersWithoutDistance;

        $total = $sumPayments - round($financialSystemDetail['financialDues'], 2);
       
        $financialSystemDetail['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_BALANCE_CONST;
        
        if($total <= 0 ) {
            $financialSystemDetail['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_EXIST_CONST;
        }

        $financialSystemDetail['total'] = abs(round($total, 2));
        
        $financialSystemDetail['amountForStore'] = $amountForStore;
    
        $financialSystemDetail['dateFinancialCycleStarts'] = $date['fromDate'];

        $financialSystemDetail['dateFinancialCycleEnds'] = $date['toDate'];
    
        return $this->autoMapping->map('array', AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse::class, $financialSystemDetail);
    }
     //If the captain works 25 days he gets the monthly salary, if he works less than 25 days the captain gets the daily salary
    public function financialDuesCalculator(int $countWorkdays, int $countOrdersCompleted, int $countOrdersMaxFromNineteen, float $compensationForEveryOrder, float $salary)
    {
        //The number of actual working days is 25, if the captain works 25 days or more, he will receive the full monthly salary
        if($countWorkdays >= 25){
             
           return round((($countOrdersCompleted + $countOrdersMaxFromNineteen) * $compensationForEveryOrder ) + $salary, 2);
        }
 
        $dailySalary = $salary / 30;
        return round((($countOrdersCompleted + $countOrdersMaxFromNineteen) * $compensationForEveryOrder ) + $dailySalary, 2);
    }
}
