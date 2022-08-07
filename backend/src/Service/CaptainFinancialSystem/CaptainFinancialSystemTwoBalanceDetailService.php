<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemTwoBalanceDetailManager;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Order\OrderTypeConstant;
use App\Constant\GeoDistance\GeoDistanceResultConstant;

class CaptainFinancialSystemTwoBalanceDetailService
{
    private CaptainFinancialSystemTwoBalanceDetailManager $captainFinancialSystemTwoBalanceDetailManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemTwoBalanceDetailManager $captainFinancialSystemTwoBalanceDetailManager)
    {
        $this->captainFinancialSystemTwoBalanceDetailManager = $captainFinancialSystemTwoBalanceDetailManager;
        $this->autoMapping = $autoMapping;
    }

    public function getBalanceDetailWithSystemTwo(array $financialSystemDetail, int $captainId, float $sumPayments, array $date, int $countWorkdays)
     {
        //get Count Orders On Specific Date
        $countOrders = $this->captainFinancialSystemTwoBalanceDetailManager->getCountOrdersByCaptainIdOnSpecificDate($captainId, $date ['fromDate'], $date['toDate']);
        
        //get Orders Details On Specific Date
        $detailsOrders = $this->captainFinancialSystemTwoBalanceDetailManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);

        $balanceDetail = $this->getBalanceDetail($countOrders['countOrder'], $financialSystemDetail, $sumPayments, $date, $detailsOrders, $countWorkdays);
              
        return $this->autoMapping->map('array', CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse::class,  $balanceDetail);
    }

    public function getBalanceDetail(int $countOrders, array $financialSystemDetail, float $sumPayments, array $date, array $detailsOrders, $countWorkdays): ?array
    {
        $total = 0;
        $item = [];
        $item['salary'] = 0;
        $item['monthCompensation'] = 0;
        $item['countOverOrdersThanRequired'] = 0;
        $item['bounce'] = 0;
        $item['financialDues'] = 0;
        $item['total'] = 0;
        $item['countOrdersCompleted'] = $countOrders;
        $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_NOT_ARRIVED;
        $item['dateFinancialCycleStarts'] = $date['fromDate'];
        $item['dateFinancialCycleEnds'] = $date['toDate'];
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

            if($orderDetail['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH && $orderDetail['paidToProvider'] === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                $item['amountForStore'] += $orderDetail['captainOrderCost'];
            }
        }

        $item['countOrdersCompleted'] +=  $item['countOrdersMaxFromNineteen'];

        $checkTarget = $this->checkTarget($financialSystemDetail['countOrdersInMonth'], $countWorkdays, $item['countOrdersCompleted']);
     
        if($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_INT) {
            $item['salary'] = $financialSystemDetail['salary'];
           
            $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $item['countOrdersInMonth'] = $financialSystemDetail['countOrdersInMonth'];
         
            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS;
            // if count workdays equal 30 days,The captain gets the salary and the monthly compensation
            if($countWorkdays === 30) {
                $item['financialDues'] = $item['salary'] + $item['monthCompensation']; 
            }
            else {
                $item['financialDues'] = $item['countOrdersCompleted'] * CaptainFinancialSystem::TARGET_FAILED_SALARY;  
            }

            $total = $item['financialDues'] - $sumPayments;
        }

        if($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT) {
            $item['salary'] = $financialSystemDetail['salary'];
           
            $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $item['countOrdersInMonth'] = $financialSystemDetail['countOrdersInMonth'];
            $item['countOverOrdersThanRequired'] = $item['countOrdersCompleted'] - $financialSystemDetail['countOrdersInMonth'] / 30;

            $item['bounce'] = round($item['countOverOrdersThanRequired'] * $financialSystemDetail['bounceMaxCountOrdersInMonth'], 2);   

            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE;   
            // if count workdays equal 30 days,The captain gets the salary and the monthly compensation 
            if($countWorkdays === 30) {
                $item['financialDues'] = round($item['salary'] + $item['monthCompensation'] + $item['bounce'], 2); 
            }
            else {
                $item['financialDues'] = round(( $item['countOrdersCompleted'] - $item['countOverOrdersThanRequired']) * CaptainFinancialSystem::TARGET_FAILED_SALARY + $item['bounce'], 2);  
            }

            $total = $item['financialDues'] - $sumPayments;
        }

        if($checkTarget === CaptainFinancialSystem::TARGET_FAILED_INT) {
            $item['salary'] = $financialSystemDetail['salary'];
           
            $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];
           
            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_FAILED;
             
            $item['countOrdersInMonth'] = $financialSystemDetail['countOrdersInMonth'];

            $item['financialDues'] = $item['countOrdersCompleted'] * CaptainFinancialSystem::TARGET_FAILED_SALARY; 
          
            $total = round($item['financialDues'] - $sumPayments, 2);
        }

        $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;
      
        if($total <= 0 ) {
            $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $item['total'] = abs($total);

        return $item;
    }

    public function getFinancialDuesWithSystemTwo(array $financialSystemDetail, int $captainId, array $date, int $countWorkdays)
    {
       //get Count Orders On Specific Date
       $countOrders = $this->captainFinancialSystemTwoBalanceDetailManager->getCountOrdersByCaptainIdOnSpecificDate($captainId, $date ['fromDate'], $date['toDate']);
      
       //get Orders Details On Specific Date
       $detailsOrders = $this->captainFinancialSystemTwoBalanceDetailManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);
       return $this->getFinancialDues($countOrders['countOrder'], $financialSystemDetail, $date, $detailsOrders, $countWorkdays);             
   }

   
   public function getFinancialDues(int $countOrders, array $financialSystemDetail, array $date, array $detailsOrders, int $countWorkdays): ?array
   {
       $item = [];
       $item['salary'] = 0;
       $item['financialDues'] = 0;
       //The amount received by the captain in cash from the orders, this amount will be handed over to the admin
       $item['amountForStore'] = 0;
       $item['countOrdersMaxFromNineteen'] = 0;
       $item['countOrdersCompleted'] = $countOrders;

       foreach($detailsOrders as $orderDetail) {
            if($orderDetail['storeBranchToClientDistance'] >= CaptainFinancialSystem::KILOMETER_TO_DOUBLE_ORDER ) {
                $item['countOrdersMaxFromNineteen'] = $item['countOrdersMaxFromNineteen'] + 1;
            }
            if($orderDetail['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH && $orderDetail['paidToProvider'] === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                $item['amountForStore'] += $orderDetail['captainOrderCost'];
            }
       }

       $item['countOrdersCompleted'] +=  $item['countOrdersMaxFromNineteen'];

       $checkTarget = $this->checkTarget($financialSystemDetail['countOrdersInMonth'], $countWorkdays, $item['countOrdersCompleted']);

       if($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_INT) {
           $item['salary'] = $financialSystemDetail['salary'];
           // if count workdays equal 30 days,The captain gets the salary and the monthly compensation 
           if($countWorkdays === 30) {
              $item['financialDues'] = $financialSystemDetail['salary'] + $financialSystemDetail['monthCompensation']; 
           }
           else {
              $item['financialDues'] = $item['countOrdersCompleted'] * CaptainFinancialSystem::TARGET_FAILED_SALARY;  
            }
        }
       
       if($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT) {
            $item['salary'] = $financialSystemDetail['salary'];
            
            $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $item['countOverOrdersThanRequired'] = $item['countOrdersCompleted'] - $financialSystemDetail['countOrdersInMonth'] / 30;

            $item['bounce'] = $item['countOverOrdersThanRequired'] * $financialSystemDetail['bounceMaxCountOrdersInMonth'];   
        
            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE;   
        
            if($countWorkdays === 30) {
                 $item['financialDues'] = $item['salary'] + $item['monthCompensation'] + $item['bounce']; 
            }
            else {
                $item['financialDues'] = ($item['countOrdersCompleted'] - $item['countOverOrdersThanRequired']) * CaptainFinancialSystem::TARGET_FAILED_SALARY + $item['bounce'];  
            }
        }

       if($checkTarget === CaptainFinancialSystem::TARGET_FAILED_INT) {
           $item['financialDues'] = $item['countOrdersCompleted'] * CaptainFinancialSystem::TARGET_FAILED_SALARY;          
       }

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
