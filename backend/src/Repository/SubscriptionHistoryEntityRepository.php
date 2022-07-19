<?php

namespace App\Repository;

use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionHistoryEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method SubscriptionHistoryEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SubscriptionHistoryEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SubscriptionHistoryEntity[]    findAll()
 * @method SubscriptionHistoryEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SubscriptionHistoryEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SubscriptionHistoryEntity::class);
    }

    public function getSubscriptionsHistoryByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->createQueryBuilder('subscriptionHistoryEntity')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = subscriptionHistoryEntity.storeOwner'
            )

            ->andWhere('storeOwnerProfileEntity.storeOwnerId = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->getQuery()
            ->getResult();
    }
}
