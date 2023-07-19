<?php

namespace App\Manager\CaptainPayment;

use App\Repository\CaptainPaymentEntityRepository;
use App\Request\CaptainPayment\CaptainPaymentFilterRequest;
use DateTime;

class CaptainPaymentManager
{
    public function __construct(
        private CaptainPaymentEntityRepository $captainPaymentEntityRepository
    )
    {
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
    
    public function getSumPaymentsToCaptainByCaptainIdAndDate(dateTime $fromDate, dateTime $toDate, int $captainId): ?array
    {      
        return $this->captainPaymentEntityRepository->getSumPaymentsToCaptainByCaptainIdAndDate($fromDate, $toDate, $captainId);
    }

    public function getPaymentsByCaptainId(int $captainId): array
    {
        return $this->captainPaymentEntityRepository->getPaymentsByCaptainId($captainId);
    }

    public function getLastCaptainPaymentByCaptainProfileId(int $captainProfileId): array
    {
        return $this->captainPaymentEntityRepository->findBy(['captain' => $captainProfileId], ['id' => 'DESC'], 1);
    }

    /**
     * epic 13
     */
    public function filterCaptainPaymentCaptain(CaptainPaymentFilterRequest $request): array
    {
        return $this->captainPaymentEntityRepository->filterCaptainPaymentCaptain($request);
    }
}
