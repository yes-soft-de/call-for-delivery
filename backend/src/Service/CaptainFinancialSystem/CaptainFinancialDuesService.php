<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Constant\Order\OrderResultConstant;
use App\Entity\CaptainOrderFinancialEntity;
use App\Entity\OrderEntity;
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
use DateTimeInterface;
use Doctrine\ORM\EntityManagerInterface;

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
        //private CaptainFinancialSystemDetailGetService $captainFinancialSystemDetailGetService
        private CaptainFinancialSystemOneGetBalanceDetailsService $captainFinancialSystemOneGetBalanceDetailsService,
        private CaptainFinancialDefaultSystemGetBalanceService $captainFinancialDefaultSystemGetBalanceService,
        private EntityManagerInterface $entityManager
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

                    // create Captain Order Financial
                    $this->createCaptainOrderFinancial($orderId, $financialDues, $captainFinancialDues);

                    //update captain financial dues
                    return $this->updateCaptainFinancialDuesAmountByNewAmountAddition($captainFinancialDues, $financialDues);
                }
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }

    public function createCaptainFinancialDues(int $captainProfileId, int $status): CaptainFinancialDuesEntity
    {
        // $date = $this->captainFinancialSystemDateService->getStartAndEndDateOfFinancialCycle();

        $request = new CreateCaptainFinancialDuesRequest();

        $request->setAmount(0);
        $request->setStatus($status);
        $request->setAmountForStore(0);
        $request->setStatusAmountForStore($status);
        $request->setStartDate(new DateTime('now'));
        $request->setEndDate(new DateTime('+365 day'));
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

    public function createCaptainOrderFinancial(int $orderId, array $financialDueArray, CaptainFinancialDuesEntity $captainFinancialDuesEntity): CaptainOrderFinancialEntity|int|string
    {
        $orderEntity = $this->entityManager->getRepository(OrderEntity::class)->findOneBy(['id' => $orderId]);

        if ($orderEntity) {
            $captainOrderFinancial = $this->entityManager->getRepository(CaptainOrderFinancialEntity::class)
                ->findOneBy(['orderId' => $orderEntity->getId()]);

            if (! $captainOrderFinancial) {
                if ($orderEntity->getCaptainId()) {
                    $captainOrderFinancial = new CaptainOrderFinancialEntity();

                    $captainOrderFinancial->setOrderId($orderEntity);
                    $captainOrderFinancial->setCaptain($orderEntity->getCaptainId());
                    $captainOrderFinancial->setProfit($financialDueArray['financialDues']);
                    $captainOrderFinancial->setCashAmount($financialDueArray['amountForStore']);
                    $captainOrderFinancial->setFinalProfit($financialDueArray['financialDues'] - $financialDueArray['amountForStore']);
                    $captainOrderFinancial->setCaptainFinancialDue($captainFinancialDuesEntity);

                    $this->entityManager->persist($captainOrderFinancial);
                    $this->entityManager->flush();

                    return $captainOrderFinancial;
                }

                return OrderResultConstant::ORDER_HAS_NO_CAPTAIN_CONST;
            }

            return CaptainFinancialSystem::CAPTAIN_ORDER_PROFIT_EXIST_CONST;
        }

        return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
    }

    public function createOrUpdateCaptainOrderFinancial(int $orderId): CaptainOrderFinancialEntity|int|string
    {
        $orderEntity = $this->entityManager->getRepository(OrderEntity::class)->findOneBy(['id' => $orderId]);

        if ($orderEntity) {
            if ($orderEntity->getCaptainId()) {
                $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($orderEntity->getCaptainId()->getCaptainId());

                if ($financialSystemDetail) {
                    if (count($financialSystemDetail) > 0) {
                        $captainFinancialDues = $this->getCaptainFinancialDueByCaptainProfileIdAndOrderCreationDate($orderEntity->getCaptainId()->getId(),
                            $orderEntity->getCreatedAt());

                        if ($captainFinancialDues !== CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
                            if ($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_DEFAULT_SYSTEM_CONST) {
                                $financialDues = $this->captainFinancialDefaultSystemGetBalanceService->calculateCaptainDues($financialSystemDetail,
                                    $orderId);

                                $captainOrderFinancial = $this->entityManager->getRepository(CaptainOrderFinancialEntity::class)
                                    ->findOneBy(['orderId' => $orderId]);

                                if (! $captainOrderFinancial) {
                                    return $this->createCaptainOrderFinancial($orderId, $financialDues, $captainFinancialDues);

                                } else {
                                    $captainOrderFinancial->setProfit($financialDues['financialDues']);
                                    $captainOrderFinancial->setCashAmount($financialDues['amountForStore']);
                                    $captainOrderFinancial->setFinalProfit($financialDues['financialDues'] - $financialDues['amountForStore']);

                                    $this->entityManager->flush();

                                    return $captainOrderFinancial;
                                }
                            }

                            return CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_IS_NOT_THE_DEFAULT_SYSTEM_CONST;
                        }

                        return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
                    }

                    return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
                }

                return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
            }

            return OrderResultConstant::ORDER_HAS_NO_CAPTAIN_CONST;
        }

        return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
    }

    public function getCaptainFinancialDueByCaptainProfileIdAndOrderCreationDate(int $captainProfileId, \DateTimeInterface $orderCreationDate): int|CaptainFinancialDuesEntity
    {
        $captainFinancialDue = $this->captainFinancialDuesManager->getCaptainFinancialDueByCaptainProfileIdAndOrderCreationDate($captainProfileId,
            $orderCreationDate);

        if (count($captainFinancialDue) > 0) {
            return $captainFinancialDue[0];
        }

        return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
    }

    public function getCaptainFinancialDuesByCaptainUserIdAndOrderCreationDate(int $captainUserId, DateTimeInterface $dateTimeInterface): int|CaptainFinancialDuesEntity
    {
        $captainFinancialDue = $this->captainFinancialDuesManager->getCaptainFinancialDuesByCaptainUserIdAndOrderCreationDate($captainUserId,
            $dateTimeInterface);

        if (count($captainFinancialDue) === 0) {
            return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
        }

        return $captainFinancialDue[0];
    }

    public function subtractValueFromCaptainFinancialDueAmount(int $captainUserId, float $value, DateTimeInterface $orderCreatedAt): CaptainFinancialDuesEntity|int
    {
        // 1 get captain financial due
        $captainFinancialDue = $this->getCaptainFinancialDuesByCaptainUserIdAndOrderCreationDate($captainUserId, $orderCreatedAt);

        if ($captainFinancialDue === CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
            return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
        }

        // 2 update captain financial due
        return $this->captainFinancialDuesManager->subtractValueFromCaptainFinancialDueAmountByCaptainFinancialDueEntity($captainFinancialDue,
            $value);
    }

    public function addValueToCaptainFinancialDueAmount(int $captainUserId, float $value, DateTimeInterface $orderCreatedAt): CaptainFinancialDuesEntity|int
    {
        // 1 get captain financial due
        $captainFinancialDue = $this->getCaptainFinancialDuesByCaptainUserIdAndOrderCreationDate($captainUserId, $orderCreatedAt);

        if ($captainFinancialDue === CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
            return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
        }

        // 2 update captain financial due
        return $this->captainFinancialDuesManager->addValueToCaptainFinancialDueAmount($captainFinancialDue, $value);
    }

    /**
     * Updates amount field of captain financial due entity after distance changed
     */
    public function updateCaptainFinancialDueAfterOrderDistanceUpdating(int $captainUserId, $oldDistance, DateTimeInterface $orderCreatedAt, float $newDistance): CaptainFinancialDuesEntity|int|string
    {
        // 1 According to old order distance, subtract order financial value from captain financial due
        if ($oldDistance === OrderResultConstant::ORDER_STORE_BRANCH_TO_CLIENT_DISTANCE_IS_NULL_CONST) {
            $oldDistance = 0.0;
        }

        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($captainUserId);

        if ($financialSystemDetail) {
            if (count($financialSystemDetail) > 0) {
                if ($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_DEFAULT_SYSTEM_CONST) {
                    $captainProfit = $this->captainFinancialDefaultSystemGetBalanceService->calculateCaptainFinancialAmountForSingleOrderByOrderDistance($oldDistance,
                        $financialSystemDetail);

                    if ($captainProfit != 0.0) {
                        // subtract the value of the amount field of captain financial due
                        $this->subtractValueFromCaptainFinancialDueAmount($captainUserId, $captainProfit, $orderCreatedAt);
                    }

                    // 2 According to new order distance, add order value to captain financial due
                    $newCaptainProfit = $this->captainFinancialDefaultSystemGetBalanceService->calculateCaptainFinancialAmountForSingleOrderByOrderDistance($newDistance,
                        $financialSystemDetail);

                    // update captain financial dues
                    return $this->addValueToCaptainFinancialDueAmount($captainUserId, $newCaptainProfit, $orderCreatedAt);
                }
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }

    public function subtractValueFromCaptainFinancialDueAmountForStore(int $captainUserId, DateTimeInterface $orderCreatedAt, float $value): CaptainFinancialDuesEntity|int
    {
        // 1 get captain financial due
        $captainFinancialDue = $this->getCaptainFinancialDuesByCaptainUserIdAndOrderCreationDate($captainUserId, $orderCreatedAt);

        if ($captainFinancialDue === CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
            return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
        }

        // 2 update amountForStore of the captain financial due
        return $this->captainFinancialDuesManager->subtractValueFromCaptainFinancialDueAmountForStoreByCaptainFinancialDueEntity($captainFinancialDue,
            $value);
    }

    public function addValueToCaptainFinancialDueAmountForStore(int $captainUserId, DateTimeInterface $orderCreatedAt, float $value): CaptainFinancialDuesEntity|int
    {
        // 1 get captain financial due
        $captainFinancialDue = $this->getCaptainFinancialDuesByCaptainUserIdAndOrderCreationDate($captainUserId, $orderCreatedAt);

        if ($captainFinancialDue === CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
            return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
        }

        // 2 update amountForStore of the captain financial due
        return $this->captainFinancialDuesManager->addValueToCaptainFinancialDueAmountForStoreByCaptainFinancialDueEntity($captainFinancialDue,
            $value);
    }

    /**
     * Calculates and adds half of order value to the captain financial due
     */
    public function addHalfOrderValueToCaptainFinancialDue(int $captainUserId, DateTimeInterface $orderCreatedAt, ?float $orderDistance): CaptainFinancialDuesEntity|int|string
    {
        // 1 get captain financial due
        $captainFinancialDue = $this->getCaptainFinancialDuesByCaptainUserIdAndOrderCreationDate($captainUserId, $orderCreatedAt);

        if ($captainFinancialDue === CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
            return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
        }

        // 2 get which financial system has the captain subscribed with
        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($captainUserId);

        if ($financialSystemDetail) {
            if (count($financialSystemDetail) > 0) {
                if ($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_DEFAULT_SYSTEM_CONST) {
                    // 3 Calculate how much profit will the captain get from the order
                    $orderValue = $this->captainFinancialDefaultSystemGetBalanceService->calculateCaptainFinancialAmountForSingleOrderByOrderDistance($orderDistance,
                        $financialSystemDetail);

                    if ($orderValue != 0) {
                        // 4 Add half of the order value to the captain financial due (amount field)
                        $valueToBeAdded = round($orderValue / 2, 1);

                        return $this->addValueToCaptainFinancialDueAmount($captainUserId, $valueToBeAdded, $orderCreatedAt);
                    }
                }
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }

    /**
     * Calculates and subtract half of order value from the captain financial due
     */
    public function subtractHalfOrderValueFromCaptainFinancialDue(int $captainUserId, DateTimeInterface $orderCreatedAt, ?float $orderDistance): CaptainFinancialDuesEntity|int|string
    {
        // 1 get captain financial due
        $captainFinancialDue = $this->getCaptainFinancialDuesByCaptainUserIdAndOrderCreationDate($captainUserId, $orderCreatedAt);

        if ($captainFinancialDue === CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
            return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
        }

        // 2 get which financial system has the captain subscribed with
        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($captainUserId);

        if ($financialSystemDetail) {
            if (count($financialSystemDetail) > 0) {
                if ($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_DEFAULT_SYSTEM_CONST) {
                    // 3 Calculate how much profit will the captain get from the order
                    $orderValue = $this->captainFinancialDefaultSystemGetBalanceService->calculateCaptainFinancialAmountForSingleOrderByOrderDistance($orderDistance,
                        $financialSystemDetail);

                    if ($orderValue != 0) {
                        // 4 Add half of the order value to the captain financial due (amount field)
                        $valueToBeAdded = round($orderValue / 2, 1);

                        return $this->subtractValueFromCaptainFinancialDueAmount($captainUserId, $valueToBeAdded, $orderCreatedAt);
                    }
                }
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }

    /**
     * Calculates and subtracts order value from the captain financial due
     */
    public function subtractOrderValueFromCaptainFinancialDue(int $captainUserId, DateTimeInterface $orderCreatedAt, ?float $orderDistance): CaptainFinancialDuesEntity|int|string
    {
        // 1 get captain financial due
        $captainFinancialDue = $this->getCaptainFinancialDuesByCaptainUserIdAndOrderCreationDate($captainUserId, $orderCreatedAt);

        if ($captainFinancialDue === CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
            return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
        }

        // 2 get which financial system has the captain subscribed with
        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($captainUserId);

        if ($financialSystemDetail) {
            if (count($financialSystemDetail) > 0) {
                if ($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_DEFAULT_SYSTEM_CONST) {
                    // 3 Calculate how much profit will the captain get from the order
                    $orderValue = $this->captainFinancialDefaultSystemGetBalanceService->calculateCaptainFinancialAmountForSingleOrderByOrderDistance($orderDistance,
                        $financialSystemDetail);

                    if ($orderValue != 0) {
                        // 4 Add half of the order value to the captain financial due (amount field)
                        return $this->subtractValueFromCaptainFinancialDueAmount($captainUserId, $orderValue, $orderCreatedAt);
                    }
                }
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }

    /**
     * Add or Subtract half order/full order value to/from CaptainOrderFinancial
     */
    public function addOrSubtractCaptainOrderFinancial(int $orderId, int $captainUserId, int $captainProfileId, int $operationType, bool $halfOrderValue): CaptainOrderFinancialEntity|int|string
    {//dd($orderId, $operationType, $halfOrderValue);
        $orderEntity = $this->entityManager->getRepository(OrderEntity::class)->findOneBy(['id' => $orderId]);

        if ($orderEntity) {
            //dd($orderId, $operationType, $halfOrderValue, $orderEntity);
                $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($captainUserId);

                //dd($orderId, $operationType, $halfOrderValue, $financialSystemDetail);
                if ($financialSystemDetail) {
                    if (count($financialSystemDetail) > 0) {
                        $captainFinancialDues = $this->getCaptainFinancialDueByCaptainProfileIdAndOrderCreationDate($captainProfileId,
                            $orderEntity->getCreatedAt());

                        //dd($orderId, $operationType, $halfOrderValue, $captainFinancialDues);
                        if ($captainFinancialDues !== CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
                            if ($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_DEFAULT_SYSTEM_CONST) {
                                $financialDues = $this->captainFinancialDefaultSystemGetBalanceService->calculateCaptainDues($financialSystemDetail,
                                    $orderId);

                                $captainOrderFinancial = $this->entityManager->getRepository(CaptainOrderFinancialEntity::class)
                                    ->findOneBy(['orderId' => $orderId]);
                                //dd($orderId, $operationType, $halfOrderValue, $captainOrderFinancial);
                                if (! $captainOrderFinancial) {
                                    // order value not exist, we want to create it
                                    if ($operationType === CaptainFinancialSystem::OPERATION_TYPE_ADDITION_CONST) {
                                        if ($halfOrderValue === CaptainFinancialSystem::HALF_ORDER_VALUE_CONST) {
                                            // add half order value
                                            $financialDues['financialDues'] = round($financialDues['financialDues'] / 2,
                                                1);
                                            return $this->createCaptainOrderFinancial($orderId, $financialDues, $captainFinancialDues);
                                        }
                                        // add full order value
                                        return $this->createCaptainOrderFinancial($orderId, $financialDues, $captainFinancialDues);
                                    }

                                } else {//dd($operationType, $halfOrderValue);
                                    // order value exists, update it
                                    if ($operationType === CaptainFinancialSystem::OPERATION_TYPE_SUBTRACTION_CONST) {
                                        if ($halfOrderValue === CaptainFinancialSystem::HALF_ORDER_VALUE_CONST) {
                                            // subtract half of order value by updating it
                                            $captainOrderFinancial->setProfit(round($financialDues['financialDues'] / 2,
                                                1));
                                            $captainOrderFinancial->setCashAmount($financialDues['amountForStore']);
                                            $captainOrderFinancial->setFinalProfit($financialDues['financialDues'] - $financialDues['amountForStore']);

                                            $this->entityManager->flush();

                                            return $captainOrderFinancial;
                                        }//dd($orderId);
                                        // subtract full order value by updating it
                                        $captainOrderFinancial->setProfit(0.0);
                                        $captainOrderFinancial->setCashAmount($financialDues['amountForStore']);
                                        $captainOrderFinancial->setFinalProfit(0.0 - $financialDues['amountForStore']);

                                        $this->entityManager->flush();

                                        return $captainOrderFinancial;
                                    }
                                }
                            }

                            return CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_IS_NOT_THE_DEFAULT_SYSTEM_CONST;
                        }

                        return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
                    }

                    return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
                }

                return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
        }

        return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
    }
}
