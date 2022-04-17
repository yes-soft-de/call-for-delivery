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

    public function getBalanceDetailWithSystemThree(array $financialSystemDetails, array $financialSystemThreeDetails, int $captainId, float $sumPayments) : array
    {
        $date = $financialSystemDetails['updatedAt'];
        $fromDate = $date->format('Y-m-d');
        $toDate = $date->modify('+30 day')->format('Y-m-d');
      
        $financialAccountDetails = [];

        foreach ($financialSystemThreeDetails as $financialSystemThreeDetail) {
             
                //get the number of orders arranged according to the categories of the financial system
                $countOrders = $this->getCountOrdersByFinancialSystemThree($captainId, $financialSystemThreeDetail, $fromDate, $toDate);
               //Amount payable to the captain in the absence of a bounce
                $financialSystemThreeDetail['captainTotalCategory'] = $countOrders['countOrder'] * $financialSystemThreeDetail['amount'];
               //cont Order Completed
                $financialSystemThreeDetail['contOrderCompleted'] = $countOrders['countOrder'];
                //If the category offers bonus
                if($financialSystemThreeDetail['bounceCountOrdersInMonth']) {
                    //Remaining number of orders to get the bounce    
                    $financialSystemThreeDetail['countOfOrdersLeft'] = $financialSystemThreeDetail['bounceCountOrdersInMonth'] - $financialSystemThreeDetail['contOrderCompleted'] ;
                    //Motivational message
                    $financialSystemThreeDetail['message'] = CaptainFinancialSystem::COUNT_REMAINING_ORDER." ".$financialSystemThreeDetail['countOfOrdersLeft']." ".CaptainFinancialSystem::FOR_BOUNCE." ".$financialSystemThreeDetail['bounce'];
                    //If the captain's achieve the order number of orders to get the bounce
                    if($financialSystemThreeDetail['contOrderCompleted'] >= $financialSystemThreeDetail['bounceCountOrdersInMonth']) {
                        $financialSystemThreeDetail['captainBounce'] = $financialSystemThreeDetail['bounce'];
                        //Amount owed to the captain with bonus
                        $financialSystemThreeDetail['captainTotalCategory'] = $financialSystemThreeDetail['bounce'] +  $financialSystemThreeDetail['captainTotalCategory'];
                        //A congratulatory message
                        $financialSystemThreeDetail['message'] = CaptainFinancialSystem::CAPTAIN_GOT_BOUNCE_ADMIN." ".$financialSystemThreeDetail['bounce'];
                    }
                }

                $financialAccountDetails[] = $this->autoMapping->map('array', AdminCaptainFinancialSystemAccordingOnOrderBalanceDetailResponse::class,  $financialSystemThreeDetail);
            }
         
          $finalFinancialAccount = $this->getFinalFinancialAccount($sumPayments, $financialAccountDetails);
          
          return [
            "financialAccountDetails" => $financialAccountDetails ,
            "finalFinancialAccount" => $finalFinancialAccount
        ];
    }

    public function getCountOrdersByFinancialSystemThree(int $captainId, array $financialSystemThreeDetail, $fromDate, $toDate)
    {
        return $this->orderService->getCountOrdersByFinancialSystemThree($captainId, $fromDate, $toDate, $financialSystemThreeDetail['countKilometersFrom'], $financialSystemThreeDetail['countKilometersTo']);
    }

    public function getFinalFinancialAccount(float $sumPayments, array $financialAccountDetails): array
    {
        $finalFinancialAccount = [];

        $finalFinancialAccount['financialDues'] = array_sum(array_map(fn ($financialAccountDetail) => $financialAccountDetail->captainTotalCategory, $financialAccountDetails));
         
        $finalFinancialAccount['sumPayments'] = $sumPayments;
       
        $total = $sumPayments - $finalFinancialAccount['financialDues'];
       
        $finalFinancialAccount['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;
    
        if($total <= 0 ) {
            $finalFinancialAccount['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $finalFinancialAccount['total'] = abs($total);

        return $finalFinancialAccount;
    }
}
