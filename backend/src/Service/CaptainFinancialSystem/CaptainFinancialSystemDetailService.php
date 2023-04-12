<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemDetailManager;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemDetailResponse;
use App\Request\CaptainFinancialSystem\CaptainFinancialSystemDetailRequest;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemOne\CaptainFinancialSystemOneGetBalanceDetailsService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemThree\CaptainFinancialSystemThreeGetBalanceDetailsService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemTwo\CaptainFinancialSystemTwoGetBalanceDetailsService;
use App\Service\CaptainPayment\CaptainPaymentService;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse;
use App\Service\CaptainFinancialSystemDate\CaptainFinancialSystemDateService;
use DateTime;

class CaptainFinancialSystemDetailService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager,
        private CaptainPaymentService $captainPaymentService,
        private CaptainFinancialSystemAccordingOnOrderService $captainFinancialSystemAccordingOnOrderService,
        private CaptainFinancialSystemDateService $captainFinancialSystemDateService,
        private CaptainFinancialDuesService $captainFinancialDuesService,
        private CaptainFinancialSystemTwoGetBalanceDetailsService $captainFinancialSystemTwoGetBalanceDetailsService,
        private CaptainFinancialSystemThreeGetBalanceDetailsService $captainFinancialSystemThreeGetBalanceDetailsService,
        private CaptainFinancialSystemOneGetBalanceDetailsService $captainFinancialSystemOneGetBalanceDetailsService
    )
    {
    }

    public function createCaptainFinancialSystemDetail(CaptainFinancialSystemDetailRequest $request): CaptainFinancialSystemDetailResponse|string
    {
        $captainFinancialSystemDetailEntity = $this->captainFinancialSystemDetailManager->createCaptainFinancialSystemDetail($request);
      
        if ($captainFinancialSystemDetailEntity === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE) {
            return CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE;
        }

        return $this->autoMapping->map(CaptainFinancialSystemDetailEntity::class, CaptainFinancialSystemDetailResponse::class, $captainFinancialSystemDetailEntity);
    }

    public function getBalanceDetailForCaptain(int $userId): CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse|string|CaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse|array
    {
        $this->captainFinancialDuesService->updateCaptainFinancialSystemDetail($userId);

        //get Captain Financial System Detail current
        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($userId);
       
        if ($financialSystemDetail) {
           $captainFinancialDues = $this->captainFinancialDuesService->getLatestCaptainFinancialDues($financialSystemDetail['captainId']);

           if ($captainFinancialDues ) {
               $date = ["fromDate" => $captainFinancialDues['startDate']->format('Y-m-d 00:00:00'), "toDate" => $captainFinancialDues['endDate']->format('y-m-d 23:59:59')];

               $sumPayments = $this->getSumPayments($financialSystemDetail['captainId'], $captainFinancialDues['startDate'], $captainFinancialDues['endDate']);

               $countWorkdays = $this->captainFinancialSystemDateService->subtractTwoDates(new DateTime ($date ['fromDate']), new DateTime($date['toDate']));

           } else {
               $dateForPayments = $this->captainFinancialSystemDateService->getFromDateAndToDate();

               $sumPayments = $this->getSumPayments($financialSystemDetail['captainId'], $dateForPayments['fromDate'], $dateForPayments['toDate']);

               $date = $this->captainFinancialSystemDateService->getFromDateAndToDateForCaptainFinancialSystemOneAndThtree();
           }
            
            if ($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
                // *** Habib code ***
                //return $this->captainFinancialSystemOneBalanceDetailService->getBalanceDetailWithSystemOne($financialSystemDetail, $financialSystemDetail['captainId'], $sumPayments, $date, $countWorkdays);
                // *** End of Habib code ***

                // *** Rami code ***
                return $this->captainFinancialSystemOneGetBalanceDetailsService->getBalanceDetails($financialSystemDetail,
                    $financialSystemDetail['captainId'], $sumPayments, $date, $countWorkdays);
                // *** End of Rami code ***
            }

            if ($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {

                // *** Habib code ***
                // return $this->captainFinancialSystemTwoBalanceDetailService->getBalanceDetailWithSystemTwo($financialSystemDetail, $financialSystemDetail['captainId'], $sumPayments, $date, $countWorkdays);
                // *** End of Habib code ***

                // *** Rami code ***
                return $this->captainFinancialSystemTwoGetBalanceDetailsService->getBalanceDetails($financialSystemDetail['captainId'],
                    $date, $sumPayments, $financialSystemDetail);
                // *** End of Rami code ***
            }

            if ($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
              
                $choseFinancialSystemDetails = $this->captainFinancialSystemAccordingOnOrderService->getCaptainFinancialSystemAccordingOnOrder();

                // *** Habib code ***
                //return $this->captainFinancialSystemThreeBalanceDetailService->getBalanceDetailWithSystemThree($choseFinancialSystemDetails, $financialSystemDetail['captainId'], $sumPayments, $date);
                // *** End of Habib code ***

                // *** Rami code ***
                return $this->captainFinancialSystemThreeGetBalanceDetailsService->getBalanceDetails($choseFinancialSystemDetails,
                    $financialSystemDetail['captainId'], $sumPayments, $date);
                // *** End of Rami code ***
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
