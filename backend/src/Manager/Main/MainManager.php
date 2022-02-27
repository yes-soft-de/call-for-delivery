<?php

namespace App\Manager\Main;

use App\Constant\Main\MainDeleteConstant;
use App\Entity\PackageEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\SubscriptionEntity;
use App\Entity\SubscriptionHistoryEntity;
use Doctrine\ORM\EntityManagerInterface;

class MainManager
{
    private EntityManagerInterface $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
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
}
