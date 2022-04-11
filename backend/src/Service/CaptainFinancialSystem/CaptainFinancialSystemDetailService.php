<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemDetailManager;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemDetailResponse;
use App\Request\CaptainFinancialSystem\CaptainFinancialSystemDetailRequest;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse;

class CaptainFinancialSystemDetailService
{
    private CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemDetailManager $captainFinancialSystemDetailManager)
    {
        $this->captainFinancialSystemDetailManager = $captainFinancialSystemDetailManager;
        $this->autoMapping = $autoMapping;
    }

    public function createCaptainFinancialSystemDetail(CaptainFinancialSystemDetailRequest $request): CaptainFinancialSystemDetailResponse|string
    {
        $captainFinancialSystemDetailEntity = $this->captainFinancialSystemDetailManager->createCaptainFinancialSystemDetail($request);
      
        if($captainFinancialSystemDetailEntity === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE) {
            return CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_CAN_NOT_CHOSE;
        }

        return $this->autoMapping->map(CaptainFinancialSystemDetailEntity::class, CaptainFinancialSystemDetailResponse::class, $captainFinancialSystemDetailEntity);
    }

    public function getBalanceDetailForCaptain(int $userId)
    {
        //get Captain Financial System Detail current
        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailCurrent($userId);
       
        if($financialSystemDetail) {
             //sum captain's payments
            $sumPayments = $this->captainFinancialSystemDetailManager->getSumPayments($financialSystemDetail['captainId']);
       
            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
                return $this->getBalanceDetailWithSystemOne( $financialSystemDetail, $financialSystemDetail['captainId'], $sumPayments[0]['sumPayments']);
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }

    public function getBalanceDetailForAdmin(int $captainId)
    {
        //get Captain Financial System Detail current
        $financialSystemDetail = $this->captainFinancialSystemDetailManager->getCaptainFinancialSystemDetailForAdmin($captainId);
       
        if($financialSystemDetail) {
             //sum captain's payments
            $sumPayments = $this->captainFinancialSystemDetailManager->getSumPayments($captainId);
       
            if($financialSystemDetail['captainFinancialSystemType'] === CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ONE) {
                return $this->getBalanceDetailWithSystemOne( $financialSystemDetail, $captainId, $sumPayments[0]['sumPayments'], true);
            }
        }

        return CaptainFinancialSystem::YOU_NOT_HAVE_CAPTAIN_FINANCIAL_SYSTEM;
    }

    public function getBalanceDetailWithSystemOne(array $financialSystemDetail, int $captainId, float $sumPayments, bool $admin = null): CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse
    {
        $countOrdersMaxFromNineteen = 0;
        //get Count Orders
        $countOrders = $this->captainFinancialSystemDetailManager->getCountOrders($captainId);
        //get Orders Details
        $detailsOrders = $this->captainFinancialSystemDetailManager->getDetailOrders($captainId);

        foreach($detailsOrders as $detailOrder) {
           if($detailOrder['kilometer'] > 19 ) {
                $countOrdersMaxFromNineteen = $countOrdersMaxFromNineteen + 1;
           }
        }

        $financialSystemDetail['financialDues'] = ( ($countOrders['countOrders'] + $countOrdersMaxFromNineteen) * $financialSystemDetail['compensationForEveryOrder'] ) + $financialSystemDetail['salary'];
    
        $financialSystemDetail['sumPayments'] = $sumPayments;
             
        $financialSystemDetail['countOrders'] = $countOrders['countOrders'];

        $financialSystemDetail['countOrdersMaxFromNineteen'] = $countOrdersMaxFromNineteen;
        if($admin === true) {
            $financialSystemDetail['total'] = $sumPayments - $financialSystemDetail['financialDues'];
            //We may need a special admin response file in the future
            return $this->autoMapping->map('array', CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse::class, $financialSystemDetail); 
        }

        $financialSystemDetail['total'] = $financialSystemDetail['financialDues'] - $sumPayments;

        return $this->autoMapping->map('array', CaptainFinancialSystemAccordingToCountOfHoursBalanceDetailResponse::class, $financialSystemDetail);
    }
}
