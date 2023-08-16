<?php

namespace App\Service\EPaymentFromStoreLog;

use App\Entity\AdminProfileEntity;
use App\Entity\EPaymentFromStoreEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Manager\EPaymentFromStoreLog\EPaymentFromStoreLogManager;
use App\Request\EPaymentFromStoreLog\EPaymentFromStoreLogCreateRequest;

class EPaymentFromStoreLogToMySqlService
{
    public function __construct(
        private EPaymentFromStoreLogManager $ePaymentFromStoreLogManager
    )
    {
    }

    public function createEPaymentFromStoreLog(
        int $createdByUserId,
        int $action,
        ?StoreOwnerProfileEntity $storeOwnerProfile = null,
        ?EPaymentFromStoreEntity $ePaymentFromStore = null,
        ?AdminProfileEntity $adminProfile = null,
        ?string $details = null
    )
    {
        $ePaymentFromStoreLogCreateRequest = $this->initializeEPaymentFromStoreLogCreateRequest();

        $ePaymentFromStoreLogCreateRequest->setEPaymentFromStore($ePaymentFromStore);
        $ePaymentFromStoreLogCreateRequest->setAction($action);
        $ePaymentFromStoreLogCreateRequest->setDetails($details);
        $ePaymentFromStoreLogCreateRequest->setCreatedByUserId($createdByUserId);
        $ePaymentFromStoreLogCreateRequest->setStoreOwnerProfile($storeOwnerProfile);
        $ePaymentFromStoreLogCreateRequest->setAdminProfile($adminProfile);

        return $this->ePaymentFromStoreLogManager->createEPaymentFromStoreLog($ePaymentFromStoreLogCreateRequest);
    }

    public function initializeEPaymentFromStoreLogCreateRequest(): EPaymentFromStoreLogCreateRequest
    {
        return new EPaymentFromStoreLogCreateRequest();
    }
}
