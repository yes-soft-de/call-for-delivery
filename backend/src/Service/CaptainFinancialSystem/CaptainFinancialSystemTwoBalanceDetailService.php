<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemTwoBalanceDetailManager;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Order\OrderTypeConstant;
use DateTime;
class CaptainFinancialSystemTwoBalanceDetailService
{
    private CaptainFinancialSystemTwoBalanceDetailManager $captainFinancialSystemTwoBalanceDetailManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemTwoBalanceDetailManager $captainFinancialSystemTwoBalanceDetailManager)
    {
        $this->captainFinancialSystemTwoBalanceDetailManager = $captainFinancialSystemTwoBalanceDetailManager;
        $this->autoMapping = $autoMapping;
    }

    public function getBalanceDetailWithSystemTwo(array $financialSystemDetail, int $captainId, float $sumPayments, array $date)
     {
        //get Count Orders Within Thirty Days
        $countOrders = $this->captainFinancialSystemTwoBalanceDetailManager->getCountOrdersByCaptainIdOnSpecificDate($captainId, $date ['fromDate'], $date['toDate']);
        //get Orders Details On Specific Date
        $detailsOrders = $this->captainFinancialSystemTwoBalanceDetailManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);

        $balanceDetail = $this->getBalanceDetail($countOrders['countOrder'], $financialSystemDetail, $sumPayments, $date, $detailsOrders);
              
        return $this->autoMapping->map('array', CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse::class,  $balanceDetail);
    }

    public function getBalanceDetail(int $countOrders, array $financialSystemDetail, float $sumPayments, array $date, array $detailsOrders): ?array
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
        $item['dateFinancialCycleEnds'] = $date['toDate'];
        $item['sumPayments'] = $sumPayments;
        //The amount received by the captain in cash from the orders, this amount will be handed over to the admin
        $item['amountForStore'] = 0;
    
        if($countOrders === $financialSystemDetail['countOrdersInMonth']) {
            $item['salary'] = $financialSystemDetail['salary'];
           
            $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $item['countOrdersInMonth'] = $financialSystemDetail['countOrdersInMonth'];
         
            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS;
           
            $item['financialDues'] = $item['salary'] + $item['monthCompensation']; 
           
            $total = $item['financialDues'] - $sumPayments;
        }

        if($countOrders > $financialSystemDetail['countOrdersInMonth']) {
            $item['salary'] = $financialSystemDetail['salary'];
           
            $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $item['countOrdersInMonth'] = $financialSystemDetail['countOrdersInMonth'];

            $item['countOverOrdersThanRequired'] = $countOrders - $financialSystemDetail['countOrdersInMonth'];

            $item['bounce'] = $item['countOverOrdersThanRequired'] * $financialSystemDetail['bounceMaxCountOrdersInMonth'];   
           
            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE;   
            
            $item['financialDues'] = $item['salary'] + $item['monthCompensation'] + $item['bounce']; 
           
            $total = $item['financialDues'] - $sumPayments;
        }

        if($countOrders < $financialSystemDetail['countOrdersInMonth']) {
           
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
            
            if($orderDetail['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH ) {
                $item['amountForStore'] += $orderDetail['captainOrderCost'];
            }
        }

        return $item;
    }

    public function getFinancialDuesWithSystemTwo(array $financialSystemDetail, int $captainId, array $date)
    {
       //get Count Orders Within Thirty Days
       $countOrders = $this->captainFinancialSystemTwoBalanceDetailManager->getCountOrdersByCaptainIdOnSpecificDate($captainId, $date ['fromDate'], $date['toDate']);
       //get Orders Details On Specific Date
       $detailsOrders = $this->captainFinancialSystemTwoBalanceDetailManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);

       return $this->getFinancialDues($countOrders['countOrder'], $financialSystemDetail, $date, $detailsOrders);             
   }

   
   public function getFinancialDues(int $countOrders, array $financialSystemDetail, array $date, array $detailsOrders): ?array
   {
       $item = [];
       $item['salary'] = 0;
       $item['financialDues'] = 0;
       //The amount received by the captain in cash from the orders, this amount will be handed over to the admin
       $item['amountForStore'] = 0;
      
       if($countOrders === $financialSystemDetail['countOrdersInMonth']) {
           $item['salary'] = $financialSystemDetail['salary'];
          
           $item['financialDues'] = $financialSystemDetail['salary'] + $financialSystemDetail['monthCompensation']; 
       }

       if($countOrders > $financialSystemDetail['countOrdersInMonth']) {
            $item['salary'] = $financialSystemDetail['salary'];
            
            $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $item['countOverOrdersThanRequired'] = $countOrders - $financialSystemDetail['countOrdersInMonth'];

            $item['bounce'] = $item['countOverOrdersThanRequired'] * $financialSystemDetail['bounceMaxCountOrdersInMonth'];   
        
            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE;   
            
            $item['financialDues'] = $item['salary'] + $item['monthCompensation'] + $item['bounce']; 
        }

       if($countOrders < $financialSystemDetail['countOrdersInMonth']) {
            
           $item['financialDues'] = $countOrders * CaptainFinancialSystem::TARGET_FAILED_SALARY;          
       }
      
       foreach($detailsOrders as $orderDetail) {
           
           if($orderDetail['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH ) {
               $item['amountForStore'] += $orderDetail['captainOrderCost'];
           }
       }

       return $item;
   }
}
