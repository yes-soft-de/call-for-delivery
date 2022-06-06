<?php

namespace App\Service\CaptainPayment;

use App\AutoMapping;
use App\Manager\CaptainPayment\CaptainPaymentManager;
use App\Response\CaptainPayment\CaptainPaymentResponse;
use App\Request\CaptainPayment\CaptainPaymentFilterRequest;
use DateTime;

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

    public function getSumPayments($captainId): array
    {
        return $this->captainPaymentManager->getSumPayments($captainId);
    }

    public function getPaymentsByCaptainFinancialDues(int $captainFinancialDues): array
    {
        return $this->captainPaymentManager->getPaymentsByCaptainFinancialDues($captainFinancialDues);
    }

    public function getSumPaymentsToCaptainByCaptainFinancialDuesId(int $captainFinancialDues): array
    {
        return $this->captainPaymentManager->getSumPaymentsToCaptainByCaptainFinancialDuesId($captainFinancialDues);
    }

    public function getSumPaymentsToCaptainByCaptainIdAndDate(dateTime $fromDate, dateTime $toDate, int $captainId): ?array
    {      
        return $this->captainPaymentManager->getSumPaymentsToCaptainByCaptainIdAndDate($fromDate, $toDate, $captainId);
    }

    public function getPaymentsByCaptainId(int $captainId): array
    {
        return $this->captainPaymentManager->getPaymentsByCaptainId($captainId);
    }
}
