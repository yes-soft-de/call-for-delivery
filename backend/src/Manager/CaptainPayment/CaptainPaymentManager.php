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
}
