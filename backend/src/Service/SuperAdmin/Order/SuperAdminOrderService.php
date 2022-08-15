<?php

namespace App\Service\SuperAdmin\Order;

use App\Manager\SuperAdmin\Order\SuperAdminOrderManager;

class SuperAdminOrderService implements SuperAdminServiceInterface
{
    private SuperAdminOrderManager $superAdminOrderManager;

    public function __construct(SuperAdminOrderManager $superAdminOrderManager)
    {
        $this->superAdminOrderManager = $superAdminOrderManager;
    }

    /**
     * This function for one-time use only
     * Update isCaptainPaidToProvider by super admin to 1 (captain paid the cash order payment to the store) for order
     * which meet following condition:
     *      state = delivered
     *      isCaptainPaidToProvider = NULL
     *      dateCaptainPaidToProvider = NULL
     */
    public function updateIsCashPaymentConfirmedByStoreForSpecificOrdersByOrderCommand(): void
    {
        $this->superAdminOrderManager->updateIsCashPaymentConfirmedByStoreForSpecificOrdersByOrderCommand();
    }
}
