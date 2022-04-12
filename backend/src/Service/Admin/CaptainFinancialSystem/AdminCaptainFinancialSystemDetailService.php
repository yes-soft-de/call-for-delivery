<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailManager;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\CaptainPayment\CaptainPaymentService;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemOneBalanceDetailService;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;

class AdminCaptainFinancialSystemDetailService
{
    private AdminCaptainFinancialSystemDetailManager $adminCaptainFinancialSystemDetailManager;
    private CaptainPaymentService $captainPaymentService;
    private AdminCaptainFinancialSystemOneBalanceDetailService $adminCaptainFinancialSystemOneBalanceDetailService;

    public function __construct(CaptainPaymentService $captainPaymentService, AdminCaptainFinancialSystemOneBalanceDetailService $adminCaptainFinancialSystemOneBalanceDetailService, AdminCaptainFinancialSystemDetailManager $adminCaptainFinancialSystemDetailManager)
    {
        $this->captainPaymentService = $captainPaymentService;
        $this->adminCaptainFinancialSystemOneBalanceDetailService = $adminCaptainFinancialSystemOneBalanceDetailService;
        $this->adminCaptainFinancialSystemDetailManager = $adminCaptainFinancialSystemDetailManager;
    }

    public function getBalanceDetailForAdmin(int $captainId): AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse|string
    {
        //get Captain Financial System Detail current
        $financialSystemDetail = $this->adminCaptainFinancialSystemDetailManager->getCaptainFinancialSystemDetailForAdmin($captainId);
       
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
