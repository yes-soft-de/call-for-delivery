<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\Constant\Captain\CaptainConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Entity\CaptainEntity;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailManager;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Request\Admin\Account\CompleteAccountStatusUpdateByAdminRequest;
use App\Request\Admin\CaptainFinancialSystem\CaptainFinancialSystemDetailCreateByAdminRequest;
use App\Response\Admin\CaptainFinancialSystem\CaptainFinancialSystemDetailCreateByAdminResponse;
use App\Service\Admin\Captain\AdminCaptainService;
use App\Service\Admin\CaptainFinancialSystem\CaptainFinancialSystemOne\AdminCaptainFinancialSystemOneGetBalanceDetailsService;
use App\Service\Admin\CaptainFinancialSystem\CaptainFinancialSystemThree\AdminCaptainFinancialSystemThreeGetBalanceDetailsService;
use App\Service\Admin\CaptainFinancialSystem\CaptainFinancialSystemTwo\AdminCaptainFinancialSystemTwoGetBalanceDetailsService;
use App\Service\CaptainPayment\CaptainPaymentService;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailUpdateRequest;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailUpdateResponse;
use App\AutoMapping;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersBalanceDetailResponse;
use App\Service\CaptainFinancialSystemDate\CaptainFinancialSystemDateService;
use  App\Service\CaptainFinancialSystem\CaptainFinancialDuesService;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailUpdateByAdminRequest;
use DateTime;
use App\Service\Admin\Order\AdminOrderService;

class AdminCaptainFinancialSystemDetailService implements AdminCaptainFinancialSystemDetailInterface
{
    public function __construct(
        private CaptainPaymentService $captainPaymentService,
        private AdminCaptainFinancialSystemDetailManager $adminCaptainFinancialSystemDetailManager,
        private AutoMapping $autoMapping,
        private AdminCaptainFinancialSystemAccordingOnOrderService $adminCaptainFinancialSystemAccordingOnOrderService,
        private CaptainFinancialSystemDateService $captainFinancialSystemDateService,
        private CaptainFinancialDuesService $captainFinancialDuesService,
        private AdminOrderService $adminOrderService,
        private AdminCaptainFinancialSystemTwoGetBalanceDetailsService $adminCaptainFinancialSystemTwoGetBalanceDetailsService,
        private AdminCaptainService $adminCaptainService,
        private AdminCaptainFinancialSystemThreeGetBalanceDetailsService $adminCaptainFinancialSystemThreeGetBalanceDetailsService,
        private AdminCaptainFinancialSystemOneGetBalanceDetailsService $adminCaptainFinancialSystemOneGetBalanceDetailsService
    )
    {
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
                // **** Habib's code ****
                //return $this->adminCaptainFinancialSystemOneBalanceDetailService->getBalanceDetailWithSystemOne($financialSystemDetail, $captainId, $sumPayments, $date, $countWorkdays);
                // **** End of Habib's code ****

                // **** Rami's code ****
                return $this->adminCaptainFinancialSystemOneGetBalanceDetailsService->getBalanceDetailWithSystemOne($financialSystemDetail,
                    $captainId, $sumPayments, $date, $countWorkdays);
                // **** End of Rami's code ****
            }

            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_THREE) {
               $choseFinancialSystemDetails = $this->adminCaptainFinancialSystemAccordingOnOrderService->getCaptainFinancialSystemAccordingOnOrder();

                // **** Habib's code ****
                //return $this->adminCaptainFinancialSystemThreeBalanceDetailService->getBalanceDetailWithSystemThree($choseFinancialSystemDetails, $captainId, $sumPayments, $date);
                // **** End of Habib's code ****

                // **** Rami's code ****
                return $this->adminCaptainFinancialSystemThreeGetBalanceDetailsService->getBalanceDetailsForAdmin($choseFinancialSystemDetails,
                    $captainId, $sumPayments, $date);
                // **** End of Rami's code ****
            } 
            
            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_TWO) {
                // **** Habib's code ****
                // return $this->adminCaptainFinancialSystemTwoBalanceDetailService->adminGetBalanceDetailWithSystemTwo($financialSystemDetail, $captainId, $sumPayments, $date, $countWorkdays);
                // **** End of Habib's code ****

                // **** Rami's code ****
                return $this->adminCaptainFinancialSystemTwoGetBalanceDetailsService->getBalanceDetailsForAdmin($captainId, $financialSystemDetail,
                    $sumPayments, $date);
                // **** End of Rami's code ****
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
            // $this->captainFinancialDuesService->captainFinancialDues($result->getCaptain()->getCaptainId());
            // following part by Rami
            // Just create captain financial due when admin approve the selected captain financial system and a last active
            // captain financial system is not exist
            if ($result->getStatus() === true) {
                $this->captainFinancialDuesService->createCaptainFinancialDueByAdminIfNotAnActiveOneExist($result->getCaptain()->getId());
            }
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

    /**
     * This functions creates financial cycles for orders (created after 8/19/2022) which do not belong to any
     * financial cycle
     * This function is called by a command
     */
    public function calculateOrdersThatNotBelongToAnyFinancialDues(): void
    {
       // Get orders which accepted by captains and their created date is above 8/19/2022
       $orders = $this->adminOrderService->getOrders();

       if (count($orders) > 0) {
           /**
            * Check each order of the fetched ones, if it doesn't belong to any financial cycle, then create a one
            * which contains the order/s that accepted by same captain
            */
           $this->captainFinancialDuesService->calculateOrdersThatNotBelongToAnyFinancialDues($orders);
       }
    }

    public function createCaptainFinancialSystemDetailByAdmin(CaptainFinancialSystemDetailCreateByAdminRequest $request): CaptainFinancialSystemDetailCreateByAdminResponse|string
    {
        // First, get captain profile entity
        $captainProfile = $this->getCaptainProfileByIdForAdmin($request->getCaptain());

        if (! $captainProfile) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        $request->setCaptain($captainProfile);

        // Second, create the captain financial system detail
        $captainFinancialSystemDetailEntity = $this->adminCaptainFinancialSystemDetailManager->createCaptainFinancialSystemDetailByAdmin($request);

        if ($captainFinancialSystemDetailEntity === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE) {
            return CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE;
        }

        // Third, update complete account status if appropriate
        $this->updateCaptainProfileCompleteAccountStatusByAdmin($captainProfile->getId(),
            CaptainConstant::COMPLETE_ACCOUNT_STATUS_SYSTEM_FINANCIAL_SELECTED);

        return $this->autoMapping->map(CaptainFinancialSystemDetailEntity::class, CaptainFinancialSystemDetailCreateByAdminResponse::class, $captainFinancialSystemDetailEntity);
    }

    public function getCaptainProfileByIdForAdmin(int $captainProfileId): ?CaptainEntity
    {
        return $this->adminCaptainService->getCaptainProfileEntityByIdForAdmin($captainProfileId);
    }

    public function updateCaptainProfileCompleteAccountStatusByAdmin(int $captainProfileId, string $completeAccountStatus): CaptainEntity|string
    {
        $completeAccountStatusUpdateRequest = new CompleteAccountStatusUpdateByAdminRequest();

        $completeAccountStatusUpdateRequest->setProfileId($captainProfileId);
        $completeAccountStatusUpdateRequest->setCompleteAccountStatus($completeAccountStatus);

        return $this->adminCaptainService->updateCaptainProfileCompleteAccountStatusByAdmin($completeAccountStatusUpdateRequest);
    }
}
