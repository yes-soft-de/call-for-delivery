<?php

namespace App\MessageHandler\OrderLog;

use App\Message\OrderLog\OrderLogCreateMessage;
use App\Repository\OrderEntityRepository;
use App\Repository\StoreOwnerBranchEntityRepository;
use App\Repository\SupplierProfileEntityRepository;
use App\Service\OrderLog\OrderLogToMySqlService;
use Symfony\Component\Messenger\Handler\MessageSubscriberInterface;

class CreateOrderLogMessagesHandler implements MessageSubscriberInterface
{
    private OrderLogToMySqlService $orderLogToMySqlService;
    private OrderEntityRepository $orderEntityRepository;
    private StoreOwnerBranchEntityRepository $storeOwnerBranchEntityRepository;
    private SupplierProfileEntityRepository $supplierProfileEntityRepository;

    public function __construct(OrderLogToMySqlService $orderLogToMySqlService, OrderEntityRepository $orderEntityRepository,
                                StoreOwnerBranchEntityRepository $storeOwnerBranchEntityRepository, SupplierProfileEntityRepository $supplierProfileEntityRepository)
    {
        $this->orderLogToMySqlService = $orderLogToMySqlService;
        $this->orderEntityRepository = $orderEntityRepository;
        $this->storeOwnerBranchEntityRepository = $storeOwnerBranchEntityRepository;
        $this->supplierProfileEntityRepository = $supplierProfileEntityRepository;
    }

    public static function getHandledMessages(): iterable
    {
        yield OrderLogCreateMessage::class => [
            'method' => 'handleCreateOrderLogMessage'
        ];
    }

    public function handleCreateOrderLogMessage(OrderLogCreateMessage $orderLogCreateMessage)
    {
        $orderEntity = $this->orderEntityRepository->findOneBy(['id'=>$orderLogCreateMessage->getOrderId()]);

        if ($orderEntity) {
            $storeBranchEntity = $orderLogCreateMessage->getStoreOwnerBranch();
            $supplierProfileEntity = $orderLogCreateMessage->getSupplierProfile();

            if ($storeBranchEntity) {
                $storeBranchEntity = $this->storeOwnerBranchEntityRepository->findOneBy(['id'=>$storeBranchEntity]);
            }

            if ($supplierProfileEntity) {
                $supplierProfileEntity = $this->supplierProfileEntityRepository->findOneBy(['id'=>$supplierProfileEntity]);
            }

            $this->orderLogToMySqlService->initializeCreateOrderLogRequest($orderEntity, $orderLogCreateMessage->getCreatedBy(),
                $orderLogCreateMessage->getCreatedByUserType(), $orderLogCreateMessage->getAction(), $storeBranchEntity, $supplierProfileEntity);
        }
    }
}
