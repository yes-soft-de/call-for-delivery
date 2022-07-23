<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingOnOrderBalanceDetailResponse;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemThreeBalanceDetailManager;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Order\OrderTypeConstant;

class CaptainFinancialSystemThreeBalanceDetailService
{
    private CaptainFinancialSystemThreeBalanceDetailManager $captainFinancialSystemThreeBalanceDetailManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemThreeBalanceDetailManager $captainFinancialSystemThreeBalanceDetailManager)
    {
        $this->captainFinancialSystemThreeBalanceDetailManager = $captainFinancialSystemThreeBalanceDetailManager;
        $this->autoMapping = $autoMapping;
    }

    public function getBalanceDetailWithSystemThree(array $financialSystemThreeDetails, int $captainId, float $sumPayments, array $date) : array
    {      
        $financialAccountDetails = [];

        foreach ($financialSystemThreeDetails as $financialSystemThreeDetail) {
             
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
                        $financialSystemThreeDetail['message'] = CaptainFinancialSystem::CONGRATULATIONS_CAPTAIN." ".$financialSystemThreeDetail['bounce'];
                    }
                }

                $financialAccountDetails[] = $this->autoMapping->map('array', CaptainFinancialSystemAccordingOnOrderBalanceDetailResponse::class,  $financialSystemThreeDetail);
            }
         
          $finalFinancialAccount = $this->getFinalFinancialAccount($sumPayments, $financialAccountDetails, $captainId, $date);
          
          return [
            "financialAccountDetails" => $financialAccountDetails ,
            "finalFinancialAccount" => $finalFinancialAccount
        ];
    }

    public function getCountOrdersByFinancialSystemThree(int $captainId, array $financialSystemThreeDetail, $fromDate, $toDate)
    {
        return $this->captainFinancialSystemThreeBalanceDetailManager->getCountOrdersByFinancialSystemThree($captainId, $fromDate, $toDate, $financialSystemThreeDetail['countKilometersFrom'], $financialSystemThreeDetail['countKilometersTo']);
    }

    public function getFinalFinancialAccount(float $sumPayments, array $financialAccountDetails, int $captainId, array $date): array
    {
        $finalFinancialAccount = [];
        $finalFinancialAccount['amountForStore'] = 0;
        
        $finalFinancialAccount['financialDues'] = array_sum(array_map(fn ($financialAccountDetail) => $financialAccountDetail->captainTotalCategory, $financialAccountDetails));
         
        $finalFinancialAccount['sumPayments'] = $sumPayments;
       
        $total = $finalFinancialAccount['financialDues'] - $sumPayments;
       
        $finalFinancialAccount['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;
    
        if($total <= 0 ) {
            $finalFinancialAccount['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $finalFinancialAccount['total'] = abs($total);
       
        //get Orders Details On Specific Date
        $detailsOrders = $this->captainFinancialSystemThreeBalanceDetailManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);
        foreach($detailsOrders as $orderDetail) {
            
            if($orderDetail['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH && $orderDetail['paidToProvider'] === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                $finalFinancialAccount['amountForStore'] += $orderDetail['captainOrderCost'];
            }
        }
       
        $finalFinancialAccount['dateFinancialCycleStarts'] = $date['fromDate'];
        $finalFinancialAccount['dateFinancialCycleEnds'] = $date['toDate'];

        return $finalFinancialAccount;
    }

    public function getFinancialDuesWithSystemThree(array $financialSystemThreeDetails, int $captainId, array $date) : array
    {      
        $financialAccountDetails = [];

        foreach ($financialSystemThreeDetails as $financialSystemThreeDetail) {
             
                //get the number of orders arranged according to the categories of the financial system
                $countOrders = $this->captainFinancialSystemThreeBalanceDetailManager->getCountOrdersByFinancialSystemThree($captainId, $date['fromDate'], $date['toDate'], $financialSystemThreeDetail['countKilometersFrom'], $financialSystemThreeDetail['countKilometersTo']);
                //Amount payable to the captain in the absence of a bounce
                $financialSystemThreeDetail['captainTotalCategory'] = $countOrders['countOrder'] * $financialSystemThreeDetail['amount'];
               //cont Order Completed
                $financialSystemThreeDetail['contOrderCompleted'] = $countOrders['countOrder'];
                //If the category offers bonus
                if($financialSystemThreeDetail['bounceCountOrdersInMonth']) {
                    //Remaining number of orders to get the bounce    
                    $financialSystemThreeDetail['countOfOrdersLeft'] = $financialSystemThreeDetail['bounceCountOrdersInMonth'] - $financialSystemThreeDetail['contOrderCompleted'] ;
                    //If the captain's achieve the order number of orders to get the bounce
                    if($financialSystemThreeDetail['contOrderCompleted'] >= $financialSystemThreeDetail['bounceCountOrdersInMonth']) {
                        $financialSystemThreeDetail['captainBounce'] = $financialSystemThreeDetail['bounce'];
                        //Amount owed to the captain with bonus
                        $financialSystemThreeDetail['captainTotalCategory'] = $financialSystemThreeDetail['bounce'] +  $financialSystemThreeDetail['captainTotalCategory'];
                    }
                }
                
                $financialAccountDetails[] = $financialSystemThreeDetail;
            }
         
            return $this->getFinancialDues($financialAccountDetails, $captainId, $date);
    }

    public function getFinancialDues(array $financialAccountDetails, int $captainId, array $date): array
    {
        $finalFinancialAccount = [];
        $finalFinancialAccount['amountForStore'] = 0;
        
        $finalFinancialAccount['financialDues'] = array_sum(array_map(fn ($financialAccountDetail) => $financialAccountDetail['captainTotalCategory'], $financialAccountDetails));
                 
        //get Orders Details On Specific Date
        $detailsOrders = $this->captainFinancialSystemThreeBalanceDetailManager->getDetailOrdersByCaptainIdOnSpecificDate($captainId, $date['fromDate'], $date['toDate']);
        foreach($detailsOrders as $orderDetail) {
            if($orderDetail['payment'] === OrderTypeConstant::ORDER_PAYMENT_CASH && $orderDetail['paidToProvider'] === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
                $finalFinancialAccount['amountForStore'] += $orderDetail['captainOrderCost'];
            }
        }
 
        return $finalFinancialAccount;
    }
}
