<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;
use App\Service\Order\OrderService;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;

class CaptainFinancialSystemOneBalanceDetailService
{
    private OrderService $orderService;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, OrderService $orderService)
    {
        $this->orderService = $orderService;
        $this->autoMapping = $autoMapping;
    }

    public function getBalanceDetailWithSystemOne(array $financialSystemDetail, int $captainId, float $sumPayments): CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse
    {
        $countOrdersMaxFromNineteen = 0;
        //get Count Orders
        $countOrders = $this->orderService->getCountOrdersByCaptainId($captainId);
        //get Orders Details
        $detailsOrders = $this->orderService->getDetailOrdersByCaptainId($captainId);

        foreach($detailsOrders as $detailOrder) {
           if($detailOrder['kilometer'] > CaptainFinancialSystem::KILOMETER_TO_DOUBLE_ORDER ) {
                $countOrdersMaxFromNineteen = $countOrdersMaxFromNineteen + 1;
           }
        }

        $financialSystemDetail['financialDues'] = ( ($countOrders['countOrders'] + $countOrdersMaxFromNineteen) * 
        
        $financialSystemDetail['compensationForEveryOrder'] ) + $financialSystemDetail['salary'];
    
        $financialSystemDetail['sumPayments'] = $sumPayments;
             
        $financialSystemDetail['countOrders'] = $countOrders['countOrders'];

        $financialSystemDetail['countOrdersMaxFromNineteen'] = $countOrdersMaxFromNineteen;

        $total = $financialSystemDetail['financialDues'] - $sumPayments;
        
        $financialSystemDetail['totalIsMain'] = CaptainFinancialSystem::TOTAL_IS_MAIN_YES;
        
        if($total <= 0 ) {
            $financialSystemDetail['totalIsMain'] = CaptainFinancialSystem::TOTAL_IS_MAIN_NO;    
        }

        $financialSystemDetail['total'] = abs($total);

        return $this->autoMapping->map('array', CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse::class, $financialSystemDetail);
    }
}
