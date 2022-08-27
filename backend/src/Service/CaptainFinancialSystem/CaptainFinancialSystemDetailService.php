<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemDetailManager;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemDetailResponse;
use App\Request\CaptainFinancialSystem\CaptainFinancialSystemDetailRequest;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;
use App\Service\CaptainPayment\CaptainPaymentService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemOneBalanceDetailService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwoBalanceDetailService;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemThreeBalanceDetailService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemAccordingOnOrderService;
use App\Service\CaptainFinancialSystemDate\CaptainFinancialSystemDateService;
use  App\Service\CaptainFinancialSystem\CaptainFinancialDuesService;
use DateTime;

class CaptainFinancialSystemDetailService
{
    private CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager;
    private AutoMapping $autoMapping;
    private CaptainPaymentService $captainPaymentService;
    private CaptainFinancialSystemOneBalanceDetailService $captainFinancialSystemOneBalanceDetailService;
    private CaptainFinancialSystemTwoBalanceDetailService $captainFinancialSystemTwoBalanceDetailService;
    private CaptainFinancialSystemThreeBalanceDetailService $captainFinancialSystemThreeBalanceDetailService;
    private CaptainFinancialSystemAccordingOnOrderService $captainFinancialSystemAccordingOnOrderService;
    private CaptainFinancialSystemDateService $captainFinancialSystemDateService;
    private CaptainFinancialDuesService $captainFinancialDuesService;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager, CaptainPaymentService $captainPaymentService, CaptainFinancialSystemOneBalanceDetailService $captainFinancialSystemOneBalanceDetailService, CaptainFinancialSystemTwoBalanceDetailService $captainFinancialSystemTwoBalanceDetailService, CaptainFinancialSystemThreeBalanceDetailService $captainFinancialSystemThreeBalanceDetailService, CaptainFinancialSystemAccordingOnOrderService $captainFinancialSystemAccordingOnOrderService, CaptainFinancialSystemDateService $captainFinancialSystemDateService, CaptainFinancialDuesService $captainFinancialDuesService)
    {
        $this->captainFinancialSystemDetailManager = $captainFinancialSystemDetailManager;
        $this->autoMapping = $autoMapping;
        $this->captainPaymentService = $captainPaymentService;
        $this->captainFinancialSystemOneBalanceDetailService = $captainFinancialSystemOneBalanceDetailService;
        $this->captainFinancialSystemTwoBalanceDetailService = $captainFinancialSystemTwoBalanceDetailService;
        $this->captainFinancialSystemThreeBalanceDetailService = $captainFinancialSystemThreeBalanceDetailService;
        $this->captainFinancialSystemAccordingOnOrderService = $captainFinancialSystemAccordingOnOrderService;
        $this->captainFinancialSystemDateService = $captainFinancialSystemDateService;
        $this->captainFinancialDuesService = $captainFinancialDuesService;
    }

    public function createCaptainFinancialSystemDetail(CaptainFinancialSystemDetailRequest $request): CaptainFinancialSystemDetailResponse|string
    {
        $captainFinancialSystemDetailEntity = $this->captainFinancialSystemDetailManager->createCaptainFinancialSystemDetail($request);
      
        if($captainFinancialSystemDetailEntity === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE) {
            return CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE;
        }

        return $this->autoMapping->map(CaptainFinancialSystemDetailEntity::class, CaptainFinancialSystemDetailResponse::class, $captainFinancialSystemDetailEntity);
    }

    public function getBalanceDetailForCaptain(int $userId):CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse|string|CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse|array
    {
        $this->captainFinancialDuesService->updateCaptainFinancialSystemDetail($userId);

        //get Captain Financial System Detail current
        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($userId);
       
        if($financialSystemDetail) {
           $captainFinancialDues = $this->captainFinancialDuesService->getLatestCaptainFinancialDues($financialSystemDetail['captainId']);
           if($captainFinancialDues ) {
                $date = ["fromDate" => $captainFinancialDues['startDate']->format('Y-m-d 00:00:00'), "toDate" => $captainFinancialDues['endDate']->format('y-m-d 23:59:59')];
        
                $sumPayments = $this->getSumPayments($financialSystemDetail['captainId'], $captainFinancialDues['startDate'], $captainFinancialDues['endDate']);

                $countWorkdays = $this->captainFinancialSystemDateService->subtractTwoDates(new DateTime ($date ['fromDate']), new DateTime($date['toDate']));
            }

            else {
                $dateForPayments = $this->captainFinancialSystemDateService->getFromDateAndToDate(); 

                $sumPayments = $this->getSumPayments($financialSystemDetail['captainId'], $dateForPayments['fromDate'], $dateForPayments['toDate']);

                $date = $this->captainFinancialSystemDateService->getFromDateAndToDateForCaptainFinancialSystemOneAndThtree();
            }
            
            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
                return $this->captainFinancialSystemOneBalanceDetailService->getBalanceDetailWithSystemOne($financialSystemDetail, $financialSystemDetail['captainId'], $sumPayments, $date, $countWorkdays);
            }

            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {

                return $this->captainFinancialSystemTwoBalanceDetailService->getBalanceDetailWithSystemTwo($financialSystemDetail, $financialSystemDetail['captainId'], $sumPayments, $date, $countWorkdays);
            }

            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
              
                $choseFinancialSystemDetails = $this->captainFinancialSystemAccordingOnOrderService->getCaptainFinancialSystemAccordingOnOrder();
                               
                return $this->captainFinancialSystemThreeBalanceDetailService->getBalanceDetailWithSystemThree($choseFinancialSystemDetails, $financialSystemDetail['captainId'], $sumPayments, $date);
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }

    public function getSumPayments($captainId, $fromDate, $toDate): float 
    {     
        //Sum Captain's Payments
        $sumPayments = $this->captainPaymentService->getSumPaymentsToCaptainByCaptainIdAndDate($fromDate, $toDate, $captainId);
        if($sumPayments['sumPaymentsToCaptain'] === null) {
            $sumPayments = 0;
        }
        else {
            $sumPayments = $sumPayments['sumPaymentsToCaptain'];
        }

        return $sumPayments;
    }

    public function deleteCaptainFinancialSystemDetailsByCaptainId(int $captainId): array
    {
        return $this->captainFinancialSystemDetailManager->deleteCaptainFinancialSystemDetailsByCaptainId($captainId);
    }
}
