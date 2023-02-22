<?php

namespace App\Service\OrderLog;

use App\AutoMapping;
use App\Constant\OrderLog\OrderLogResultConstant;
use App\Entity\OrderEntity;
use App\Entity\OrderLogEntity;
use App\Manager\OrderLog\OrderLogManager;
use App\Message\OrderLog\OrderLogCreateMessage;
use App\Response\OrderLog\OrderLogCaptainProfileUpdateResponse;
use Symfony\Component\Messenger\MessageBusInterface;

class OrderLogService
{
    public function __construct(
        private MessageBusInterface $eventBus,
        private AutoMapping $autoMapping,
        private OrderLogManager $orderLogManager
    )
    {
    }

    public function createOrderLogMessage(OrderEntity $orderId, int $createdBy, int $createdByUserType, int $action,
                                          array $details, int|null $storeOwnerBranchId, int|null $supplierProfileId)
    {
        $this->eventBus->dispatch(OrderLogCreateMessage::create($orderId->getId(), $action, $createdBy, $createdByUserType,
            $storeOwnerBranchId, $details, $orderId->getStoreOwner()->getId(), $supplierProfileId));
    }

    /**
     * Update captainProfile field to null for each order log record related to specific captain
     */
    public function updateOrderLogCaptainProfileToNullByCaptainUserId(int $captainUserId): array|int
    {
        $orderLogUpdateResult = $this->orderLogManager->updateOrderLogCaptainProfileToNullByCaptainUserId($captainUserId);

        if ($orderLogUpdateResult === OrderLogResultConstant::ORDER_LOG_NOT_EXIST_CONST) {
            return OrderLogResultConstant::ORDER_LOG_NOT_EXIST_CONST;
        }

        $response = [];

        foreach ($orderLogUpdateResult as $orderLogEntity) {
            $response[] = $this->autoMapping->map(OrderLogEntity::class, OrderLogCaptainProfileUpdateResponse::class,
                $orderLogEntity);
        }

        return $response;
    }
}
