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

class CaptainFinancialSystemDetailService
{
    private CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager;
    private AutoMapping $autoMapping;
    private CaptainPaymentService $captainPaymentService;
    private CaptainFinancialSystemOneBalanceDetailService $captainFinancialSystemOneBalanceDetailService;
    private CaptainFinancialSystemTwoBalanceDetailService $captainFinancialSystemTwoBalanceDetailService;
    private CaptainFinancialSystemThreeBalanceDetailService $captainFinancialSystemThreeBalanceDetailService;
    private CaptainFinancialSystemAccordingOnOrderService $captainFinancialSystemAccordingOnOrderService;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager, CaptainPaymentService $captainPaymentService, CaptainFinancialSystemOneBalanceDetailService $captainFinancialSystemOneBalanceDetailService, CaptainFinancialSystemTwoBalanceDetailService $captainFinancialSystemTwoBalanceDetailService, CaptainFinancialSystemThreeBalanceDetailService $captainFinancialSystemThreeBalanceDetailService, CaptainFinancialSystemAccordingOnOrderService $captainFinancialSystemAccordingOnOrderService)
    {
        $this->captainFinancialSystemDetailManager = $captainFinancialSystemDetailManager;
        $this->autoMapping = $autoMapping;
        $this->captainPaymentService = $captainPaymentService;
        $this->captainFinancialSystemOneBalanceDetailService = $captainFinancialSystemOneBalanceDetailService;
        $this->captainFinancialSystemTwoBalanceDetailService = $captainFinancialSystemTwoBalanceDetailService;
        $this->captainFinancialSystemThreeBalanceDetailService = $captainFinancialSystemThreeBalanceDetailService;
        $this->captainFinancialSystemAccordingOnOrderService = $captainFinancialSystemAccordingOnOrderService;
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
        //get Captain Financial System Detail current
        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($userId);
       
        if($financialSystemDetail) {
             //sum captain's payments
            $sumPayments = $this->captainPaymentService->getSumPayments($financialSystemDetail['captainId']);
       
            if($sumPayments['sumPayments'] === null) {
                $sumPayments = 0;
            }
            else {
                $sumPayments = $sumPayments['sumPayments'];
            }
           
            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
                return $this->captainFinancialSystemOneBalanceDetailService->getBalanceDetailWithSystemOne($financialSystemDetail, $financialSystemDetail['captainId'], $sumPayments);
            }

            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {
                return $this->captainFinancialSystemTwoBalanceDetailService->getBalanceDetailWithSystemTwo($financialSystemDetail, $financialSystemDetail['captainId'], $sumPayments);
            }

            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
              
                $choseFinancialSystemDetails = $this->captainFinancialSystemAccordingOnOrderService->getCaptainFinancialSystemAccordingOnOrder();
                       
                return $this->captainFinancialSystemThreeBalanceDetailService->getBalanceDetailWithSystemThree($financialSystemDetail, $choseFinancialSystemDetails, $financialSystemDetail['captainId'], $sumPayments);
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }
}
