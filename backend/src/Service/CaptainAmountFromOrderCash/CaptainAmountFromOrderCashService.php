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

    public function createCaptainAmountFromOrderCash(OrderEntity $orderEntity, int $flag, float $orderCost): ?CaptainAmountFromOrderCashEntity
    {
        $captainAmountFromOrderCash = $this->captainAmountFromOrderCashManager->getCaptainAmountFromOrderCashByOrderId($orderEntity->getId());
        if( ! $captainAmountFromOrderCash) {
            return $this->create($orderEntity, $orderCost, $flag);
        }

        return $this->updateCaptainAmountFromOrderCash($orderEntity, $captainAmountFromOrderCash, $orderCost, $flag);
    }

    public function create(OrderEntity $orderEntity, float $orderCost, int $flag): ?CaptainAmountFromOrderCashEntity
    {
        $request = new CaptainAmountFromOrderCashRequest();

        $request->setCaptain($orderEntity->getCaptainId());
        $request->setOrderId($orderEntity);
        $request->setAmount($orderEntity->getCaptainOrderCost());
        $request->setFlag($flag);
        $request->setStoreAmount($orderCost);
        $request->setCaptainNote($orderEntity->getNoteCaptainOrderCost());
      
        if($flag === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_YES) {
            $request->setAmount(0);
        }

        return $this->captainAmountFromOrderCashManager->createCaptainAmountFromOrderCash($request); 
    }

    public function updateCaptainAmountFromOrderCash(OrderEntity $orderEntity, CaptainAmountFromOrderCashEntity $captainAmountFromOrderCashEntity, float $orderCost, int $flag): ?CaptainAmountFromOrderCashEntity
    {
        $captainAmountFromOrderCashEntity->setCaptain($orderEntity->getCaptainId());
        $captainAmountFromOrderCashEntity->setOrderId($orderEntity);
        $captainAmountFromOrderCashEntity->setAmount($orderEntity->getCaptainOrderCost());
        $captainAmountFromOrderCashEntity->setFlag($flag);
        $captainAmountFromOrderCashEntity->setStoreAmount($orderCost);

        $captainAmountFromOrderCashEntity->setCaptainNote($orderEntity->getNoteCaptainOrderCost());
      
        if($flag === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_YES) {
            $captainAmountFromOrderCashEntity->setAmount(0);
        }

        return $this->captainAmountFromOrderCashManager->updateCaptainAmountFromOrderCash($captainAmountFromOrderCashEntity); 
    }

    // for delete captain account and profile API
    public function getCashOrdersPaymentsByCaptainId(int $captainId): array
    {
        return $this->captainAmountFromOrderCashManager->getCashOrdersPaymentsByCaptainId($captainId);
    }

    // Is the captain allowed to edit?
    public function getEditingByCaptain(int $orderId): ?bool
    {
        $captainAmountFromOrderCash = $this->captainAmountFromOrderCashManager->getCaptainAmountFromOrderCashByOrderId($orderId);
     
        if(! $captainAmountFromOrderCash) {
            return $captainAmountFromOrderCash;
        }

        return $captainAmountFromOrderCash->getEditingByCaptain();
    }
}
