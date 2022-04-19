<?php

namespace App\Manager\CaptainPayment;

use App\Repository\CaptainPaymentToCompanyEntityRepository;
use App\Request\CaptainPayment\CaptainPaymentFilterRequest;

class CaptainPaymentToCompanyManager
{
    private CaptainPaymentToCompanyEntityRepository $captainPaymentToCompanyEntityRepository;

    public function __construct(CaptainPaymentToCompanyEntityRepository $captainPaymentToCompanyEntityRepository)
    {
        $this->captainPaymentToCompanyEntityRepository = $captainPaymentToCompanyEntityRepository;
    }

    public function getCaptainPaymentsToCompanyFilter(CaptainPaymentFilterRequest $request): ?array
    {
        return $this->captainPaymentToCompanyEntityRepository->getCaptainPaymentsFilter($request);
    }

    public function getSumPaymentsToCompany(int $captainId): ?array
    {
        return $this->captainPaymentToCompanyEntityRepository->getSumPayments($captainId);
    }
}
