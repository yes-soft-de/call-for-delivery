<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse;
use App\Service\Order\OrderService;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;

class CaptainFinancialSystemTwoBalanceDetailService
{
    private OrderService $orderService;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, OrderService $orderService)
    {
        $this->orderService = $orderService;
        $this->autoMapping = $autoMapping;
    }

    public function getBalanceDetailWithSystemTwo(array $financialSystemDetail, int $captainId, float $sumPayments)
     {
        //get Count Orders Within Thirty Days
        $countOrders = $this->getCountOrdersByCaptainIdWithinThirtyDays($captainId, $financialSystemDetail['updatedAt']);

        $balanceDetail = $this->getBalanceDetail($countOrders['countOrder'], $financialSystemDetail, $sumPayments);
              
        return $this->autoMapping->map('array', CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse::class,  $balanceDetail);
    }

    public function getCountOrdersByCaptainIdWithinThirtyDays(int $captainId, object $date): ?array
    {
        $fromDate = $date->format('Y-m-d');
        $toDate = $date->modify('+30 day')->format('Y-m-d');
     
        return $this->orderService->getCountOrdersByCaptainIdOnSpecificDate($captainId, $fromDate, $toDate);
    }

    public function getBalanceDetail(int $countOrders, array $financialSystemDetail, float $sumPayments): ?array
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
        $item['dateFinancialCycleEnds'] = $financialSystemDetail['updatedAt']->format('Y-m-d');
        $item['sumPayments'] = $sumPayments;

        if($countOrders === $financialSystemDetail['countOrdersInMonth']) {
            $item['salary'] = $financialSystemDetail['salary'];
           
            $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS;
           
            $item['financialDues'] = $item['salary'] + $item['monthCompensation']; 
           
            $total = $sumPayments - $item['financialDues'];
        }

        if($countOrders > $financialSystemDetail['countOrdersInMonth']) {
            $item['salary'] = $financialSystemDetail['salary'];
           
            $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            $item['countOverOrdersThanRequired'] = $countOrders - $financialSystemDetail['countOrdersInMonth'];

            $item['bounce'] = $item['countOverOrdersThanRequired'] * $financialSystemDetail['bounceMaxCountOrdersInMonth'];   
           
            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_SUCCESS_AND_INCREASE;   
            
            $item['financialDues'] = $item['salary'] + $item['monthCompensation'] + $item['bounce']; 
           
            $total = $sumPayments - $item['financialDues'];
        }

        if($countOrders < $financialSystemDetail['countOrdersInMonth']) {
            //TODO this not completed ,we need more info
             $item['salary'] = $financialSystemDetail['salary'];
           
             $item['monthCompensation'] = $financialSystemDetail['monthCompensation'];

            //  $item['bounce'] = $countOverOrdersThanRequired * $financialSystemDetail['bounceMinCountOrdersInMonth']; 
        
             $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_FAILED;
             
            $item['financialDues'] = $item['salary'] + $item['monthCompensation']; 
          
            $total = $item['financialDues'] - $sumPayments;
        }

        $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;
      
        if($total <= 0 ) {
            $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $item['total'] = abs($total);

        return $item;
    }
}
