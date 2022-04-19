<?php

namespace App\Service\CaptainPayment;

use App\AutoMapping;
use App\Manager\CaptainPayment\CaptainPaymentToCompanyManager;
use App\Response\CaptainPayment\CaptainPaymentResponse;
use App\Request\CaptainPayment\CaptainPaymentFilterRequest;

class CaptainPaymentToCompanyService
{
    private AutoMapping $autoMapping;
    private CaptainPaymentToCompanyManager $captainPaymentToCompanyManager;

    public function __construct(AutoMapping $autoMapping, CaptainPaymentToCompanyManager $captainPaymentToCompanyManager)
    {
        $this->autoMapping = $autoMapping;
        $this->captainPaymentToCompanyManager = $captainPaymentToCompanyManager;
    }

    public function getCaptainPaymentsToCompany(CaptainPaymentFilterRequest $request): array
    {
        $response = [];
      
        $payments = $this->captainPaymentToCompanyManager->getCaptainPaymentsToCompanyFilter($request);

        foreach ($payments as $payment) {
           
            $response[] = $this->autoMapping->map('array', CaptainPaymentResponse::class, $payment);
        }

        return $response;
    }

    public function getSumPaymentsToCompany($captainId): array
    {
        return $this->captainPaymentManagerToCompany->getSumPaymentsToCompany($captainId);
    }
}
