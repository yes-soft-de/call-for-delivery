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
use  App\Service\CaptainFinancialSystem\CaptainFinancialDuesService;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailUpdateByAdminRequest;
use DateTime;
use App\Service\Admin\Order\AdminOrderService;

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
    private CaptainFinancialDuesService $captainFinancialDuesService;
    private AdminOrderService $adminOrderService;

    public function __construct(CaptainPaymentService $captainPaymentService, AdminCaptainFinancialSystemOneBalanceDetailService $adminCaptainFinancialSystemOneBalanceDetailService, AdminCaptainFinancialSystemDetailManager $adminCaptainFinancialSystemDetailManager, AdminCaptainFinancialSystemTwoBalanceDetailService $adminCaptainFinancialSystemTwoBalanceDetailService, AutoMapping $autoMapping, AdminCaptainFinancialSystemThreeBalanceDetailService $adminCaptainFinancialSystemThreeBalanceDetailService, AdminCaptainFinancialSystemAccordingOnOrderService $adminCaptainFinancialSystemAccordingOnOrderService, CaptainFinancialSystemDateService $captainFinancialSystemDateService, CaptainFinancialDuesService $captainFinancialDuesService, AdminOrderService $adminOrderService)
    {
        $this->captainPaymentService = $captainPaymentService;
        $this->adminCaptainFinancialSystemOneBalanceDetailService = $adminCaptainFinancialSystemOneBalanceDetailService;
        $this->adminCaptainFinancialSystemDetailManager = $adminCaptainFinancialSystemDetailManager;
        $this->adminCaptainFinancialSystemTwoBalanceDetailService = $adminCaptainFinancialSystemTwoBalanceDetailService;
        $this->autoMapping = $autoMapping;
        $this->adminCaptainFinancialSystemThreeBalanceDetailService = $adminCaptainFinancialSystemThreeBalanceDetailService;
        $this->adminCaptainFinancialSystemAccordingOnOrderService = $adminCaptainFinancialSystemAccordingOnOrderService;
        $this->captainFinancialSystemDateService = $captainFinancialSystemDateService;
        $this->captainFinancialDuesService = $captainFinancialDuesService;
        $this->adminOrderService = $adminOrderService;

    }

    public function getBalanceDetailForAdmin(int $captainId): AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse|string|AdminCaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse|array 
    {
        //get Captain Financial System Detail current
        $financialSystemDetail = $this->adminCaptainFinancialSystemDetailManager->getCaptainFinancialSystemDetailForAdmin($captainId);
    
        if($financialSystemDetail) {

            $captainFinancialDues = $this->captainFinancialDuesService->getLatestCaptainFinancialDues
            ($captainId);
            if($captainFinancialDues ) {
                $date = ["fromDate" => $captainFinancialDues['startDate']->format('Y-m-d 00:00:00'), "toDate" => $captainFinancialDues['endDate']->format('y-m-d 23:59:59')];
        
                $sumPayments = $this->getSumPayments($captainId, $captainFinancialDues['startDate'], $captainFinancialDues['endDate']);

                $countWorkdays = $this->captainFinancialSystemDateService->subtractTwoDates(new DateTime ($date ['fromDate']), new DateTime($date['toDate']));
            }

            else {
                $dateForPayments = $this->captainFinancialSystemDateService->getFromDateAndToDate(); 

                $sumPayments = $this->getSumPayments($captainId, $dateForPayments['fromDate'], $dateForPayments['toDate']);

                $date = $this->captainFinancialSystemDateService->getFromDateAndToDateForCaptainFinancialSystemOneAndThtree();
            }
            
            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
             
                return $this->adminCaptainFinancialSystemOneBalanceDetailService->getBalanceDetailWithSystemOne($financialSystemDetail, $captainId, $sumPayments, $date, $countWorkdays);
            }

            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
               $choseFinancialSystemDetails = $this->adminCaptainFinancialSystemAccordingOnOrderService->getCaptainFinancialSystemAccordingOnOrder();
              
               return $this->adminCaptainFinancialSystemThreeBalanceDetailService->getBalanceDetailWithSystemThree($choseFinancialSystemDetails, $captainId, $sumPayments, $date);
            } 
            
            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {
                return $this->adminCaptainFinancialSystemTwoBalanceDetailService->adminGetBalanceDetailWithSystemTwo($financialSystemDetail, $captainId, $sumPayments, $date, $countWorkdays);
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
      
        if($result) {
            // Calculation of financial dues on the new system 
            $this->captainFinancialDuesService->captainFinancialDues($result->getCaptain()->getCaptainId());
        }

        return $this->autoMapping->map(CaptainFinancialSystemDetailEntity::class, AdminCaptainFinancialSystemDetailUpdateResponse::class, $result);
    }
    
    public function getSumPayments($captainId, $fromDate, $toDate): float 
    {
        // $date = $this->captainFinancialSystemDateService->getFromDateAndToDate();
     
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
    
    public function captainFinancialSystemDetailUpdate(AdminCaptainFinancialSystemDetailUpdateByAdminRequest $request): AdminCaptainFinancialSystemDetailUpdateResponse|string 
    {
        $result = $this->adminCaptainFinancialSystemDetailManager->captainFinancialSystemDetailUpdate($request);
        if ($result === CaptainFinancialSystem::NOT_UPDATE_FINANCIAL_SYSTEM_ACTIVE) {
            return CaptainFinancialSystem::NOT_UPDATE_FINANCIAL_SYSTEM_ACTIVE;
        }
       
        return $this->autoMapping->map(CaptainFinancialSystemDetailEntity::class, AdminCaptainFinancialSystemDetailUpdateResponse::class, $result);
    }

    //calculate orders that not belong to any financial dues
    public function calculateOrdersThatNotBelongToAnyFinancialDues() 
    {
       $orders = $this->adminOrderService->getOrders();

       $this->captainFinancialDuesService->calculateOrdersThatNotBelongToAnyFinancialDues($orders);     
    }
}
