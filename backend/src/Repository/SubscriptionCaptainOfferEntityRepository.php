<?php

namespace App\Repository;

use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionCaptainOfferEntity;
use App\Entity\SubscriptionEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method SubscriptionCaptainOfferEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SubscriptionCaptainOfferEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SubscriptionCaptainOfferEntity[]    findAll()
 * @method SubscriptionCaptainOfferEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SubscriptionCaptainOfferEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SubscriptionCaptainOfferEntity::class);
    }

    public function subscriptionCaptainOfferBySubscribeId(int $subscribeId): ?array
    {
        return $this->createQueryBuilder('subscriptionCaptainOfferEntity')

            ->select('subscriptionCaptainOfferEntity.id', 'subscriptionCaptainOfferEntity.status')
         
            ->leftJoin(SubscriptionEntity::class, 'subscriptionEntity', Join::WITH, 'subscriptionEntity.subscriptionCaptainOffer = subscriptionCaptainOfferEntity.id')

            ->andWhere('subscriptionEntity.id = :subscribeId')

            ->setParameter('subscribeId', $subscribeId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCaptainOffersSubscriptionsByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->createQueryBuilder('subscriptionCaptainOfferEntity')

            ->leftJoin(
                SubscriptionEntity::class,
                'subscriptionEntity',
                Join::WITH,
                'subscriptionEntity.subscriptionCaptainOffer = subscriptionCaptainOfferEntity.id'
            )

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = subscriptionEntity.storeOwner'
            )

            ->andWhere('storeOwnerProfileEntity.storeOwnerId = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->getQuery()
            ->getResult();
    }
}
