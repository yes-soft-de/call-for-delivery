<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;
use App\Service\Order\OrderService;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Order\OrderTypeConstant;

class AdminCaptainFinancialSystemOneBalanceDetailService
{
    private OrderService $orderService;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, OrderService $orderService)
    {
        $this->orderService = $orderService;
        $this->autoMapping = $autoMapping;
    }

    public function getBalanceDetailWithSystemOne(array $financialSystemDetail, int $captainId, float $sumPayments, array $date): AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse
    {
        $countOrdersMaxFromNineteen = 0;
        //The amount received by the captain in cash from the orders, this amount will be handed over to the admin
        $amountForStore = 0;
        //get Count Orders On Specific Date
        $countOrders = $this->orderService->getCountOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);
        //get Orders Details On Specific Date
        $detailsOrders = $this->orderService->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);

        foreach($detailsOrders as $detailOrder) {
           if($detailOrder['kilometer'] > CaptainFinancialSystem::KILOMETER_TO_DOUBLE_ORDER ) {
                $countOrdersMaxFromNineteen = $countOrdersMaxFromNineteen + 1;
           }
          
           if($detailOrder['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH ) {
                $amountForStore += $detailOrder['captainOrderCost'];
           }
        }

        $financialSystemDetail['financialDues'] = ( ($countOrders['countOrder'] + $countOrdersMaxFromNineteen) * 
        
        $financialSystemDetail['compensationForEveryOrder'] ) + $financialSystemDetail['salary'];
    
        $financialSystemDetail['sumPayments'] = $sumPayments;
             
        $financialSystemDetail['countOrders'] = $countOrders['countOrder'];

        $financialSystemDetail['countOrdersMaxFromNineteen'] = $countOrdersMaxFromNineteen;

        $total = $sumPayments - $financialSystemDetail['financialDues'];
       
        $financialSystemDetail['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;
        
        if($total <= 0 ) {
            $financialSystemDetail['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $financialSystemDetail['total'] = abs($total);
        
        $financialSystemDetail['amountForStore'] = $amountForStore;

        return $this->autoMapping->map('array', AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse::class, $financialSystemDetail);
    }
}
