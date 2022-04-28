<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailManager;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Service\CaptainPayment\CaptainPaymentService;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemOneBalanceDetailService;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemTwoBalanceDetailService;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailUpdateRequest;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailUpdateResponse;
use App\AutoMapping;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemThreeBalanceDetailService;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingOnOrderService;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse;
use App\Service\CaptainFinancialSystemDate\CaptainFinancialSystemDateService;

class AdminCaptainFinancialSystemDetailService
{
    private AdminCaptainFinancialSystemDetailManager $adminCaptainFinancialSystemDetailManager;
    private CaptainPaymentService $captainPaymentService;
    private AdminCaptainFinancialSystemOneBalanceDetailService $adminCaptainFinancialSystemOneBalanceDetailService;
    private AdminCaptainFinancialSystemTwoBalanceDetailService $adminCaptainFinancialSystemTwoBalanceDetailService;
    private AutoMapping $autoMapping;
    private AdminCaptainFinancialSystemThreeBalanceDetailService $adminCaptainFinancialSystemThreeBalanceDetailService;
    private AdminCaptainFinancialSystemAccordingOnOrderService $adminCaptainFinancialSystemAccordingOnOrderService;
    private CaptainFinancialSystemDateService $captainFinancialSystemDateService;

    public function __construct(CaptainPaymentService $captainPaymentService, AdminCaptainFinancialSystemOneBalanceDetailService $adminCaptainFinancialSystemOneBalanceDetailService, AdminCaptainFinancialSystemDetailManager $adminCaptainFinancialSystemDetailManager, AdminCaptainFinancialSystemTwoBalanceDetailService $adminCaptainFinancialSystemTwoBalanceDetailService, AutoMapping $autoMapping, AdminCaptainFinancialSystemThreeBalanceDetailService $adminCaptainFinancialSystemThreeBalanceDetailService, AdminCaptainFinancialSystemAccordingOnOrderService $adminCaptainFinancialSystemAccordingOnOrderService, CaptainFinancialSystemDateService $captainFinancialSystemDateService)
    {
        $this->captainPaymentService = $captainPaymentService;
        $this->adminCaptainFinancialSystemOneBalanceDetailService = $adminCaptainFinancialSystemOneBalanceDetailService;
        $this->adminCaptainFinancialSystemDetailManager = $adminCaptainFinancialSystemDetailManager;
        $this->adminCaptainFinancialSystemTwoBalanceDetailService = $adminCaptainFinancialSystemTwoBalanceDetailService;
        $this->autoMapping = $autoMapping;
        $this->adminCaptainFinancialSystemThreeBalanceDetailService = $adminCaptainFinancialSystemThreeBalanceDetailService;
        $this->adminCaptainFinancialSystemAccordingOnOrderService = $adminCaptainFinancialSystemAccordingOnOrderService;
        $this->captainFinancialSystemDateService = $captainFinancialSystemDateService;
    }

    public function getBalanceDetailForAdmin(int $captainId): AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse|string|AdminCaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse|array 
    {
        //get Captain Financial System Detail current
        $financialSystemDetail = $this->adminCaptainFinancialSystemDetailManager->getCaptainFinancialSystemDetailForAdmin($captainId);
    
        if($financialSystemDetail) {
             //sum captain's payments
             $sumPayments = $this->getSumPayments($captainId);         
          
            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
                $date = $this->captainFinancialSystemDateService->getFromDateAndToDateForCaptainFinancialSystemOneAndThtree();
               
                return $this->adminCaptainFinancialSystemOneBalanceDetailService->getBalanceDetailWithSystemOne($financialSystemDetail, $captainId, $sumPayments, $date);
            }

            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
               $choseFinancialSystemDetails = $this->adminCaptainFinancialSystemAccordingOnOrderService->getCaptainFinancialSystemAccordingOnOrder();
              
               $date = $this->captainFinancialSystemDateService->getFromDateAndToDateForCaptainFinancialSystemOneAndThtree();
              
               return $this->adminCaptainFinancialSystemThreeBalanceDetailService->getBalanceDetailWithSystemThree($choseFinancialSystemDetails, $captainId, $sumPayments, $date);
            } 
            
            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {
                $date = $this->captainFinancialSystemDateService->getFromDateAndToDateForCaptainFinancialSystemTwo();
        
                return $this->adminCaptainFinancialSystemTwoBalanceDetailService->adminGetBalanceDetailWithSystemTwo($financialSystemDetail, $captainId, $sumPayments, $date);
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
    
    public function getSumPayments($captainId): float 
    {
        $date = $this->captainFinancialSystemDateService->getFromDateAndToDate();
     
        //Sum Captain's Payments
        $sumPayments = $this->captainPaymentService->getSumPaymentsToCaptainByCaptainIdAndDate($date['fromDate'], $date['toDate'], $captainId);
        if($sumPayments['sumPaymentsToCaptain'] === null) {
            $sumPayments = 0;
        }
        else {
            $sumPayments = $sumPayments['sumPaymentsToCaptain'];
        }

        return $sumPayments;
    }
}
