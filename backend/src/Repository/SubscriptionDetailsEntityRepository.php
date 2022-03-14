<?php

namespace App\Repository;

use App\Entity\SubscriptionDetailsEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
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

            ->select ('subscriptionDetailsEntity.id')
         
            ->andWhere('subscriptionDetailsEntity.storeOwner = :storeOwner')
            ->andWhere('subscriptionDetailsEntity.status = :status')

            ->setParameter('storeOwner', $storeOwner)
            ->setParameter('status', SubscriptionConstant::SUBSCRIBE_ACTIVE)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
