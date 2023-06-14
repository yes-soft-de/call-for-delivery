<?php

namespace App\Service\EPayment;

use App\Request\EPayment\EPaymentCreateByStoreOwnerRequest;
use App\Service\Subscription\SubscriptionService;

class EPaymentService
{
    public function __construct(
        private SubscriptionService $subscriptionService
    )
    {
    }

    public function createEPaymentByStoreOwner(EPaymentCreateByStoreOwnerRequest $request)
    {
        if ($request->getStatus() === 1) {
            // create subscription
            return $this->subscriptionService->createSubscriptionWithFreePackage($request->getStoreOwner());
        }

        return 0;
    }
}
