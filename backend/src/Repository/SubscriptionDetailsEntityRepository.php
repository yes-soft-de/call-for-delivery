<?php

namespace App\Repository;

use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\SubscriptionEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;
use App\Constant\Subscription\SubscriptionConstant;

/**
 * @method SubscriptionDetailsEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SubscriptionDetailsEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SubscriptionDetailsEntity[]    findAll()
 * @method SubscriptionDetailsEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SubscriptionDetailsEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SubscriptionDetailsEntity::class);
    }

    public function getSubscriptionCurrentActive($storeOwner): ?array
    {
        return $this->createQueryBuilder('subscriptionDetailsEntity')
     
            ->select('IDENTITY( subscriptionDetailsEntity.lastSubscription) as lastSubscription')

            ->addSelect('subscriptionDetailsEntity.id')
         
            ->andWhere('subscriptionDetailsEntity.storeOwner = :storeOwner')
            ->andWhere('subscriptionDetailsEntity.status = :status')

            ->setParameter('storeOwner', $storeOwner)
            ->setParameter('status', SubscriptionConstant::SUBSCRIBE_ACTIVE)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getSubscriptionDetailsByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->createQueryBuilder('subscriptionDetailsEntity')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = subscriptionDetailsEntity.storeOwner'
            )

            ->andWhere('storeOwnerProfileEntity.storeOwnerId = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->getQuery()
            ->getResult();
    }

    public function getSubscriptionDetailsEntityByLastSubscriptionId(int $subscriptionId): array
    {
        return $this->createQueryBuilder('subscriptionDetailsEntity')

            ->leftJoin(
                SubscriptionEntity::class,
                'subscriptionEntity',
                Join::WITH,
                'subscriptionEntity.id = subscriptionDetailsEntity.lastSubscription'
            )

            ->andWhere('subscriptionEntity.id = :subscriptionId')
            ->setParameter('subscriptionId', $subscriptionId)

            ->getQuery()
            ->getResult();
    }
}
