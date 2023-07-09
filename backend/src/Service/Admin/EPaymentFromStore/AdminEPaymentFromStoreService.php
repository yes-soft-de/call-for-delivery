<?php

namespace App\Service\Admin\EPaymentFromStore;

use App\AutoMapping;
use App\Entity\EPaymentFromStoreEntity;
use App\Manager\Admin\EPaymentFromStore\AdminEPaymentFromStoreManager;
use App\Request\Admin\EPaymentFromStore\EPaymentFromStoreFilterByAdminRequest;
use App\Response\Admin\EPaymentFromStore\EPaymentFromStoreGetForAdminResponse;
use App\Service\Admin\StoreOwnerSubscription\AdminStoreSubscriptionGetService;

class AdminEPaymentFromStoreService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminEPaymentFromStoreManager $adminEPaymentFromStoreManager,
        private AdminStoreSubscriptionGetService $adminStoreSubscriptionGetService
    )
    {
    }

    public function getLastStoreSubscriptionCostForAdmin(int $storeOwnerProfileId): float
    {
        return $this->adminStoreSubscriptionGetService->getLastStoreSubscriptionCostForAdmin($storeOwnerProfileId);
    }

    public function filterEPaymentFromStoreByAdmin(EPaymentFromStoreFilterByAdminRequest $request): array
    {
        $response = [];
        $response['subscriptionCost'] = 0.0;
        $response['ePayments'] = [];

        // if store owner profile had been entered, then get the last subscription cost
        if ($request->getStoreOwnerProfileId()) {
            $response['subscriptionCost'] = $this->getLastStoreSubscriptionCostForAdmin($request->getStoreOwnerProfileId());
        }

        $ePaymentsFromStore = $this->adminEPaymentFromStoreManager->filterEPaymentFromStoreByAdmin($request);

        if (count($ePaymentsFromStore) > 0) {
            foreach ($ePaymentsFromStore as $key => $value) {
                $response['ePayments'][$key] = $this->autoMapping->map(EPaymentFromStoreEntity::class, EPaymentFromStoreGetForAdminResponse::class,
                    $value);
            }
        }

        return $response;
    }
}
