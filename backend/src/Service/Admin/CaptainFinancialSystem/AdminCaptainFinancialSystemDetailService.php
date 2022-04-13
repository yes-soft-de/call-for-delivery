<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailManager;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\CaptainPayment\CaptainPaymentService;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemOneBalanceDetailService;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailUpdateRequest;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailUpdateResponse;
use App\AutoMapping;

class AdminCaptainFinancialSystemDetailService
{
    private AdminCaptainFinancialSystemDetailManager $adminCaptainFinancialSystemDetailManager;
    private CaptainPaymentService $captainPaymentService;
    private AdminCaptainFinancialSystemOneBalanceDetailService $adminCaptainFinancialSystemOneBalanceDetailService;
    private AutoMapping $autoMapping;

    public function __construct(CaptainPaymentService $captainPaymentService, AdminCaptainFinancialSystemOneBalanceDetailService $adminCaptainFinancialSystemOneBalanceDetailService, AdminCaptainFinancialSystemDetailManager $adminCaptainFinancialSystemDetailManager, AutoMapping $autoMapping)
    {
        $this->captainPaymentService = $captainPaymentService;
        $this->adminCaptainFinancialSystemOneBalanceDetailService = $adminCaptainFinancialSystemOneBalanceDetailService;
        $this->adminCaptainFinancialSystemDetailManager = $adminCaptainFinancialSystemDetailManager;
        $this->autoMapping = $autoMapping;
    }

    public function getBalanceDetailForAdmin(int $captainId): AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse|string
    {
        //get Captain Financial System Detail current
        $financialSystemDetail = $this->adminCaptainFinancialSystemDetailManager->getCaptainFinancialSystemDetailForAdmin($captainId);
       
        if($financialSystemDetail) {
             //sum captain's payments
            $sumPayments = $this->captainPaymentService->getSumPayments($captainId);
            if($sumPayments['sumPayments'] === null) {
                $sumPayments = 0;
            }
            else {
                $sumPayments = $sumPayments['sumPayments'];
            }
           
            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
                return $this->adminCaptainFinancialSystemOneBalanceDetailService->getBalanceDetailWithSystemOne( $financialSystemDetail, $captainId, $sumPayments);
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }
    
    public function getLatestFinancialCaptainSystemDetails(int $captainId): ?array
    {
       return $this->adminCaptainFinancialSystemDetailManager->getLatestFinancialCaptainSystemDetails($captainId);
    }
    
    public function updateStatusCaptainFinancialSystemDetail(AdminCaptainFinancialSystemDetailUpdateRequest $request): ?AdminCaptainFinancialSystemDetailUpdateResponse
    {
        $result = $this->adminCaptainFinancialSystemDetailManager->updateStatusCaptainFinancialSystemDetail($request);

        return $this->autoMapping->map(CaptainFinancialSystemDetailEntity::class, AdminCaptainFinancialSystemDetailUpdateResponse::class, $result);
    }
}
