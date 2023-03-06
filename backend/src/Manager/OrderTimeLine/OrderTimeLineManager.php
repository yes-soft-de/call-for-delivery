<?php

namespace App\Manager\OrderTimeLine;

use App\AutoMapping;
use App\Constant\OrderTimeLine\OrderTimeLineResultConstant;
use App\Entity\OrderTimeLineEntity;
use App\Repository\OrderTimeLineEntityRepository;
use App\Request\OrderTimeLine\OrderLogsCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class OrderTimeLineManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private OrderTimeLineEntityRepository $orderTimeLineEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, OrderTimeLineEntityRepository $orderTimeLineEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->orderTimeLineEntityRepository = $orderTimeLineEntityRepository;
    }

    public function createOrderLogs(OrderLogsCreateRequest $request): ?OrderTimeLineEntity
    {
        $entity = $this->autoMapping->map(OrderLogsCreateRequest::class, OrderTimeLineEntity::class, $request);
   
        $this->entityManager->persist($entity);

        $this->entityManager->flush();

        return $entity;
    }

    public function getOrderTimeLineByOrderId(int $orderId): ?array
    {
      return $this->orderTimeLineEntityRepository->getOrderTimeLineByOrderId($orderId);
    }
    
    public function getCurrentStage(int $orderId): ?array
    {
      return $this->orderTimeLineEntityRepository->getCurrentStage($orderId);
    }

    /**
     * Update captainProfile field to null for each order timeline record related to specific captain
     */
    public function updateOrderTimelineCaptainProfileToNullByCaptainUserId(int $captainUserId): array|int
    {
        $orderTimelineArrayResult = $this->orderTimeLineEntityRepository->getOrderTimelineByCaptainUserId($captainUserId);

        if (count($orderTimelineArrayResult) === 0) {
            return OrderTimeLineResultConstant::ORDER_TIMELINE_NOT_EXIST_CONST;
        }

        foreach ($orderTimelineArrayResult as $orderTimeline) {
            $orderTimeline->setCaptainProfile(null);

            $this->entityManager->flush();
        }

        return $orderTimelineArrayResult;
    }
}
