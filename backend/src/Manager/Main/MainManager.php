<?php

namespace App\Manager\Main;

use App\Constant\Main\MainDeleteConstant;
use App\Entity\OrderEntity;
use App\Entity\PackageEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\SubscriptionEntity;
use App\Entity\SubscriptionHistoryEntity;
use App\Manager\Order\OrderManager;
use App\Request\Main\OrderStateUpdateBySuperAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class MainManager
{
    private EntityManagerInterface $entityManager;
    private OrderManager $orderManager;

    public function __construct(EntityManagerInterface $entityManager, OrderManager $orderManager)
    {
        $this->entityManager = $entityManager;
        $this->orderManager = $orderManager;
    }

    public function deletePackagesAndSubscriptions(): \Exception|string
    {
        try {
            $this->entityManager->getRepository(SubscriptionHistoryEntity::class)->createQueryBuilder('subscriptionHistory')
                ->delete()
                ->getQuery()
                ->execute();

            $this->entityManager->getRepository(SubscriptionDetailsEntity::class)->createQueryBuilder('subscriptionDetails')
                ->delete()
                ->getQuery()
                ->execute();

            $this->entityManager->getRepository(SubscriptionEntity::class)->createQueryBuilder('subscription')
                ->delete()
                ->getQuery()
                ->execute();

            $this->entityManager->getRepository(PackageEntity::class)->createQueryBuilder('package')
                ->delete()
                ->getQuery()
                ->execute();

            return MainDeleteConstant::DELETED;
        } catch (\Exception $ex) {
            return $ex;
        }
    }

    public function updateOrderStateBySuperAdmin(OrderStateUpdateBySuperAdminRequest $request): string|OrderEntity
    {
        return $this->orderManager->updateOrderStateBySuperAdmin($request);
    }
}
