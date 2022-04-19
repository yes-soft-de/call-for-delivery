<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse;
use App\Service\Order\OrderService;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Order\OrderTypeConstant;

class AdminCaptainFinancialSystemTwoBalanceDetailService
{
    private OrderService $orderService;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, OrderService $orderService)
    {
        $this->orderService = $orderService;
        $this->autoMapping = $autoMapping;
    }

    public function adminGetBalanceDetailWithSystemTwo(array $financialSystemDetail, int $captainId, float $sumPayments, array $date)
     {
        //get Count Orders Within Thirty Days
        $countOrders = $this->getCountOrdersByCaptainIdWithinThirtyDays($captainId, $date);
       
        //get Orders Details On Specific Date
        $detailsOrders = $this->orderService->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);

        $balanceDetail = $this->getBalanceDetail($countOrders['countOrder'], $financialSystemDetail, $sumPayments, $date, $detailsOrders);
              
        return $this->autoMapping->map('array', AdminCaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse::class,  $balanceDetail);
    }

    public function getCountOrdersByCaptainIdWithinThirtyDays(int $captainId, array $date): ?array
    {     
        return $this->orderService->getCountOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);
    }

    public function getBalanceDetail(int $countOrders, array $financialSystemDetail, float $sumPayments, array $date, array $detailsOrders): ?array
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
        $item['sumPayments'] = $sumPayments;
        //The amount received by the captain in cash from the orders, this amount will be handed over to the admin
        $item['amountForStore'] = 0;

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
           
            $item['monthTargetSuccess'] = CaptainFinancialSystem::TARGET_FAILED;
             
            $item['financialDues'] = $countOrders * CaptainFinancialSystem::TARGET_FAILED_SALARY; 
          
            $total = $sumPayments - $item['financialDues'];
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
}
