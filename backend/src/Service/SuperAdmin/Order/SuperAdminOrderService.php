<?php

namespace App\Service\SuperAdmin\Order;

use App\Manager\SuperAdmin\Order\SuperAdminOrderManager;
use App\Service\OrderLog\OrderLogToMySqlService;

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

        // Following part will be activated when actions on order (by command) will be saved in order log
//        if (count($orders) > 0) {
//            foreach ($orders as $order) {
//                // save log of the action on order
//                $this->orderLogToMySqlService->initializeCreateOrderLogRequest($order, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
//                    OrderLogActionTypeConstant::UN_ASSIGN_ORDER_TO_CAPTAIN_BY_ADMIN_ACTION_CONST, null, null);
//            }
//        }
    }
}
