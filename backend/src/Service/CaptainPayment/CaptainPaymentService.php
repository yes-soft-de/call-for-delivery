<?php

namespace App\Service\CaptainPayment;

use App\AutoMapping;
use App\Manager\CaptainPayment\CaptainPaymentManager;
use App\Response\CaptainPayment\CaptainPaymentResponse;
use App\Request\CaptainPayment\CaptainPaymentFilterRequest;

class CaptainPaymentService
{
    private AutoMapping $autoMapping;
    private CaptainPaymentManager $captainPaymentManager;

    public function __construct(AutoMapping $autoMapping, CaptainPaymentManager $captainPaymentManager)
    {
        $this->autoMapping = $autoMapping;
        $this->captainPaymentManager = $captainPaymentManager;
    }

    public function getCaptainPayments(CaptainPaymentFilterRequest $request): array
    {
        $response = [];
      
        $payments = $this->captainPaymentManager->getCaptainPaymentsFilter($request);

        foreach ($payments as $payment) {
           
            $response[] = $this->autoMapping->map('array', CaptainPaymentResponse::class, $payment);
        }

        return $response;
    }
}
