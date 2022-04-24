<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Order\OrderTypeConstant;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemOneBalanceDetailManager;

class AdminCaptainFinancialSystemOneBalanceDetailService
{
    private AutoMapping $autoMapping;
    private AdminCaptainFinancialSystemOneBalanceDetailManager $adminCaptainFinancialSystemOneBalanceDetailManager;

    public function __construct(AutoMapping $autoMapping, AdminCaptainFinancialSystemOneBalanceDetailManager $adminCaptainFinancialSystemOneBalanceDetailManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminCaptainFinancialSystemOneBalanceDetailManager = $adminCaptainFinancialSystemOneBalanceDetailManager;
    }

    public function getBalanceDetailWithSystemOne(array $financialSystemDetail, int $captainId, float $sumPayments, array $date): AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse
    {
        $countOrdersMaxFromNineteen = 0;
        //The amount received by the captain in cash from the orders, this amount will be handed over to the admin
        $amountForStore = 0;
        //get Count Orders On Specific Date
        $countOrders = $this->adminCaptainFinancialSystemOneBalanceDetailManager->getCountOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);
        //get Orders Details On Specific Date
        $detailsOrders = $this->adminCaptainFinancialSystemOneBalanceDetailManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);

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
