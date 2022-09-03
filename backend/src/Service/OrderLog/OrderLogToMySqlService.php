<?php

namespace App\Service\OrderLog;

use App\Constant\Order\OrderStateConstant;
use App\Entity\OrderEntity;
use App\Entity\OrderLogEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\SupplierProfileEntity;
use App\Manager\OrderLog\OrderLogManager;
use App\Request\OrderLog\OrderLogCreateRequest;
use App\Service\Order\StoreOrderDetailsService;

class OrderLogToMySqlService
{
    private OrderLogManager $orderLogManager;
    private StoreOrderDetailsService $storeOrderDetailsService;

    public function __construct(OrderLogManager $orderLogManager, StoreOrderDetailsService $storeOrderDetailsService)
    {
        $this->orderLogManager = $orderLogManager;
        $this->storeOrderDetailsService = $storeOrderDetailsService;
    }

    public function createNewOrderLog(OrderLogCreateRequest $request): OrderLogEntity
    {
        return $this->orderLogManager->createNewOrderLog($request);
    }

    public function initializeCreateOrderLogRequest(OrderEntity $orderEntity, int $createdBy, int $createdByUserType, int $action,
                                                    StoreOwnerBranchEntity|int|null $storeOwnerBranch, SupplierProfileEntity|int|null $supplierProfile)
    {
        $orderLogCreateRequest = new OrderLogCreateRequest();

        $orderLogCreateRequest->setOrderId($orderEntity);
        $orderLogCreateRequest->setType($orderEntity->getOrderType());
        $orderLogCreateRequest->setAction($action);
        $orderLogCreateRequest->setState($this->getIntegerValueOfOrderState($orderEntity->getState()));
        $orderLogCreateRequest->setCreatedBy($createdBy);
        $orderLogCreateRequest->setCreatedByUserType($createdByUserType);

        if (! $storeOwnerBranch) {
            $orderLogCreateRequest->setStoreOwnerBranch($this->storeOrderDetailsService->getStoreBranchByOrderId($orderEntity->getId()));

        } else {
            $orderLogCreateRequest->setStoreOwnerBranch($storeOwnerBranch);
        }

        $orderLogCreateRequest->setStoreOwnerProfile($orderEntity->getStoreOwner());
        $orderLogCreateRequest->setCaptainProfile($orderEntity->getCaptainId());
        $orderLogCreateRequest->setIsCaptainArrivedConfirmation($orderEntity->getIsCaptainArrived());
        $orderLogCreateRequest->setSupplierProfile($supplierProfile);
        $orderLogCreateRequest->setIsHide($orderEntity->getIsHide());
        $orderLogCreateRequest->setOrderIsMain($orderEntity->getOrderIsMain());
        $orderLogCreateRequest->setPrimaryOrder($orderEntity->getPrimaryOrder());
        $orderLogCreateRequest->setPaidToProvider($orderEntity->getPaidToProvider());
        $orderLogCreateRequest->setIsCashPaymentConfirmedByStore($orderEntity->getIsCashPaymentConfirmedByStore());

        $this->createNewOrderLog($orderLogCreateRequest);
    }

    public function getIntegerValueOfOrderState(string $orderState): int
    {
        foreach (OrderStateConstant::ORDER_STATE_ARRAY_INT as $key => $value) {
            if ($orderState === $key) {
                return $value;
            }
        }
    }
}
