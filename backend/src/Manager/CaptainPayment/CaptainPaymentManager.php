<?php

namespace App\Manager\CaptainPayment;

use App\Repository\CaptainPaymentEntityRepository;
use App\Request\CaptainPayment\CaptainPaymentFilterRequest;

class CaptainPaymentManager
{
    private CaptainPaymentEntityRepository $captainPaymentEntityRepository;

    public function __construct(CaptainPaymentEntityRepository $captainPaymentEntityRepository)
    {
        $this->captainPaymentEntityRepository = $captainPaymentEntityRepository;
    }

    public function getCaptainPaymentsFilter(CaptainPaymentFilterRequest $request): ?array
    {
        return $this->captainPaymentEntityRepository->getCaptainPaymentsFilter($request);
    }

    public function getSumPayments(int $captainId): ?array
    {
        return $this->captainPaymentEntityRepository->getSumPayments($captainId);
    }

    public function getPaymentsByCaptainFinancialDues(int $captainFinancialDues): ?array
    {
        return $this->captainPaymentEntityRepository->getPaymentsByCaptainFinancialDues($captainFinancialDues);
    }

    public function getSumPaymentsToCaptainByCaptainFinancialDuesId(int $captainFinancialDues): ?array
    {
        return $this->captainPaymentEntityRepository->getSumPaymentsToCaptainByCaptainFinancialDuesId($captainFinancialDues);
    }
    
    public function getSumPaymentsToCaptainByCaptainIdAndDate($fromDate, $toDate, int $captainId): ?array
    {      
        return $this->captainPaymentEntityRepository->getSumPaymentsToCaptainByCaptainIdAndDate($fromDate, $toDate, $captainId);
    }
}
