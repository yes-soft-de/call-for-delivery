<?php

namespace App\Request\Subscription;

class SubscriptionRemainingTimeUpdateRequest
{
    private $id;

    private $remainingTime;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }
}
