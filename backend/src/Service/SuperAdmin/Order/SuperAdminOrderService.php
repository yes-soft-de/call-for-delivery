<?php

namespace App\Service\SuperAdmin\Order;

use App\AutoMapping;
use App\Entity\OrderEntity;
use App\Manager\SuperAdmin\Order\SuperAdminOrderManager;
use App\Response\SuperAdmin\Order\IsCaptainPaidToProviderUpdateBySuperAdminResponse;

class SuperAdminOrderService implements SuperAdminServiceInterface
{
    private AutoMapping $autoMapping;
    private SuperAdminOrderManager $superAdminOrderManager;

    public function __construct(AutoMapping $autoMapping, SuperAdminOrderManager $superAdminOrderManager)
    {
        $this->autoMapping = $autoMapping;
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
    public function updateIsCashPaymentConfirmedByStoreForSpecificOrdersByOrderCommand(): array
    {
        $ordersArrayResult = $this->superAdminOrderManager->updateIsCashPaymentConfirmedByStoreForSpecificOrdersByOrderCommand();

        if (count($ordersArrayResult) > 0) {
            $response = [];

            foreach ($ordersArrayResult as $orderEntity) {
                $response[] = $this->autoMapping->map(OrderEntity::class, IsCaptainPaidToProviderUpdateBySuperAdminResponse::class, $orderEntity);
            }

            return $response;
        }

        return $ordersArrayResult;
    }
}
