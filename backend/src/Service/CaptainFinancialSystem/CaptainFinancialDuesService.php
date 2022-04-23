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

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager, CaptainFinancialSystemOneBalanceDetailService $captainFinancialSystemOneBalanceDetailService, CaptainFinancialSystemTwoBalanceDetailService $captainFinancialSystemTwoBalanceDetailService, CaptainFinancialSystemThreeBalanceDetailService $captainFinancialSystemThreeBalanceDetailService, CaptainFinancialSystemAccordingOnOrderService $captainFinancialSystemAccordingOnOrderService, CaptainFinancialSystemDateService $captainFinancialSystemDateService, CaptainFinancialDuesManager $captainFinancialDuesManager)
    {
        $this->captainFinancialSystemDetailManager = $captainFinancialSystemDetailManager;
        $this->captainFinancialSystemOneBalanceDetailService = $captainFinancialSystemOneBalanceDetailService;
        $this->captainFinancialSystemTwoBalanceDetailService = $captainFinancialSystemTwoBalanceDetailService;
        $this->captainFinancialSystemThreeBalanceDetailService = $captainFinancialSystemThreeBalanceDetailService;
        $this->captainFinancialSystemAccordingOnOrderService = $captainFinancialSystemAccordingOnOrderService;
        $this->captainFinancialSystemDateService = $captainFinancialSystemDateService;
        $this->captainFinancialDuesManager = $captainFinancialDuesManager;
        $this->autoMapping = $autoMapping;
    }

    public function captainFinancialDues(int $userId)
    {
        //get Captain Financial System Detail current
        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($userId);
       
        if($financialSystemDetail) {
                   
            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
               //Calculation of the financial cycle
                $date = $this->captainFinancialSystemDateService->getFromDateAndToDateForCaptainFinancialSystemOneAndThtree();
                $dateTime = $this->captainFinancialSystemDateService->getFromDateAndToDate();
               //Calculation of financial dues
                $financialDues = $this->captainFinancialSystemOneBalanceDetailService->getFinancialDuesWithSystemOne($financialSystemDetail, $financialSystemDetail['captainId'], $date);
               //create or update captain financial dues
               return $this->createOrUpdateCaptainFinancialDues($financialDues, $dateTime, $financialSystemDetail['captainId'], CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
            }

            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {
                $date = $this->captainFinancialSystemDateService->getFromDateAndToDateForCaptainFinancialSystemTwo();
                $dateTime = $this->captainFinancialSystemDateService->getFromDateAndToDate();
                //Calculation of financial dues
                $financialDues = $this->captainFinancialSystemTwoBalanceDetailService->getFinancialDuesWithSystemTwo($financialSystemDetail, $financialSystemDetail['captainId'], $date);

                //create or update captain financial dues
               return $this->createOrUpdateCaptainFinancialDues($financialDues, $dateTime, $financialSystemDetail['captainId'], CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
            }

            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
              
                $choseFinancialSystemDetails = $this->captainFinancialSystemAccordingOnOrderService->getCaptainFinancialSystemAccordingOnOrder();
              
                $date = $this->captainFinancialSystemDateService->getFromDateAndToDateForCaptainFinancialSystemOneAndThtree();
                $dateTime = $this->captainFinancialSystemDateService->getFromDateAndToDate();
                       
                $financialDues = $this->captainFinancialSystemThreeBalanceDetailService->getFinancialDuesWithSystemThree($choseFinancialSystemDetails, $financialSystemDetail['captainId'], $date);
               //create or update captain financial dues
               return $this->createOrUpdateCaptainFinancialDues($financialDues, $dateTime, $financialSystemDetail['captainId'], CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }

    public function createOrUpdateCaptainFinancialDues(array $financialDues, array $date, int $captainId, int $status)
    {
        $captainFinancialDues = $this->captainFinancialDuesManager->getCaptainFinancialDues($captainId, $date);
        
        if($captainFinancialDues) {
            return $this->updateCaptainFinancialDuesAmount($captainFinancialDues, $financialDues);
        }

        return $this->createCaptainFinancialDues($financialDues, $date, $captainId, $status);
    }

    public function createCaptainFinancialDues(array $financialDues, array $date, int $captainId, int $status)
    {
        $request = new CreateCaptainFinancialDuesRequest();

        $request->setAmount($financialDues['financialDues']);
        $request->setStatus($status);
        $request->setStartDate($date['fromDate']);
        $request->setEndDate($date['toDate']);
        $request->setCaptain($captainId);

        return $this->captainFinancialDuesManager->createCaptainFinancialDues($request);
    }

    public function updateCaptainFinancialDuesAmount(CaptainFinancialDuesEntity $captainFinancialDues, array $financialDues)
    {
        $captainFinancialDues->setAmount($financialDues['financialDues']);
        
        return $this->captainFinancialDuesManager->updateCaptainFinancialDues($captainFinancialDues);
    }

    public function getCaptainFinancialDues(int $userId): array
    {        
        $response = [];

        $captainFinancialDues = $this->captainFinancialDuesManager->getCaptainFinancialDuesByUserId($userId);

        foreach ($captainFinancialDues as $captainFinancialDue) {

            $response[] = $this->autoMapping->map('array', CaptainFinancialDuesResponse::class, $captainFinancialDue);
        }

        return $response;
    }
}
