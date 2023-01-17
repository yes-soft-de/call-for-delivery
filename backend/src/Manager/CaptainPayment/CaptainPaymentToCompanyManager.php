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

    /**
     * Function commented out because it isn't being used anywhere
     */
    //public function getSumPaymentsToCompany(int $captainId): ?array
    //{
    //    return $this->captainPaymentToCompanyEntityRepository->getSumPayments($captainId);
    //}

    public function getPaymentToCompanyByCaptainId(int $captainId): array
    {
        return $this->captainPaymentToCompanyEntityRepository->getPaymentToCompanyByCaptainId($captainId);
    }
}
