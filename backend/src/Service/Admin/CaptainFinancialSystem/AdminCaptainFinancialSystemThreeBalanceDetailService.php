<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingOnOrderBalanceDetailResponse;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Order\OrderTypeConstant;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemThreeBalanceDetailManager;
use App\Constant\GeoDistance\GeoDistanceResultConstant;

///todo comment out or delete this service when AdminCaptainFinancialSystemThreeGetBalanceDetailsService works correctly
class AdminCaptainFinancialSystemThreeBalanceDetailService
{
    private AdminCaptainFinancialSystemThreeBalanceDetailManager $adminCaptainFinancialSystemThreeBalanceDetailManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, AdminCaptainFinancialSystemThreeBalanceDetailManager $adminCaptainFinancialSystemThreeBalanceDetailManager)
    {
        $this->adminCaptainFinancialSystemThreeBalanceDetailManager = $adminCaptainFinancialSystemThreeBalanceDetailManager;
        $this->autoMapping = $autoMapping;
    }

    public function getBalanceDetailWithSystemThree(array $financialSystemThreeDetails, int $captainId, float $sumPayments, array $date) : array
    {      
        $financialAccountDetails = [];

        foreach ($financialSystemThreeDetails as $financialSystemThreeDetail) {
             
                //get orders arranged according to the categories of the financial system
                $financialSystemThreeDetail['orders'] = $this->getOrdersByFinancialSystemThree($captainId, $financialSystemThreeDetail, $date['fromDate'], $date['toDate']);
                //get the number of orders arranged according to the categories of the financial system
                $countOrders = $this->getCountOrdersByFinancialSystemThree($captainId, $financialSystemThreeDetail, $date['fromDate'], $date['toDate']);
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
                
                    if( $financialSystemThreeDetail['countOfOrdersLeft'] < 0 ) {
                        $financialSystemThreeDetail['countOfOrdersLeft'] = 0;
                    }
                    
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
         
          $finalFinancialAccount = $this->getFinalFinancialAccount($sumPayments, $financialAccountDetails, $captainId, $date);
          
          return [
            "financialAccountDetails" => $financialAccountDetails ,
            "finalFinancialAccount" => $finalFinancialAccount
        ];
    }

    public function getCountOrdersByFinancialSystemThree(int $captainId, array $financialSystemThreeDetail, $fromDate, $toDate)
    {
        return $this->adminCaptainFinancialSystemThreeBalanceDetailManager->getCountOrdersByFinancialSystemThree($captainId, $fromDate, $toDate, $financialSystemThreeDetail['countKilometersFrom'], $financialSystemThreeDetail['countKilometersTo']);
    }

    public function getOrdersByFinancialSystemThree(int $captainId, array $financialSystemThreeDetail, $fromDate, $toDate)
    {
        return $this->adminCaptainFinancialSystemThreeBalanceDetailManager->getOrdersByFinancialSystemThree($captainId, $fromDate, $toDate, $financialSystemThreeDetail['countKilometersFrom'], $financialSystemThreeDetail['countKilometersTo']);
    }

    public function getFinalFinancialAccount(float $sumPayments, array $financialAccountDetails, int $captainId, array $date): array
    {
        $finalFinancialAccount = [];
        $finalFinancialAccount['amountForStore'] = 0;
        $finalFinancialAccount['countOrdersWithoutDistance'] = 0;
      
        $finalFinancialAccount['financialDues'] = array_sum(array_map(fn ($financialAccountDetail) => $financialAccountDetail->captainTotalCategory, $financialAccountDetails));
         
        $finalFinancialAccount['sumPayments'] = $sumPayments;
       
        $total = round($sumPayments - $finalFinancialAccount['financialDues'], 1);
       
        $finalFinancialAccount['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_BALANCE_CONST;
    
        if($total <= 0 ) {
            $finalFinancialAccount['advancePayment'] = CaptainFinancialSystem::ADVANCED_PAYMENT_EXIST_CONST;
        }

        $finalFinancialAccount['total'] = abs($total);
        //get Orders Details On Specific Date
        $detailsOrders = $this->adminCaptainFinancialSystemThreeBalanceDetailManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);
        foreach($detailsOrders as $orderDetail) {
          
            if($orderDetail['storeBranchToClientDistance'] === null || $orderDetail['storeBranchToClientDistance'] === (float)GeoDistanceResultConstant::ZERO_DISTANCE_CONST ) {
             
                $finalFinancialAccount['countOrdersWithoutDistance'] += 1;
            }

            if($orderDetail['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH && $orderDetail['paidToProvider'] === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                $finalFinancialAccount['amountForStore'] += $orderDetail['captainOrderCost'];
            }
        }
        
        $finalFinancialAccount['dateFinancialCycleStarts'] = $date['fromDate'];
        $finalFinancialAccount['dateFinancialCycleEnds'] = $date['toDate'];
       
        return $finalFinancialAccount;
    }
}
