<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemDetailManager;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemOneBalanceDetailService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwoBalanceDetailService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemThreeBalanceDetailService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemAccordingOnOrderService;
use App\Service\CaptainFinancialSystemDate\CaptainFinancialSystemDateService;
use App\Manager\CaptainFinancialSystem\CaptainFinancialDuesManager;
use App\Request\CaptainFinancialSystem\CreateCaptainFinancialDuesRequest;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Entity\CaptainFinancialDuesEntity;
use App\Response\CaptainFinancialSystem\CaptainFinancialDuesResponse;
use App\Service\CaptainPayment\CaptainPaymentService;
use DateTime;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemDetailServiceTwo;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Request\CaptainFinancialSystem\CreateCaptainFinancialDuesByOptionalDatesRequest;

class CaptainFinancialDuesService
{
    private CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager;
    private CaptainFinancialSystemOneBalanceDetailService $captainFinancialSystemOneBalanceDetailService;
    private CaptainFinancialSystemTwoBalanceDetailService $captainFinancialSystemTwoBalanceDetailService;
    private CaptainFinancialSystemThreeBalanceDetailService $captainFinancialSystemThreeBalanceDetailService;
    private CaptainFinancialSystemAccordingOnOrderService $captainFinancialSystemAccordingOnOrderService;
    private CaptainFinancialSystemDateService $captainFinancialSystemDateService;
    private CaptainFinancialDuesManager $captainFinancialDuesManager;
    private AutoMapping $autoMapping;
    private CaptainPaymentService $captainPaymentService;
    private CaptainFinancialSystemDetailServiceTwo $captainFinancialSystemDetailServiceTwo;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager, CaptainFinancialSystemOneBalanceDetailService $captainFinancialSystemOneBalanceDetailService, CaptainFinancialSystemTwoBalanceDetailService $captainFinancialSystemTwoBalanceDetailService, CaptainFinancialSystemThreeBalanceDetailService $captainFinancialSystemThreeBalanceDetailService, CaptainFinancialSystemAccordingOnOrderService $captainFinancialSystemAccordingOnOrderService, CaptainFinancialSystemDateService $captainFinancialSystemDateService, CaptainFinancialDuesManager $captainFinancialDuesManager, CaptainPaymentService $captainPaymentService, CaptainFinancialSystemDetailServiceTwo $captainFinancialSystemDetailServiceTwo)
    {
        $this->captainFinancialSystemDetailManager = $captainFinancialSystemDetailManager;
        $this->captainFinancialSystemOneBalanceDetailService = $captainFinancialSystemOneBalanceDetailService;
        $this->captainFinancialSystemTwoBalanceDetailService = $captainFinancialSystemTwoBalanceDetailService;
        $this->captainFinancialSystemThreeBalanceDetailService = $captainFinancialSystemThreeBalanceDetailService;
        $this->captainFinancialSystemAccordingOnOrderService = $captainFinancialSystemAccordingOnOrderService;
        $this->captainFinancialSystemDateService = $captainFinancialSystemDateService;
        $this->captainFinancialDuesManager = $captainFinancialDuesManager;
        $this->autoMapping = $autoMapping;
        $this->captainPaymentService = $captainPaymentService;
        $this->captainFinancialSystemDetailServiceTwo = $captainFinancialSystemDetailServiceTwo;
    }
    // create or update (captainFinancialDues)
    public function captainFinancialDues(int $userId, $orderId = null, $orderCreatedAt = null)
    {
        //get Captain Financial System Detail current
        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($userId);
       
        if($financialSystemDetail) {
            //if not send order id get captain's active financial cycle 
            if(! $orderId && ! $orderCreatedAt) {
                //Get Captain's Active Financial Dues 
                $captainFinancialDues = $this->captainFinancialDuesManager->getCaptainFinancialDuesByUserIDAndState($userId, CaptainFinancialDues::FINANCIAL_STATE_ACTIVE);
                        
                if(! $captainFinancialDues) {
                    // Create Captain Financial Dues
                    $captainFinancialDues = $this->createCaptainFinancialDues($financialSystemDetail['captainId'], CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
                }
            }
            //if send order id get the financial cycle to which the order belongs
            else {
               $orderCreatedAt = $orderCreatedAt->format('y-m-d 00:00:00'); 
                //Get financial dues by orderId and userId
                $captainFinancialDues = $this->captainFinancialDuesManager->getCaptainFinancialDuesByUserIDAndOrderId($userId, $orderId, $orderCreatedAt);    
              
                if(! $captainFinancialDues) {
                    // Create Captain Financial Dues
                    return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
                    // $captainFinancialDues = $this->createCaptainFinancialDues($financialSystemDetail['captainId'], CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
                }           
            }

            $date = ['fromDate' => $captainFinancialDues->getStartDate()->format('y-m-d 00:00:00'), 'toDate' => $captainFinancialDues->getEndDate()->format('y-m-d 23:59:59')];
           
            $countWorkdays = $this->captainFinancialSystemDateService->subtractTwoDates(new DateTime ($date ['fromDate']), new DateTime($date['toDate']));

            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
               //Calculation of financial dues
                $financialDues = $this->captainFinancialSystemOneBalanceDetailService->getFinancialDuesWithSystemOne($financialSystemDetail, $financialSystemDetail['captainId'], $date, $countWorkdays);
               //update captain financial dues
               return $this->updateCaptainFinancialDuesAmount($captainFinancialDues, $financialDues);
            }

            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {
                //Calculation of financial dues
                $financialDues = $this->captainFinancialSystemTwoBalanceDetailService->getFinancialDuesWithSystemTwo($financialSystemDetail, $financialSystemDetail['captainId'], $date, $countWorkdays);

                //update captain financial dues
               return $this->updateCaptainFinancialDuesAmount($captainFinancialDues, $financialDues);
            }

            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
              
                $choseFinancialSystemDetails = $this->captainFinancialSystemAccordingOnOrderService->getCaptainFinancialSystemAccordingOnOrder();
                       
                $financialDues = $this->captainFinancialSystemThreeBalanceDetailService->getFinancialDuesWithSystemThree($choseFinancialSystemDetails, $financialSystemDetail['captainId'], $date);
               //update captain financial dues
               return $this->updateCaptainFinancialDuesAmount($captainFinancialDues, $financialDues);
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }

    public function createCaptainFinancialDues(int $captainId, int $status): CaptainFinancialDuesEntity
    {
        $date = $this->captainFinancialSystemDateService->getStartAndEndDateOfFinancialCycle();

        $request = new CreateCaptainFinancialDuesRequest();

        $request->setAmount(0);
        $request->setStatus($status);
        $request->setAmountForStore(0);
        $request->setStatusAmountForStore($status);
        $request->setStartDate($date['fromDate']);
        $request->setEndDate($date['toDate']);
        $request->setCaptain($captainId);

        return $this->captainFinancialDuesManager->createCaptainFinancialDues($request);
    }

    public function updateCaptainFinancialDuesAmount(CaptainFinancialDuesEntity $captainFinancialDues, array $financialDues)
    {
        $captainFinancialDues->setAmount($financialDues['financialDues']);
        $captainFinancialDues->setAmountForStore($financialDues['amountForStore']);

        return $this->captainFinancialDuesManager->updateCaptainFinancialDues($captainFinancialDues);
    }

    public function getCaptainFinancialDues(int $userId): array
    {        
        $response = [];

        $captainFinancialDues = $this->captainFinancialDuesManager->getCaptainFinancialDuesByUserId($userId);
        
        foreach ($captainFinancialDues as $captainFinancialDue) {
            
            $captainFinancialDue['amount'] = round($captainFinancialDue['amount'], 2);
            $captainFinancialDue['paymentsFromCompany'] = $this->captainPaymentService->getPaymentsByCaptainFinancialDues($captainFinancialDue['id']);
          
            $captainFinancialDue['total'] = $this->getCaptainFinancialTotal($captainFinancialDue['id']);

            $response[] = $this->autoMapping->map('array', CaptainFinancialDuesResponse::class, $captainFinancialDue);
        }

        return $response;
    }

    public function getCaptainFinancialTotal(int $captainFinancialDueId): array
    {
        $captainFinancialDues = [];
        
        $sumCaptainFinancialDues = $this->captainFinancialDuesManager->getSumCaptainFinancialDuesById($captainFinancialDueId);
        
        $sumPaymentsToCaptain = $this->captainPaymentService->getSumPaymentsToCaptainByCaptainFinancialDuesId($captainFinancialDueId);
   
        $total = $sumCaptainFinancialDues['sumCaptainFinancialDues'] - $sumPaymentsToCaptain['sumPaymentsToCaptain'];
       
        $captainFinancialDues['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;
    
        if($total <= 0 ) {
            $captainFinancialDues['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }
       
        $captainFinancialDues['sumCaptainFinancialDues'] =  round($sumCaptainFinancialDues['sumCaptainFinancialDues'], 2);
        $captainFinancialDues['sumPaymentsToCaptain'] = $sumPaymentsToCaptain['sumPaymentsToCaptain'];
        $captainFinancialDues['total'] = abs(round($total,2));

        return $captainFinancialDues;
    }
    
    public function getLatestCaptainFinancialDues(int $captainId): ?array
    {        
        return $this->captainFinancialDuesManager->getLatestCaptainFinancialDues($captainId);
    }
    // Check the end date of the financial cycle
    public function updateCaptainFinancialSystemDetail(int $userId)      
    {    
       $date = $this->captainFinancialSystemDateService->getCurrentMonthDate();

       $captainFinancialDues = $this->captainFinancialDuesManager->getCaptainFinancialDuesByEndDate($userId, $date);

       if($captainFinancialDues) {
            if(new datetime($captainFinancialDues['endDate']->format('y-m-d 23:59:59')) < new datetime('now')) {
               $this->captainFinancialDuesManager->updateCaptainFinancialDuesStateToInactive($captainFinancialDues['id']);
              
            //    return $this->captainFinancialSystemDetailServiceTwo->updateCaptainFinancialSystemDetail(0, $userId);
            }
       }

       return null;
    }

    public function getFinancialDuesByCaptainId(int $captainId): array
    {
        return $this->captainFinancialDuesManager->getFinancialDuesByCaptainId($captainId);
    }


    //START fix create financial dues
    public function calculateOrdersThatNotBelongToAnyFinancialDues($orders)
    { 
        $ordersNotBelongsToFinancialDues = [];
        foreach($orders as $order) {
            $order['createdDate'] = $order['createdAt']->format('y-m-d 00:00:00'); 
            
            $financialDues = $this->captainFinancialDuesManager->getCaptainFinancialDuesByUserIDAndOrderIdForFix($order['captainId'], $order['id'], $order['createdDate']);  
            if(!$financialDues) {
                //Orders Not Belongs To Financial Dues
                $ordersNotBelongsToFinancialDues[] = $order;
            }
        }
        //test 1
        // dd($ordersNotBelongsToFinancialDues);

        
        $items = $this->makeOrdersIntoCaptainsGroups($ordersNotBelongsToFinancialDues);
        foreach($items as $item) {
            //get first order and last order for each captain
            $first = $item[array_key_first($item)];
            $last = $item[array_key_last($item)];

            $this->createCaptainFinancialDuesByOptionalDates($first['captainId'], $first['createdAt'], $last['createdAt']);
        }

        foreach($ordersNotBelongsToFinancialDues as $order) {
          $captain = $this->captainFinancialDuesManager->getCaptainProfile($order['captainId'])->getCaptainId();
          $ii = $this->updateCaptainFinancialDuesByOrderId($captain, $order['id'], $order['createdDate']);
        }

        return "ok";
    }
   
   //Grouping orders according to groups according to the captains
   public function makeOrdersIntoCaptainsGroups($ordersNotBelongsToFinancialDues) {
        $result = array();
        foreach ($ordersNotBelongsToFinancialDues as $key => $element) {
            $result[$element['captainId']][$key] = $element;
        }
        return  $result;
    }

    //create Captain Financial Dues by optional dates
    public function createCaptainFinancialDuesByOptionalDates(int $captainProfileId, $startDate, $endDate): CaptainFinancialDuesEntity
    {
        $request = new CreateCaptainFinancialDuesByOptionalDatesRequest();

        $request->setAmount(0);
        $request->setStatus(CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
        $request->setAmountForStore(0);
        $request->setStatusAmountForStore(CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
        $request->setStartDate(new datetime($startDate->format('y-m-d')));
        $request->setEndDate(new datetime($endDate->format('y-m-d')));
        $request->setCaptain($captainProfileId);

        return $this->captainFinancialDuesManager->createCaptainFinancialDuesByOptionalDates($request);
    }

     // update captain Financial Dues
     public function updateCaptainFinancialDuesByOrderId(int $userId, $orderId, $createdDate)
     {
         $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($userId);
        
         if($financialSystemDetail) { 
            
            $captainFinancialDues = $this->captainFinancialDuesManager->getCaptainFinancialDuesByUserIDAndOrderIdForFixByUserID($userId, $orderId, $createdDate);    
            if(! $captainFinancialDues) {
                // Create Captain Financial Dues
                return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
             }           
 
             $date = ['fromDate' => $captainFinancialDues->getStartDate()->format('y-m-d 00:00:00'), 'toDate' => $captainFinancialDues->getEndDate()->format('y-m-d 23:59:59')];
            
             $countWorkdays = $this->captainFinancialSystemDateService->subtractTwoDatesTest(new DateTime ($date ['fromDate']), new DateTime($date['toDate']));
 
             if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
                //Calculation of financial dues
                 $financialDues = $this->captainFinancialSystemOneBalanceDetailService->getFinancialDuesWithSystemOne($financialSystemDetail, $financialSystemDetail['captainId'], $date, $countWorkdays);
                //update captain financial dues
                return $this->updateCaptainFinancialDuesAmount($captainFinancialDues, $financialDues);
             }
 
             if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {
                 //Calculation of financial dues
                 $financialDues = $this->captainFinancialSystemTwoBalanceDetailService->getFinancialDuesWithSystemTwo($financialSystemDetail, $financialSystemDetail['captainId'], $date, $countWorkdays);
 
                 //update captain financial dues
                return $this->updateCaptainFinancialDuesAmount($captainFinancialDues, $financialDues);
             }
 
             if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
               
                 $choseFinancialSystemDetails = $this->captainFinancialSystemAccordingOnOrderService->getCaptainFinancialSystemAccordingOnOrder();
                        
                 $financialDues = $this->captainFinancialSystemThreeBalanceDetailService->getFinancialDuesWithSystemThree($choseFinancialSystemDetails, $financialSystemDetail['captainId'], $date);
                //update captain financial dues
                return $this->updateCaptainFinancialDuesAmount($captainFinancialDues, $financialDues);
             }
         }
 
         return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
     }
    //END fix create financial dues
}
