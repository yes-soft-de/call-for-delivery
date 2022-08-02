<?php

namespace App\Security\IsGranted;

use App\Constant\Eraser\EraserResultConstant;
use App\Service\Order\OrderService;
use App\Service\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersService;
use App\Service\StoreOwnerPayment\StoreOwnerPaymentService;
use App\Service\StoreOwnerPaymentFromCompany\StoreOwnerPaymentFromCompanyService;

class DeleteStoreOwnerAccountAndProfileGrantService
{
    private OrderService $orderService;
    private StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService;
    private StoreOwnerPaymentService $storeOwnerPaymentService;
    private StoreOwnerPaymentFromCompanyService $storeOwnerPaymentFromCompanyService;

    public function __construct(OrderService $orderService, StoreOwnerDuesFromCashOrdersService $storeOwnerDuesFromCashOrdersService, StoreOwnerPaymentService $storeOwnerPaymentService,
                                StoreOwnerPaymentFromCompanyService $storeOwnerPaymentFromCompanyService)
    {
        $this->orderService = $orderService;
        $this->storeOwnerDuesFromCashOrdersService = $storeOwnerDuesFromCashOrdersService;
        $this->storeOwnerPaymentService = $storeOwnerPaymentService;
        $this->storeOwnerPaymentFromCompanyService = $storeOwnerPaymentFromCompanyService;
    }

    public function checkIfStoreOwnerAccountAndProfileCanBeDeletedByStoreOwnerId(int $storeOwnerId): int
    {
        // check store dues from cash orders
        $storeDuesFromCashOrders = $this->storeOwnerDuesFromCashOrdersService->getStoreOwnerDuesFromCashOrdersByStoreOwnerId($storeOwnerId);

        if (count($storeDuesFromCashOrders) !== 0) {
            return EraserResultConstant::CAN_NOT_DELETE_STORE_HAS_DUES_FROM_CASH_ORDERS;
        }

        // check if there is payment of the store
        $storePayment = $this->storeOwnerPaymentService->getPaymentsByStoreOwnerId($storeOwnerId);

        if (count($storePayment) !== 0) {
            return EraserResultConstant::CAN_NOT_DELETE_STORE_HAS_PAYMENTS;
        }

        // check if there is payment from company to store
        $storePaymentFromCompany = $this->storeOwnerPaymentFromCompanyService->getPaymentsFromCompanyByStoreOwnerId($storeOwnerId);

        if (count($storePaymentFromCompany) !== 0) {
            return EraserResultConstant::CAN_NOT_DELETE_STORE_HAS_PAYMENTS_FROM_COMPANY;
        }

        // check if store has orders
        $orders = $this->orderService->checkIfStoreHasOrdersByStoreOwnerId($storeOwnerId);

        if ($orders === EraserResultConstant::STORE_HAS_ORDERS) {
            return EraserResultConstant::STORE_HAS_ORDERS;
        }

        return EraserResultConstant::STORE_OWNER_ACCOUNT_AND_PROFILE_CAN_BE_DELETED;
    }
}
