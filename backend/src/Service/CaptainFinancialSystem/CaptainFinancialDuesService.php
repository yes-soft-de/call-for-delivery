<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemDetailManager;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\CaptainFinancialSystem\CaptainFinancialDefaultSystem\CaptainFinancialDefaultSystemGetBalanceService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemOne\CaptainFinancialSystemOneGetBalanceDetailsService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemThree\CaptainFinancialSystemThreeGetBalanceDetailsService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo\CaptainFinancialSystemTwoGetBalanceDetailsService;
use App\Service\CaptainFinancialSystemDate\CaptainFinancialSystemDateService;
use App\Manager\CaptainFinancialSystem\CaptainFinancialDuesManager;
use App\Request\CaptainFinancialSystem\CreateCaptainFinancialDuesRequest;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Entity\CaptainFinancialDuesEntity;
use App\Response\CaptainFinancialSystem\CaptainFinancialDuesResponse;
use App\Service\CaptainPayment\CaptainPaymentService;
use DateTime;
use App\Request\CaptainFinancialSystem\CreateCaptainFinancialDuesByOptionalDatesRequest;

class CaptainFinancialDuesService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager,
        private CaptainFinancialSystemAccordingOnOrderService $captainFinancialSystemAccordingOnOrderService,
        private CaptainFinancialSystemDateService $captainFinancialSystemDateService,
        private CaptainFinancialDuesManager $captainFinancialDuesManager,
        private CaptainPaymentService $captainPaymentService,
        private CaptainFinancialSystemTwoGetBalanceDetailsService $captainFinancialSystemTwoGetBalanceDetailsService,
        private CaptainFinancialSystemThreeGetBalanceDetailsService $captainFinancialSystemThreeGetBalanceDetailsService,
        //private DateFactoryService $dateFactoryService,
        //private CaptainFinancialSystemDetailGetService $captainFinancialSystemDetailGetService
        private CaptainFinancialSystemOneGetBalanceDetailsService $captainFinancialSystemOneGetBalanceDetailsService,
        private CaptainFinancialDefaultSystemGetBalanceService $captainFinancialDefaultSystemGetBalanceService
    )
    {
    }

    /**
     *  Creates or updates (captainFinancialDues)
     */
    public function captainFinancialDues(int $userId, $orderId = null, $orderCreatedAt = null)
    {
        //get Captain Financial System Detail current
        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($userId);
       
        if ($financialSystemDetail) {
            //if not send order id get captain's active financial cycle 
//            if (! $orderId && ! $orderCreatedAt) {
//                //Get Captain's Active Financial Dues
//                $captainFinancialDues = $this->captainFinancialDuesManager->getCaptainFinancialDuesByUserIDAndState($userId,
//                    CaptainFinancialDues::FINANCIAL_STATE_ACTIVE);
//                /// todo we do not have to create a new captain financial due in this function at all
//                /// so when everything works correctly try to comment out the following IF block
//                if (! $captainFinancialDues) {
//                    // Create Captain Financial Dues
//                    $captainFinancialDues = $this->createCaptainFinancialDues($financialSystemDetail['captainId'], CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
//                }
//
//            } else {
//                //if send order id get the financial cycle to which the order belongs
//               $orderCreatedAt = $orderCreatedAt->format('y-m-d 00:00:00');
//                //Get financial dues by orderId and userId
//                $captainFinancialDues = $this->captainFinancialDuesManager->getCaptainFinancialDuesByUserIDAndOrderId($userId, $orderId, $orderCreatedAt);
//
//                if(! $captainFinancialDues) {
//                    // Create Captain Financial Dues
//                    return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
//                    // $captainFinancialDues = $this->createCaptainFinancialDues($financialSystemDetail['captainId'], CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
//                }
//            }

            $captainFinancialDues = $this->captainFinancialDuesManager->getCaptainFinancialDuesByUserIDAndState($userId,
                CaptainFinancialDues::FINANCIAL_STATE_ACTIVE);

            if ($captainFinancialDues) {
                $date = ['fromDate' => $captainFinancialDues->getStartDate()->format('y-m-d 00:00:00'), 'toDate' => $captainFinancialDues->getEndDate()->format('y-m-d 23:59:59')];

                $countWorkdays = $this->captainFinancialSystemDateService->subtractTwoDates(new DateTime ($date ['fromDate']), new DateTime($date['toDate']));

                if ($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
                    //Calculation of financial dues
                    // *** Habib code ***
                    // $financialDues = $this->captainFinancialSystemOneBalanceDetailService->getFinancialDuesWithSystemOne($financialSystemDetail, $financialSystemDetail['captainId'], $date, $countWorkdays);
                    // *** End of Habib code ***

                    // *** Rami code ***
                    $financialDues = $this->captainFinancialSystemOneGetBalanceDetailsService->calculateCaptainDues($financialSystemDetail,
                        $financialSystemDetail['captainId'], $date, $countWorkdays);
                    // *** End of Rami code ***

                    //update captain financial dues
                    return $this->updateCaptainFinancialDuesAmount($captainFinancialDues, $financialDues);

                } elseif ($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {
                    // *** Habib code ***
                    //Calculation of financial dues
                    // $financialDues = $this->captainFinancialSystemTwoBalanceDetailService->getFinancialDuesWithSystemTwo($financialSystemDetail, $financialSystemDetail['captainId'], $date, $countWorkdays);
                    // *** End of Habib code ***

                    // *** Rami code ***
                    $financialDues = $this->captainFinancialSystemTwoGetBalanceDetailsService->calculateCaptainDues($financialSystemDetail['captainId'], $financialSystemDetail, $date);
                    // *** End of Rami code ***

                    //update captain financial dues
                    return $this->updateCaptainFinancialDuesAmount($captainFinancialDues, $financialDues);

                } elseif ($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
                    $choseFinancialSystemDetails = $this->captainFinancialSystemAccordingOnOrderService->getCaptainFinancialSystemAccordingOnOrder();

                    // *** Habib code ***
                    //$financialDues = $this->captainFinancialSystemThreeBalanceDetailService->getFinancialDuesWithSystemThree($choseFinancialSystemDetails, $financialSystemDetail['captainId'], $date);
                    // *** End of Habib code ***

                    // *** Rami code ***
                    $financialDues = $this->captainFinancialSystemThreeGetBalanceDetailsService->calculateCaptainDues($choseFinancialSystemDetails,
                        $financialSystemDetail['captainId'], $date);
                    // *** End of Rami code ***

                    //update captain financial dues
                    return $this->updateCaptainFinancialDuesAmount($captainFinancialDues, $financialDues);

                } elseif ($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_DEFAULT_SYSTEM_CONST) {
                    // *** Rami code ***
                    $financialDues = $this->captainFinancialDefaultSystemGetBalanceService->calculateCaptainDues($financialSystemDetail,
                        $orderId);
                    // *** End of Rami code ***

                    //update captain financial dues
                    return $this->updateCaptainFinancialDuesAmountByNewAmountAddition($captainFinancialDues, $financialDues);
                }
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }

    public function createCaptainFinancialDues(int $captainProfileId, int $status): CaptainFinancialDuesEntity
    {
        $date = $this->captainFinancialSystemDateService->getStartAndEndDateOfFinancialCycle();

        $request = new CreateCaptainFinancialDuesRequest();

        $request->setAmount(0);
        $request->setStatus($status);
        $request->setAmountForStore(0);
        $request->setStatusAmountForStore($status);
        $request->setStartDate($date['fromDate']);
        $request->setEndDate($date['toDate']);
        $request->setCaptain($captainProfileId);

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

    /**
     * Check each order of the provided ones, if it doesn't belong to any financial cycle, then create a one
     * which contains the order/s that accepted by same captain
     */
    public function calculateOrdersThatNotBelongToAnyFinancialDues(array $orders): string
    {
        // First, filter provided orders to get only the orders which does not belong to any financial cycle
        $ordersNotBelongsToFinancialDues = [];

        foreach ($orders as $order) {
            $order['createdDate'] = $order['createdAt']->format('y-m-d 00:00:00'); 
            
            $financialDues = $this->captainFinancialDuesManager->getCaptainFinancialDuesByUserIDAndOrderIdForFix($order['captainId'], $order['id'], $order['createdDate']);  

            if (! $financialDues) {
                //Orders Not Belongs To Financial Dues
                $ordersNotBelongsToFinancialDues[] = $order;
            }
        }
        // Just for testing, un-comment the following line in order to check if there are orders meeting the conditions
        // dd($ordersNotBelongsToFinancialDues);

        // Second, group orders according to captains
        $items = $this->makeOrdersIntoCaptainsGroups($ordersNotBelongsToFinancialDues);

        // Third, create financial cycle for each group of orders that belong to a unique captain
        foreach ($items as $item) {
            /**
             * get first order and last order for each captain, in order to determine the start and the end dates of
             * the financial cycle that will be created
             */
            $first = $item[array_key_first($item)];
            $last = $item[array_key_last($item)];

            $this->createCaptainFinancialDuesByOptionalDates($first['captainId'], $first['createdAt'], $last['createdAt']);
        }

        // Finally, update the financial dues of the related captains
        foreach ($ordersNotBelongsToFinancialDues as $order) {
            $captain = $this->captainFinancialDuesManager->getCaptainProfile($order['captainId'])->getCaptainId();

            $this->updateCaptainFinancialDuesByOrderId($captain, $order['id'], $order['createdDate']);
        }

        return CaptainFinancialSystem::OK_RESULT_CONST;
    }
   
   //Grouping orders according to groups according to the captains
   public function makeOrdersIntoCaptainsGroups(array $ordersNotBelongsToFinancialDues): array
   {
        $result = array();

        foreach ($ordersNotBelongsToFinancialDues as $key => $element) {
            $result[$element['captainId']][$key] = $element;
        }

        return $result;
    }

    //create Captain Financial Dues by optional dates
    public function createCaptainFinancialDuesByOptionalDates(int $captainProfileId, $startDate, $endDate): CaptainFinancialDuesEntity
    {
        $request = new CreateCaptainFinancialDuesByOptionalDatesRequest();

        $request->setAmount(0);
        $request->setStatus(CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
        $request->setAmountForStore(0);
        $request->setStatusAmountForStore(CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
        $request->setStartDate(new DateTime($startDate->format('y-m-d')));
        $request->setEndDate(new DateTime($endDate->format('y-m-d')));
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
                 // *** Habib code ***
                 //$financialDues = $this->captainFinancialSystemOneBalanceDetailService->getFinancialDuesWithSystemOne($financialSystemDetail, $financialSystemDetail['captainId'], $date, $countWorkdays);
                 // *** End of Habib code ***

                 // *** Rami code ***
                 $financialDues = $this->captainFinancialSystemOneGetBalanceDetailsService->calculateCaptainDues($financialSystemDetail,
                     $financialSystemDetail['captainId'], $date, $countWorkdays);
                 // *** End of Rami code ***

                 //update captain financial dues
                return $this->updateCaptainFinancialDuesAmount($captainFinancialDues, $financialDues);
             }
 
             if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {
                 // *** Habib code ***
                 //Calculation of financial dues
                 // $financialDues = $this->captainFinancialSystemTwoBalanceDetailService->getFinancialDuesWithSystemTwo($financialSystemDetail, $financialSystemDetail['captainId'], $date, $countWorkdays);
                 // *** End of Habib code ***

                 // *** Rami code ***
                 $financialDues = $this->captainFinancialSystemTwoGetBalanceDetailsService->calculateCaptainDues($financialSystemDetail['captainId'], $financialSystemDetail, $date);
                 // *** End of Rami code ***
 
                 //update captain financial dues
                return $this->updateCaptainFinancialDuesAmount($captainFinancialDues, $financialDues);
             }
 
             if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
               
                 $choseFinancialSystemDetails = $this->captainFinancialSystemAccordingOnOrderService->getCaptainFinancialSystemAccordingOnOrder();

                 // *** Habib code ***
                 //$financialDues = $this->captainFinancialSystemThreeBalanceDetailService->getFinancialDuesWithSystemThree($choseFinancialSystemDetails, $financialSystemDetail['captainId'], $date);
                 // *** End of Habib code ***

                 // *** Rami code ***
                 $financialDues = $this->captainFinancialSystemThreeGetBalanceDetailsService->calculateCaptainDues($choseFinancialSystemDetails,
                     $financialSystemDetail['captainId'], $date);
                 // *** End of Rami code ***

                //update captain financial dues
                return $this->updateCaptainFinancialDuesAmount($captainFinancialDues, $financialDues);
             }
         }
 
         return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
     }
    //END fix create financial dues

    public function getFinancialDuesSumByCaptainId(int $captainId): array
    {
        return $this->captainFinancialDuesManager->getFinancialDuesSumByCaptainId($captainId);
    }

    public function deleteAllCaptainFinancialDuesByCaptainId(int $captainId): array
    {
        return $this->captainFinancialDuesManager->deleteAllCaptainFinancialDuesByCaptainId($captainId);
    }

    public function createCaptainFinancialDueByAdminIfNotAnActiveOneExist(int $captainProfileId): CaptainFinancialDuesEntity
    {
        $captainFinancialDues = $this->captainFinancialDuesManager->getCurrentAndActiveCaptainFinancialDueByCaptainProfileId($captainProfileId);

        if (count($captainFinancialDues) === 0) {
            // Create Captain Financial Dues
            return $this->createCaptainFinancialDues($captainProfileId, CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
        }

        return $captainFinancialDues[0];
    }

    public function updateCaptainFinancialDuesAmountByNewAmountAddition(CaptainFinancialDuesEntity $captainFinancialDues, array $financialDues): CaptainFinancialDuesEntity
    {
        $captainFinancialDues->setAmount($captainFinancialDues->getAmount() + $financialDues['financialDues']);
        $captainFinancialDues->setAmountForStore($captainFinancialDues->getAmountForStore() + $financialDues['amountForStore']);

        return $this->captainFinancialDuesManager->updateCaptainFinancialDues($captainFinancialDues);
    }
}
