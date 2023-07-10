<?php

namespace App\Manager\Admin\EPaymentFromStore;

use App\Repository\EPaymentFromStoreEntityRepository;
use App\Request\Admin\EPaymentFromStore\EPaymentFromStoreFilterByAdminRequest;

class AdminEPaymentFromStoreManager
{
    public function __construct(
        private EPaymentFromStoreEntityRepository $ePaymentFromStoreEntityRepository
    )
    {
    }

    public function filterEPaymentFromStoreByAdmin(EPaymentFromStoreFilterByAdminRequest $request): array
    {
        return $this->ePaymentFromStoreEntityRepository->filterEPaymentFromStoreByAdmin($request);
    }
}
