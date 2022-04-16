<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingOnOrderBalanceDetailResponse;
use App\Service\Order\OrderService;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;

class AdminCaptainFinancialSystemThreeBalanceDetailService
{
    private OrderService $orderService;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, OrderService $orderService)
    {
        $this->orderService = $orderService;
        $this->autoMapping = $autoMapping;
    }

    public function getBalanceDetailWithSystemThree(array $financialSystemDetails, int $captainId, float $sumPayments)
    {
        $countOrdersCompletedInCategory = 0;
          //get Count Orders
          $countOrders = $this->orderService->getCountOrdersByCaptainId($captainId);
          //get Orders Details
          $detailsOrders = $this->orderService->getDetailOrdersByCaptainId($captainId);
          foreach ($detailsOrders as $detailOrder) {
            foreach ($financialSystemDetails as $financialSystemDetail) {
                if($detailOrder['kilometer'] >= $financialSystemDetail->getCountKilometersFrom() && $detailOrder['kilometer'] <= $financialSystemDetail->getCountKilometersTo()) {
                    $detailOrder['amount'] = $financialSystemDetail->getAmount();
                    $detailOrder['bounce'] = $financialSystemDetail->getBounce();
                    $detailOrder['bounceCountOrdersInMonth'] = $financialSystemDetail->getBounceCountOrdersInMonth();
                    $detailOrder['categoryName'] = $financialSystemDetail->getCategoryName();
                    $detailOrder['countOrdersCompletedInCategory'] = $countOrdersCompletedInCategory + 1;
                }
            }
            $arr[] = $detailOrder;
          }
          dd ($arr);       
       
       
       
        // $total = $sumPayments - $financialSystemDetail['financialDues'];



        // $financialSystemDetail['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;
        
        // if($total <= 0 ) {
        //     $financialSystemDetail['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        // }

        // $financialSystemDetail['total'] = abs($total);

        // return $this->autoMapping->map('array', AdminCaptainFinancialSystemAccordingOnOrderBalanceDetailResponse::class, $financialSystemDetail);
    }
}
