<?php

namespace App\Service\Admin\CaptainAmountFromOrderCash;

use App\AutoMapping;
use App\Entity\CaptainAmountFromOrderCashEntity;
use App\Manager\Admin\CaptainAmountFromOrderCash\AdminCaptainAmountFromOrderCashManager;
use App\Request\Admin\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashFilterGetRequest;
use App\Response\Admin\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashResponse;
use App\Service\Admin\CaptainPayment\AdminCaptainPaymentToCompanyService;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;

class AdminCaptainAmountFromOrderCashService
{
    private AutoMapping $autoMapping;
    private AdminCaptainAmountFromOrderCashManager $adminCaptainAmountFromOrderCashManager;
    private AdminCaptainPaymentToCompanyService $adminCaptainPaymentToCompanyService;

    public function __construct(AutoMapping $autoMapping, AdminCaptainAmountFromOrderCashManager $adminCaptainAmountFromOrderCashManager, AdminCaptainPaymentToCompanyService $adminCaptainPaymentToCompanyService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminCaptainAmountFromOrderCashManager = $adminCaptainAmountFromOrderCashManager;
        $this->adminCaptainPaymentToCompanyService = $adminCaptainPaymentToCompanyService;
    }

    public function filterCaptainAmountFromOrderCash(CaptainAmountFromOrderCashFilterGetRequest $request): array
    {
        $detail = [];
        $sumAmountWithCaptain = 0 ;

        $items = $this->adminCaptainAmountFromOrderCashManager->filterCaptainAmountFromOrderCash($request);
        
        foreach ($items as $captainAmountFromOrderCash) {
          
            $sumAmountWithCaptain = $sumAmountWithCaptain + $captainAmountFromOrderCash['amount'];
          
            $detail[] = $this->autoMapping->map("array", CaptainAmountFromOrderCashResponse::class, $captainAmountFromOrderCash);
        }

        $total = $this->getTotal($sumAmountWithCaptain, $request->getCaptainId());

        return ['detail' => $detail, 'total' => $total];
    }

    public function getTotal($sumAmountWithCaptain, $captainId): array
    {
        $sumPaymentsFromCaptain = $this->adminCaptainPaymentToCompanyService->getSumPaymentsToCompany($captainId);
       
        $item['sumAmountWithCaptain'] = $sumAmountWithCaptain;

        $item['sumPaymentsFromCaptain'] = $sumPaymentsFromCaptain['sumPayments'];

        $total = $sumAmountWithCaptain - $item['sumPaymentsFromCaptain'];
    
        $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;

        if($total <= 0 ) {
            $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $item['total'] = abs($total);

        return $item;
    }
}
