<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Order\OrderTypeConstant;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemTwoBalanceDetailManager;
use App\Constant\GeoDistance\GeoDistanceResultConstant;

class AdminCaptainFinancialSystemTwoBalanceDetailService
{
    private AdminCaptainFinancialSystemTwoBalanceDetailManager $adminCaptainFinancialSystemTwoBalanceDetailManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, AdminCaptainFinancialSystemTwoBalanceDetailManager $adminCaptainFinancialSystemTwoBalanceDetailManager)
    {
        $this->adminCaptainFinancialSystemTwoBalanceDetailManager = $adminCaptainFinancialSystemTwoBalanceDetailManager;
        $this->autoMapping = $autoMapping;
    }

    public function adminGetBalanceDetailWithSystemTwo(array $financialSystemDetail, int $captainId, float $sumPayments, array $date, int $countWorkdays)
     {
        //get Count Orders Within Thirty Days
        $countOrders = $this->getCountOrdersByCaptainIdWithinThirtyDays($captainId, $date);
        //get Orders Details On Specific Date
        $detailsOrders = $this->adminCaptainFinancialSystemTwoBalanceDetailManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);
       
        $balanceDetail = $this->getBalanceDetail($countOrders['countOrder'], $financialSystemDetail, $sumPayments, $date, $detailsOrders, $countWorkdays);
        //get Orders Details On Specific Date
        $balanceDetail['orders'] = $this->adminCaptainFinancialSystemTwoBalanceDetailManager->getOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);

        return $this->autoMapping->map('array', AdminCaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse::class,  $balanceDetail);
    }

    public function getCountOrdersByCaptainIdWithinThirtyDays(int $captainId, array $date): ?array
    {     
        return $this->adminCaptainFinancialSystemTwoBalanceDetailManager->getCountOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);
    }

    public function getBalanceDetail(int $countOrders, array $financialSystemDetail, float $sumPayments, array $date, array $detailsOrders, $countWorkdays): ?array
    {
        $item = [];
        $item['salary'] = 0;
        $item['monthCompensation'] = 0;
        $item['countOverOrdersThanRequired'] = 0;
        $item['bounce'] = 0;
        $item['financialDues'] = 0;
        $item['total'] = 0;
        $item['countOrdersCompleted'] = $countOrders;
        $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_NOT_ARRIVED;
        $item['dateFinancialCycleEnds'] = $date['toDate'];
        $item['dateFinancialCycleStarts'] = $date['fromDate'];
        $item['sumPayments'] = $sumPayments;
        //The amount received by the captain in cash from the orders, this amount will be handed over to the admin
        $item['amountForStore'] = 0;
        $item['countOrdersMaxFromNineteen'] = 0;
        $item['countOrdersWithoutDistance'] = 0;
     
        foreach($detailsOrders as $orderDetail) {
            if($orderDetail['storeBranchToClientDistance'] >= CaptainFinancialSystem::KILOMETER_TO_DOUBLE_ORDER ) {
                $item['countOrdersMaxFromNineteen'] = $item['countOrdersMaxFromNineteen'] + 1;
            }
            
            if($orderDetail['storeBranchToClientDistance'] === null || $orderDetail['storeBranchToClientDistance'] === (float)GeoDistanceResultConstant::ZERO_DISTANCE_CONST ) {
             
                $item['countOrdersWithoutDistance'] += 1;
            }

            if($orderDetail['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH && $orderDetail['paidToProvider'] === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO ) {
                $item['amountForStore'] += $orderDetail['captainOrderCost'];
            }
        }

        $item['countOrdersCompleted'] +=  $item['countOrdersMaxFromNineteen'];

        $checkTarget = $this->checkTarget($financialSystemDetail['countOrdersInMonth'], $countWorkdays, $item['countOrdersCompleted']);

        if($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_INT) {
            $item['salary'] = $financialSystemDetail['salary'];
           
            $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS;
            // if count workdays equal 30 days,The captain gets the salary and the monthly compensation
            if($countWorkdays === 30) {
                $item['financialDues'] = $item['salary'] + $item['monthCompensation']; 
            }
            else {
                $item['financialDues'] = $item['countOrdersCompleted'] * CaptainFinancialSystem::TARGET_FAILED_SALARY;  
            }

            $total = $sumPayments - $item['financialDues'];
        }

        if($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT) {
            $item['salary'] = $financialSystemDetail['salary'];
           
            $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $item['countOverOrdersThanRequired'] = $item['countOrdersCompleted'] - $financialSystemDetail['countOrdersInMonth'] / 30;

            $item['bounce'] = round($item['countOverOrdersThanRequired'] * $financialSystemDetail['bounceMaxCountOrdersInMonth'], 2);   
           
            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE;   
            // if count workdays equal 30 days,The captain gets the salary and the monthly compensation 
            if($countWorkdays === 30) {
                $item['financialDues'] = round($item['salary'] + $item['monthCompensation'] + $item['bounce'], 2); 
            }
            else {
                $item['financialDues'] = round(($item['countOrdersCompleted'] - $item['countOverOrdersThanRequired']) * CaptainFinancialSystem::TARGET_FAILED_SALARY + $item['bounce'], 2);  
            }

            $total = $sumPayments - round($item['financialDues'], 2);
        }

        if($checkTarget === CaptainFinancialSystem::TARGET_FAILED_INT) {
            $item['salary'] = $financialSystemDetail['salary'];
           
            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_FAILED;
             
            $item['financialDues'] = $item['countOrdersCompleted'] * CaptainFinancialSystem::TARGET_FAILED_SALARY; 
          
            $total = round($sumPayments - $item['financialDues'], 2);
        }

        $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;
      
        if($total <= 0 ) {
            $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $item['total'] = abs($total);

        return $item;
    }
   //Did the captain achieve the target?
   public function checkTarget(int $countOrdersInMonth, int $countWorkdays, int $countOrdersCompleted): int
   {
       $requiredDailyCountOrders = $countOrdersInMonth / 30;
       if ($countOrdersCompleted / $countWorkdays === $requiredDailyCountOrders) {
           return  CaptainFinancialSystem::TARGET_SUCCESS_INT;
       }

       if ($countOrdersCompleted / $countWorkdays > $requiredDailyCountOrders) {
           return  CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT;
       }

       if ($countOrdersCompleted / $countWorkdays < $requiredDailyCountOrders) {
           return  CaptainFinancialSystem::TARGET_FAILED_INT;
       }
    }
}
