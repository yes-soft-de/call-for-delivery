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

    public function createStoreOwnerDuesFromCashOrders(OrderEntity $orderEntity): ?StoreOwnerDuesFromCashOrdersEntity
    {
        $storeOwnerDuesFromCashOrders = $this->storeOwnerDuesFromCashOrdersManager->getStoreOwnerDuesFromCashOrdersByOrderId($orderEntity->getId());
        if( ! $storeOwnerDuesFromCashOrders) {
            return $this->create($orderEntity);
        }

        return $this->updateStoreOwnerDuesFromCashOrders($orderEntity, $storeOwnerDuesFromCashOrders);
    }

    public function create(OrderEntity $orderEntity): ?StoreOwnerDuesFromCashOrdersEntity
    {
        $request = new StoreOwnerDuesFromCashOrdersRequest();

        $request->setStore($orderEntity->getStoreOwner());
        $request->setOrderId($orderEntity);
        $request->setAmount($orderEntity->getCaptainOrderCost());
        $request->setFlag(OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO);
        $request->setStoreAmount($orderEntity->getOrderCost());
        $request->setCaptainNote($orderEntity->getNoteCaptainOrderCost());

        return $this->storeOwnerDuesFromCashOrdersManager->createStoreOwnerDuesFromCashOrders($request); 
    }

    public function updateStoreOwnerDuesFromCashOrders(OrderEntity $orderEntity, StoreOwnerDuesFromCashOrdersEntity $storeOwnerDuesFromCashOrdersEntity): ?StoreOwnerDuesFromCashOrdersEntity
    {
        $storeOwnerDuesFromCashOrdersEntity->setStore($orderEntity->getStoreOwner());
        $storeOwnerDuesFromCashOrdersEntity->setOrderId($orderEntity);
        $storeOwnerDuesFromCashOrdersEntity->setAmount($orderEntity->getCaptainOrderCost());
        $storeOwnerDuesFromCashOrdersEntity->setFlag(OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO);
        $storeOwnerDuesFromCashOrdersEntity->setStoreAmount($orderEntity->getOrderCost());
        $storeOwnerDuesFromCashOrdersEntity->setCaptainNote($orderEntity->getNoteCaptainOrderCost());

        return $this->storeOwnerDuesFromCashOrdersManager->updateStoreOwnerDuesFromCashOrders($storeOwnerDuesFromCashOrdersEntity); 
    }

    public function getStoreOwnerDuesFromCashOrdersByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->storeOwnerDuesFromCashOrdersManager->getStoreOwnerDuesFromCashOrdersByStoreOwnerId($storeOwnerId);
    }
}
