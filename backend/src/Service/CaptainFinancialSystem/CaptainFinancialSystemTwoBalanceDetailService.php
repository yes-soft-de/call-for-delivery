<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemTwoBalanceDetailManager;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Order\OrderTypeConstant;

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
      
        $checkTarget = $this->checkTarget($financialSystemDetail['countOrdersInMonth'], $countWorkdays, $countOrders);

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
                $item['financialDues'] = $countOrders * CaptainFinancialSystem::TARGET_FAILED_SALARY;  
            }

            $total = $item['financialDues'] - $sumPayments;
        }

        if($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT) {
            $item['salary'] = $financialSystemDetail['salary'];
           
            $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $item['countOrdersInMonth'] = $financialSystemDetail['countOrdersInMonth'];
            $item['countOverOrdersThanRequired'] = $countOrders - $financialSystemDetail['countOrdersInMonth'] / 30;

            $item['bounce'] = $item['countOverOrdersThanRequired'] * $financialSystemDetail['bounceMaxCountOrdersInMonth'];   

            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE;   
            // if count workdays equal 30 days,The captain gets the salary and the monthly compensation 
            if($countWorkdays === 30) {
                $item['financialDues'] = $item['salary'] + $item['monthCompensation'] + $item['bounce']; 
            }
            else {
                $item['financialDues'] = ($countOrders - $item['countOverOrdersThanRequired']) * CaptainFinancialSystem::TARGET_FAILED_SALARY + $item['bounce'];  
            }

            $total = $item['financialDues'] - $sumPayments;
        }

        if($checkTarget === CaptainFinancialSystem::TARGET_FAILED_INT) {
            $item['salary'] = $financialSystemDetail['salary'];
           
            $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];
           
            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_FAILED;
             
            $item['countOrdersInMonth'] = $financialSystemDetail['countOrdersInMonth'];

            $item['financialDues'] = $countOrders * CaptainFinancialSystem::TARGET_FAILED_SALARY; 
          
            $total = $item['financialDues'] - $sumPayments;
        }

        $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;
      
        if($total <= 0 ) {
            $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $item['total'] = abs($total);
       
        foreach($detailsOrders as $orderDetail) {
            
            if($orderDetail['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH && $orderDetail['paidToProvider'] === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                $item['amountForStore'] += $orderDetail['captainOrderCost'];
            }
        }

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

       $checkTarget = $this->checkTarget($financialSystemDetail['countOrdersInMonth'], $countWorkdays, $countOrders);

       if($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_INT) {
           $item['salary'] = $financialSystemDetail['salary'];
           // if count workdays equal 30 days,The captain gets the salary and the monthly compensation 
           if($countWorkdays === 30) {
              $item['financialDues'] = $financialSystemDetail['salary'] + $financialSystemDetail['monthCompensation']; 
           }
           else {
              $item['financialDues'] = $countOrders * CaptainFinancialSystem::TARGET_FAILED_SALARY;  
            }
        }
       
       if($checkTarget === CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE_INT) {
            $item['salary'] = $financialSystemDetail['salary'];
            
            $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $item['countOverOrdersThanRequired'] = $countOrders - $financialSystemDetail['countOrdersInMonth'] / 30;

            $item['bounce'] = $item['countOverOrdersThanRequired'] * $financialSystemDetail['bounceMaxCountOrdersInMonth'];   
        
            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE;   
        
            if($countWorkdays === 30) {
                 $item['financialDues'] = $item['salary'] + $item['monthCompensation'] + $item['bounce']; 
            }
            else {
                $item['financialDues'] = ($countOrders - $item['countOverOrdersThanRequired']) * CaptainFinancialSystem::TARGET_FAILED_SALARY + $item['bounce'];  
            }
        }

       if($checkTarget === CaptainFinancialSystem::TARGET_FAILED_INT) {
           $item['financialDues'] = $countOrders * CaptainFinancialSystem::TARGET_FAILED_SALARY;          
       }
      
       foreach($detailsOrders as $orderDetail) {
           
           if($orderDetail['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH && $orderDetail['paidToProvider'] === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
               $item['amountForStore'] += $orderDetail['captainOrderCost'];
           }
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
