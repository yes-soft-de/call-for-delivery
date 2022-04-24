<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialDuesManager;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialDuesResponse;
use App\Service\CaptainPayment\CaptainPaymentService;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;

class AdminCaptainFinancialDuesService
{
    private AdminCaptainFinancialDuesManager $adminCaptainFinancialDuesManager;
    private AutoMapping $autoMapping;
    private CaptainPaymentService $captainPaymentService;

    public function __construct(AutoMapping $autoMapping, AdminCaptainFinancialDuesManager $adminCaptainFinancialDuesManager, CaptainPaymentService $captainPaymentService)
    {
        $this->adminCaptainFinancialDuesManager = $adminCaptainFinancialDuesManager;
        $this->autoMapping = $autoMapping;
        $this->captainPaymentService = $captainPaymentService;
    }

    public function getCaptainFinancialDues(int $captainId): array
    {        
        $response = [];

        $captainFinancialDues = $this->adminCaptainFinancialDuesManager->getCaptainFinancialDuesByCaptainId($captainId);

        foreach ($captainFinancialDues as $captainFinancialDue) {
           
            $captainFinancialDue['paymentsToCaptain'] = $this->captainPaymentService->getPaymentsByCaptainFinancialDues($captainFinancialDue['id']);
          
            $captainFinancialDue['total'] = $this->getCaptainFinancialTotal($captainFinancialDue['id']);

            $response[] = $this->autoMapping->map('array', AdminCaptainFinancialDuesResponse::class, $captainFinancialDue);
        }

        return $response;
    }

    public function getCaptainFinancialTotal(int $captainFinancialDueId): array
    {
        $captainFinancialDues = [];
        
        $sumCaptainFinancialDues = $this->adminCaptainFinancialDuesManager->getSumCaptainFinancialDuesById($captainFinancialDueId);
        
        $sumPaymentsToCaptain = $this->captainPaymentService->getSumPaymentsToCaptainByCaptainFinancialDuesId($captainFinancialDueId);
   
        $total = $sumPaymentsToCaptain['sumPaymentsToCaptain'] - $sumCaptainFinancialDues['sumCaptainFinancialDues'];
       
        $captainFinancialDues['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_NO;
    
        if($total <= 0 ) {
            $captainFinancialDues['advancePayment'] = CaptainFinancialSystem::ADVANCE_PAYMENT_YES;    
        }

        $captainFinancialDues['sumCaptainFinancialDues'] =  $sumCaptainFinancialDues['sumCaptainFinancialDues'];
        $captainFinancialDues['sumPaymentsToCaptain'] = $sumPaymentsToCaptain['sumPaymentsToCaptain'];
        $captainFinancialDues['total'] = abs($total);

        return $captainFinancialDues;
    }
}
