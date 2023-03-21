<?php

namespace App\Request\Admin\Order;

class NormalOrderCancelByAdminRequest
{
    /**
     * order id
     * @var int
     */
    private int $id;

    /**
     * indicates to cutting of the order from store's subscription or not
     * true if we want, no otherwise
     */
    private bool $cutOrderFromStoreSubscription = false;

    /**
     * do we have to add half financial order value to captain due or not
     * true if we want, no otherwise
     */
    private bool $addHalfOrderValueToCaptainFinancialDue = false;

    public function getId(): int
    {
        return $this->id;
    }

    public function getCutOrderFromStoreSubscription(): bool
    {
        return $this->cutOrderFromStoreSubscription;
    }

    public function getAddHalfOrderValueToCaptainFinancialDue(): bool
    {
        return $this->addHalfOrderValueToCaptainFinancialDue;
    }
}
