<?php

namespace App\Service\Admin\CaptainAmountFromOrderCash;

use App\AutoMapping;
use App\Manager\Admin\CaptainAmountFromOrderCash\AdminCaptainAmountFromOrderCashManager;
use App\Request\Admin\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashFilterGetRequest;
use App\Response\Admin\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashResponse;
use App\Service\Admin\CaptainPayment\AdminCaptainPaymentToCompanyService;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Order\OrderAmountCashConstant;

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
        $sumAmountWithCaptain = 0;
        $finishedPayments = [];

        $items = $this->adminCaptainAmountFromOrderCashManager->filterCaptainAmountFromOrderCash($request);
        
        foreach ($items as $captainAmountFromOrderCash) {
           //Unfinished Payments
            if($captainAmountFromOrderCash['flag'] ===  OrderAmountCashConstant::ORDER_PAID_FLAG_NO) {
                $sumAmountWithCaptain = $sumAmountWithCaptain + $captainAmountFromOrderCash['amount'];
                $detail[] = $this->autoMapping->map("array", CaptainAmountFromOrderCashResponse::class, $captainAmountFromOrderCash);
            }
            //Finished Payments
            else {
                $finishedPayments[] = $this->autoMapping->map("array", CaptainAmountFromOrderCashResponse::class, $captainAmountFromOrderCash);
            }
        }

        $total = $this->getTotal($sumAmountWithCaptain, $request->getCaptainId(), $request->getFromDate(), $request->getToDate());

        return ['detail' => $detail, 'finishedPayments' => $finishedPayments, 'total' => $total];
    }

    public function getTotal(float $sumAmountWithCaptain, int $captainId, string $fromDate, string $toDate): array
    {
        //convert from(sumPaymentsToCaptain) to (sumPaymentsFromCaptain),Typing error only
        $sumPaymentsToCaptain = $this->adminCaptainPaymentToCompanyService->getSumPaymentsToCompanyInSpecificDate($captainId, $fromDate, $toDate);
      //Now this field shown only in the front the rest of the fields are not needed at the present time
        $item['sumAmountWithCaptain'] = $sumAmountWithCaptain;

        $item['sumPaymentsToCaptain'] = $sumPaymentsToCaptain['sumPayments'];

        $total = $sumAmountWithCaptain - $item['sumPaymentsToCaptain'];
        $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;

        if($total <= 0 ) {
            $item['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $item['total'] = abs($total);

        return $item;
    }
}
