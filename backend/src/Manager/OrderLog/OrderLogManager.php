<?php

namespace App\Manager\OrderLog;

use App\AutoMapping;
use App\Constant\OrderLog\OrderLogResultConstant;
use App\Entity\OrderLogEntity;
use App\Repository\OrderLogEntityRepository;
use App\Request\OrderLog\OrderLogCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class OrderLogManager
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private AutoMapping $autoMapping,
        private OrderLogEntityRepository $orderLogEntityRepository
    )
    {
    }

    public function createNewOrderLog(OrderLogCreateRequest $request): OrderLogEntity
    {
        $orderLogEntity = $this->autoMapping->map(OrderLogCreateRequest::class, OrderLogEntity::class, $request);

        $this->entityManager->persist($orderLogEntity);
        $this->entityManager->flush();

        return $orderLogEntity;
    }

    public function getOrderLogsByOrderIdForAdmin(int $orderId): array
    {
        return $this->orderLogEntityRepository->getOrderLogsByOrderIdForAdmin($orderId);
    }

    public function getOrderLogByOrderIdAndTypeAndActionAndCreatedUserType(int $orderId, int $orderType, int $actions, int $createdByUserType): ?OrderLogEntity
    {
        return $this->orderLogEntityRepository->findOneBy(['orderId'=>$orderId, 'type'=>$orderType, 'action'=>$actions,
            'createdByUserType'=>$createdByUserType], ['id'=>'DESC']);
    }

    /**
     * Update captainProfile field to null for each order log record related to specific captain
     */
    public function updateOrderLogCaptainProfileToNullByCaptainUserId(int $captainUserId): array|int
    {
        $orderLogArrayResult = $this->orderLogEntityRepository->getOrderLogByCaptainUserId($captainUserId);

        if (count($orderLogArrayResult) === 0) {
            return OrderLogResultConstant::ORDER_LOG_NOT_EXIST_CONST;
        }

        foreach ($orderLogArrayResult as $orderLogEntity) {
            $orderLogEntity->setCaptainProfile(null);

            $this->entityManager->flush();
        }

        return $orderLogArrayResult;
    }
}
