<?php

namespace App\Service\CaptainAmountFromOrderCash;

use App\AutoMapping;
use App\Entity\CaptainAmountFromOrderCashEntity;
use App\Entity\OrderEntity;
use App\Request\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashRequest;
use App\Manager\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashManager;
use App\Constant\Order\OrderTypeConstant;

class CaptainAmountFromOrderCashService
{
    private AutoMapping $autoMapping;
    private CaptainAmountFromOrderCashManager $captainAmountFromOrderCashManager;

    public function __construct(AutoMapping $autoMapping, CaptainAmountFromOrderCashManager $captainAmountFromOrderCashManager)
    {
        $this->autoMapping = $autoMapping;
        $this->captainAmountFromOrderCashManager = $captainAmountFromOrderCashManager;
    }

    public function createCaptainAmountFromOrderCash(OrderEntity $orderEntity): ?CaptainAmountFromOrderCashEntity
    {
        $captainAmountFromOrderCash = $this->captainAmountFromOrderCashManager->getCaptainAmountFromOrderCashByOrderId($orderEntity->getId());
        if( ! $captainAmountFromOrderCash) {
            return $this->create($orderEntity);
        }

        return $this->updateCaptainAmountFromOrderCash($orderEntity, $captainAmountFromOrderCash);
    }

    public function create(OrderEntity $orderEntity): ?CaptainAmountFromOrderCashEntity
    {
        $request = new CaptainAmountFromOrderCashRequest();

        $request->setCaptain($orderEntity->getCaptainId());
        $request->setOrderId($orderEntity);
        $request->setAmount($orderEntity->getCaptainOrderCost());
        $request->setFlag(OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO);
        $request->setStoreAmount($orderEntity->getOrderCost());
        $request->setCaptainNote($orderEntity->getNoteCaptainOrderCost());

        return $this->captainAmountFromOrderCashManager->createCaptainAmountFromOrderCash($request); 
    }

    public function updateCaptainAmountFromOrderCash(OrderEntity $orderEntity, CaptainAmountFromOrderCashEntity $captainAmountFromOrderCashEntity): ?CaptainAmountFromOrderCashEntity
    {
        $captainAmountFromOrderCashEntity->setCaptain($orderEntity->getCaptainId());
        $captainAmountFromOrderCashEntity->setOrderId($orderEntity);
        $captainAmountFromOrderCashEntity->setAmount($orderEntity->getCaptainOrderCost());
        $captainAmountFromOrderCashEntity->setFlag(OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO);
        $captainAmountFromOrderCashEntity->setStoreAmount($orderEntity->getOrderCost());
        $captainAmountFromOrderCashEntity->setCaptainNote($orderEntity->getNoteCaptainOrderCost());

        return $this->captainAmountFromOrderCashManager->updateCaptainAmountFromOrderCash($captainAmountFromOrderCashEntity); 
    }
}
