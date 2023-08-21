<?php

namespace App\Service\CaptainAmountFromOrderCash;

use App\Constant\Order\OrderTypeConstant;
use App\Entity\CaptainAmountFromOrderCashEntity;
use App\Entity\OrderEntity;
use App\Request\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashRequest;
use App\Manager\CaptainAmountFromOrderCash\CaptainAmountFromOrderCashManager;

class CaptainAmountFromOrderCashService
{
    public function __construct(
        private CaptainAmountFromOrderCashManager $captainAmountFromOrderCashManager
    )
    {
    }

    public function createCaptainAmountFromOrderCash(OrderEntity $orderEntity, int $flag, float $orderCost): ?CaptainAmountFromOrderCashEntity
    {
        $finalAmount = $orderCost;

        if ($flag === OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO) {
            if ($orderEntity->getStoreOwner()->getId() === 94) {
                if ($orderEntity->getDeliveryCost()) {
                    $finalAmount = $orderCost - $orderEntity->getDeliveryCost();
                }
            }
        }

        $captainAmountFromOrderCash = $this->captainAmountFromOrderCashManager->getCaptainAmountFromOrderCashByOrderId($orderEntity->getId());

        if (! $captainAmountFromOrderCash) {
            return $this->create($orderEntity, $finalAmount, $flag);
        }

        return $this->updateCaptainAmountFromOrderCash($orderEntity, $captainAmountFromOrderCash, $finalAmount, $flag);
    }

    public function create(OrderEntity $orderEntity, float $orderCost, int $flag): ?CaptainAmountFromOrderCashEntity
    {
        $request = new CaptainAmountFromOrderCashRequest();

        $request->setCaptain($orderEntity->getCaptainId());
        $request->setOrderId($orderEntity);
        $request->setAmount($orderEntity->getCaptainOrderCost());
        // $request->setFlag(OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO);
        $request->setFlag($flag);
        // $request->setStoreAmount($orderEntity->getOrderCost());
        $request->setStoreAmount($orderCost);

        $request->setCaptainNote($orderEntity->getNoteCaptainOrderCost());

        return $this->captainAmountFromOrderCashManager->createCaptainAmountFromOrderCash($request); 
    }

    public function updateCaptainAmountFromOrderCash(OrderEntity $orderEntity, CaptainAmountFromOrderCashEntity $captainAmountFromOrderCashEntity, float $orderCost, int $flag): ?CaptainAmountFromOrderCashEntity
    {
        $captainAmountFromOrderCashEntity->setCaptain($orderEntity->getCaptainId());
        $captainAmountFromOrderCashEntity->setOrderId($orderEntity);
        $captainAmountFromOrderCashEntity->setAmount($orderEntity->getCaptainOrderCost());
        // $captainAmountFromOrderCashEntity->setFlag(OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO);
        $captainAmountFromOrderCashEntity->setFlag($flag);
        // $captainAmountFromOrderCashEntity->setStoreAmount($orderEntity->getOrderCost());
        $captainAmountFromOrderCashEntity->setStoreAmount($orderCost);

        $captainAmountFromOrderCashEntity->setCaptainNote($orderEntity->getNoteCaptainOrderCost());

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
