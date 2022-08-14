<?php

namespace App\Service\OrderLog;

use App\Entity\OrderEntity;
use App\Message\OrderLog\OrderLogCreateMessage;
use Symfony\Component\Messenger\MessageBusInterface;

class OrderLogService
{
    private MessageBusInterface $eventBus;

    public function __construct(MessageBusInterface $eventBus)
    {
        $this->eventBus = $eventBus;
    }

    public function createOrderLogMessage(OrderEntity $orderId, int $createdBy, int $createdByUserType, int $action,
                                          int|null $storeOwnerBranchId, int|null $supplierProfileId)
    {
        $captainProfileId = 0;
        $primaryOrderId = 0;

        if ($orderId->getCaptainId()) {
            $captainProfileId = $orderId->getCaptainId()->getId();
        }

        if ($orderId->getPrimaryOrder()) {
            $primaryOrderId = $orderId->getPrimaryOrder()->getId();
        }

        $this->eventBus->dispatch(new OrderLogCreateMessage($orderId->getId(), $orderId->getOrderType(), $action, $orderId->getState(),
            $createdBy, $createdByUserType, $orderId->getIsCaptainArrived(), $storeOwnerBranchId, $orderId->getStoreOwner()->getId(),
            $captainProfileId, $supplierProfileId, $orderId->getIsHide(), $orderId->getOrderIsMain(),
            $primaryOrderId, $orderId->getPaidToProvider(), $orderId->getIsCaptainPaidToProvider()));
    }
}
