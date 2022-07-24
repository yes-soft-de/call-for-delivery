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

    public function captainFinancialDues(int $userId)
    {
        //get Captain Financial System Detail current
        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($userId);
        
        if($financialSystemDetail) {
            //Get Captain's Active Financial Dues 
            $captainFinancialDues = $this->captainFinancialDuesManager->getCaptainFinancialDuesByUserIDAndState($userId, CaptainFinancialDues::FINANCIAL_STATE_ACTIVE);
          
            if(! $captainFinancialDues) {
                // Create Captain Financial Dues
                $captainFinancialDues = $this->createCaptainFinancialDues($financialSystemDetail['captainId'], CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
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

                //create or update captain financial dues
               return $this->updateCaptainFinancialDuesAmount($captainFinancialDues, $financialDues);
            }

            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
              
                $choseFinancialSystemDetails = $this->captainFinancialSystemAccordingOnOrderService->getCaptainFinancialSystemAccordingOnOrder();
                       
                $financialDues = $this->captainFinancialSystemThreeBalanceDetailService->getFinancialDuesWithSystemThree($choseFinancialSystemDetails, $financialSystemDetail['captainId'], $date);
               //create or update captain financial dues
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
       
        $captainFinancialDues['sumCaptainFinancialDues'] =  $sumCaptainFinancialDues['sumCaptainFinancialDues'];
        $captainFinancialDues['sumPaymentsToCaptain'] = $sumPaymentsToCaptain['sumPaymentsToCaptain'];
        $captainFinancialDues['total'] = abs($total);

        return $captainFinancialDues;
    }
    
    public function getLatestCaptainFinancialDues(int $captainId): ?array
    {        
        return $this->captainFinancialDuesManager->getLatestCaptainFinancialDues($captainId);
    }
    // Deactivation of the financial system in the event of the end of the financial cycle date
    // public function updateCaptainFinancialSystemDetail(int $userId): CaptainFinancialSystemDetailEntity|null      
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
}
