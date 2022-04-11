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
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemOneBalanceDetailService;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;

class CaptainFinancialSystemDetailService
{
    private CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager;
    private AutoMapping $autoMapping;
    private CaptainPaymentService $captainPaymentService;
    private CaptainFinancialSystemOneBalanceDetailService $captainFinancialSystemOneBalanceDetailService;
    private AdminCaptainFinancialSystemOneBalanceDetailService $adminCaptainFinancialSystemOneBalanceDetailService;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager, CaptainPaymentService $captainPaymentService, CaptainFinancialSystemOneBalanceDetailService $captainFinancialSystemOneBalanceDetailService, AdminCaptainFinancialSystemOneBalanceDetailService $adminCaptainFinancialSystemOneBalanceDetailService)
    {
        $this->captainFinancialSystemDetailManager = $captainFinancialSystemDetailManager;
        $this->autoMapping = $autoMapping;
        $this->captainPaymentService = $captainPaymentService;
        $this->captainFinancialSystemOneBalanceDetailService = $captainFinancialSystemOneBalanceDetailService;
        $this->adminCaptainFinancialSystemOneBalanceDetailService = $adminCaptainFinancialSystemOneBalanceDetailService;
    }

    public function createCaptainFinancialSystemDetail(CaptainFinancialSystemDetailRequest $request): CaptainFinancialSystemDetailResponse|string
    {
        $captainFinancialSystemDetailEntity = $this->captainFinancialSystemDetailManager->createCaptainFinancialSystemDetail($request);
      
        if($captainFinancialSystemDetailEntity === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE) {
            return CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE;
        }

        return $this->autoMapping->map(CaptainFinancialSystemDetailEntity::class, CaptainFinancialSystemDetailResponse::class, $captainFinancialSystemDetailEntity);
    }

    public function getBalanceDetailForCaptain(int $userId):CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse|string
    {
        //get Captain Financial System Detail current
        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($userId);
       
        if($financialSystemDetail) {
             //sum captain's payments
            $sumPayments = $this->captainPaymentService->getSumPayments($financialSystemDetail['captainId']);
       
            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
                return $this->captainFinancialSystemOneBalanceDetailService->getBalanceDetailWithSystemOne($financialSystemDetail, $financialSystemDetail['captainId'], $sumPayments['sumPayments']);
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }

    public function getBalanceDetailForAdmin(int $captainId): AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse|string
    {
        //get Captain Financial System Detail current
        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailForAdmin($captainId);
       
        if($financialSystemDetail) {
             //sum captain's payments
            $sumPayments = $this->captainPaymentService->getSumPayments($captainId);
       
            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
                return $this->adminCaptainFinancialSystemOneBalanceDetailService->getBalanceDetailWithSystemOne( $financialSystemDetail, $captainId, $sumPayments['sumPayments']);
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }
}
