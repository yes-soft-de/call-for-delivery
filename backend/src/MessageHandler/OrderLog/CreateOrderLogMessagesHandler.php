<?php

namespace App\MessageHandler\OrderLog;

use App\Message\OrderLog\OrderLogCreateMessage;
use App\Repository\OrderEntityRepository;
use App\Service\OrderLog\OrderLogToMySqlService;
use Symfony\Component\Messenger\Handler\MessageSubscriberInterface;

class CreateOrderLogMessagesHandler implements MessageSubscriberInterface
{
    private OrderLogToMySqlService $orderLogToMySqlService;
    private OrderEntityRepository $orderEntityRepository;

    public function __construct(OrderLogToMySqlService $orderLogToMySqlService, OrderEntityRepository $orderEntityRepository)
    {
        $this->orderLogToMySqlService = $orderLogToMySqlService;
        $this->orderEntityRepository = $orderEntityRepository;
    }

    public static function getHandledMessages(): iterable
    {
        yield OrderLogCreateMessage::class => [
            'method' => 'handleCreateOrderMessage'
        ];
    }

    public function handleCreateOrderMessage(OrderLogCreateMessage $orderLogCreateMessage)
    {
        $orderEntity = $this->orderEntityRepository->findOneBy(['id'=>$orderLogCreateMessage->getOrderId()]);

        if ($orderEntity) {
            $this->orderLogToMySqlService->initializeCreateOrderLogRequest($orderEntity, $orderLogCreateMessage->getCreatedBy(),
                $orderLogCreateMessage->getCreatedByUserType(), $orderLogCreateMessage->getAction(), $orderLogCreateMessage->getStoreOwnerBranch(),
                $orderLogCreateMessage->getSupplierProfile());
        }
    }
}
