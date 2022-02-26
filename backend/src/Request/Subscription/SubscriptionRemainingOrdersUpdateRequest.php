<?php

namespace App\Request\Subscription;

class SubscriptionRemainingOrdersUpdateRequest
{
    private $id;

    private $remainingOrders;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}
