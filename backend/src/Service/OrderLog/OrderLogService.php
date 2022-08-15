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
        $this->eventBus->dispatch(new OrderLogCreateMessage($orderId->getId(), $action, $createdBy, $createdByUserType,
            $storeOwnerBranchId, $orderId->getStoreOwner()->getId(), $supplierProfileId));
    }
}
