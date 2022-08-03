<?php

namespace App\Service\StoreOwnerDuesFromCashOrders;

use App\AutoMapping;
use App\Request\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersRequest;
use App\Entity\StoreOwnerDuesFromCashOrdersEntity;
use App\Entity\OrderEntity;
use App\Manager\StoreOwnerDuesFromCashOrders\StoreOwnerDuesFromCashOrdersManager;
use App\Constant\Order\OrderTypeConstant;

class StoreOwnerDuesFromCashOrdersService
{
    private AutoMapping $autoMapping;
    private StoreOwnerDuesFromCashOrdersManager $storeOwnerDuesFromCashOrdersManager;

    public function __construct(AutoMapping $autoMapping, StoreOwnerDuesFromCashOrdersManager $storeOwnerDuesFromCashOrdersManager)
    {
        $this->autoMapping = $autoMapping;
        $this->storeOwnerDuesFromCashOrdersManager = $storeOwnerDuesFromCashOrdersManager;
    }

    public function createStoreOwnerDuesFromCashOrders(OrderEntity $orderEntity, int $flag, float $orderCost): ?StoreOwnerDuesFromCashOrdersEntity
    {
        $storeOwnerDuesFromCashOrders = $this->storeOwnerDuesFromCashOrdersManager->getStoreOwnerDuesFromCashOrdersByOrderId($orderEntity->getId());
        if( ! $storeOwnerDuesFromCashOrders) {
            return $this->create($orderEntity, $orderCost, $flag);
        }

        return $this->updateStoreOwnerDuesFromCashOrders($orderEntity, $storeOwnerDuesFromCashOrders, $orderCost, $flag);
    }

    public function create(OrderEntity $orderEntity, float $orderCost, int $flag): ?StoreOwnerDuesFromCashOrdersEntity
    {
        $request = new StoreOwnerDuesFromCashOrdersRequest();

        $request->setStore($orderEntity->getStoreOwner());
        $request->setOrderId($orderEntity);
        $request->setAmount($orderEntity->getCaptainOrderCost());
        // $request->setFlag(OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO);
        $request->setFlag($flag);
        // $request->setStoreAmount($orderEntity->getOrderCost());
        $request->setStoreAmount($orderCost);
        $request->setCaptainNote($orderEntity->getNoteCaptainOrderCost());

        return $this->storeOwnerDuesFromCashOrdersManager->createStoreOwnerDuesFromCashOrders($request); 
    }

    public function updateStoreOwnerDuesFromCashOrders(OrderEntity $orderEntity, StoreOwnerDuesFromCashOrdersEntity $storeOwnerDuesFromCashOrdersEntity, float $orderCost, int $flag): ?StoreOwnerDuesFromCashOrdersEntity
    {
        $storeOwnerDuesFromCashOrdersEntity->setStore($orderEntity->getStoreOwner());
        $storeOwnerDuesFromCashOrdersEntity->setOrderId($orderEntity);
        $storeOwnerDuesFromCashOrdersEntity->setAmount($orderEntity->getCaptainOrderCost());
        // $storeOwnerDuesFromCashOrdersEntity->setFlag(OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO);
        $storeOwnerDuesFromCashOrdersEntity->setFlag($flag);
        // $storeOwnerDuesFromCashOrdersEntity->setStoreAmount($orderEntity->getOrderCost());
        $storeOwnerDuesFromCashOrdersEntity->setStoreAmount($orderCost);
        $storeOwnerDuesFromCashOrdersEntity->setCaptainNote($orderEntity->getNoteCaptainOrderCost());

        return $this->storeOwnerDuesFromCashOrdersManager->updateStoreOwnerDuesFromCashOrders($storeOwnerDuesFromCashOrdersEntity); 
    }

    public function getStoreOwnerDuesFromCashOrdersByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->storeOwnerDuesFromCashOrdersManager->getStoreOwnerDuesFromCashOrdersByStoreOwnerId($storeOwnerId);
    }
}
