<?php

namespace App\Service\SuperAdmin\Order;

use App\Constant\OrderLog\OrderLogActionTypeConstant;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Manager\SuperAdmin\Order\SuperAdminOrderManager;
use App\Service\OrderLog\OrderLogToMySqlService;
use DateTime;

class SuperAdminOrderService implements SuperAdminServiceInterface
{
    private OrderLogToMySqlService $orderLogToMySqlService;
    private SuperAdminOrderManager $superAdminOrderManager;

    public function __construct(OrderLogToMySqlService $orderLogToMySqlService, SuperAdminOrderManager $superAdminOrderManager)
    {
        $this->orderLogToMySqlService = $orderLogToMySqlService;
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
        $orders = $this->superAdminOrderManager->updateIsCashPaymentConfirmedByStoreForSpecificOrdersByOrderCommand();

        if (count($orders) > 0) {
            foreach ($orders as $order) {
                // save log of the action on order
                $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, 1, OrderLogCreatedByUserTypeConstant::SUPER_ADMIN_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::UPDATE_IS_CASH_PAYMENT_CONFIRMED_BY_STORE_VIA_COMMAND, null, null);
            }
        }
    }

    public function updateOrderHasPayConflictAnswersByCommand(): void
    {
        $ordersArray = $this->superAdminOrderManager->updateOrderHasPayConflictAnswersByCommand();

        if (count($ordersArray) > 0) {
            foreach ($ordersArray as $order) {
                // save log of the action on order
                $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, 1, OrderLogCreatedByUserTypeConstant::SUPER_ADMIN_USER_TYPE_CONST,
                    OrderLogActionTypeConstant::UPDATE_HAS_PAY_CONFLICT_ANSWERS_VIA_COMMAND, null, null);
            }
        }
    }
}
