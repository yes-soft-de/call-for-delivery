<?php

namespace App\Repository;

use App\Entity\SubscriptionEntity;
use App\Entity\PackageEntity;
use App\Entity\StoreOwnerProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method SubscriptionEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SubscriptionEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SubscriptionEntity[]    findAll()
 * @method SubscriptionEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SubscriptionEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SubscriptionEntity::class);
    }

    public function getIsFuture($storeOwner): mixed
    {
        return $this->createQueryBuilder('subscription')
            ->select('subscription.isFuture')

            ->andWhere('subscription.storeOwner = :storeOwner')
            ->andWhere('subscription.isFuture = :isFuture')

            ->setParameter('storeOwner', $storeOwner)
            ->setParameter('isFuture', 1)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getSubscriptionCurrent($storeOwner): mixed
    {
        return $this->createQueryBuilder('subscription')

            ->select('subscription.id')
          
            ->andWhere('subscription.storeOwner = :storeOwner')
            ->andWhere('subscription.isFuture = :isFuture')

            ->setParameter('storeOwner', $storeOwner)
            ->setParameter('isFuture', 0)

            ->addGroupBy('subscription.startDate')

            ->setMaxResults(1)
            
            ->addOrderBy('subscription.startDate', 'DESC')
           
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getSubscriptionForStoreOwner($storeOwner): array
    {
        return $this->createQueryBuilder('subscription')

            ->select ('IDENTITY( subscription.package)')
            ->addSelect('subscription.id','subscription.status', 'packageEntity.name',
                'subscription.startDate', 'subscription.endDate', 'subscription.note', 'subscription.isFuture'
                , 'subscription.isFuture')
            ->addSelect('packageEntity.id as packageId', 'packageEntity.name as packageName')

            ->andWhere('subscription.storeOwner = :storeOwner')

            ->setParameter('storeOwner', $storeOwner)

            ->innerJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.package')

            ->getQuery()

            ->getResult();
    }





    public function getRemainingOrders($storeOwner, $id)
    {
        return $this->createQueryBuilder('subscription')
//remainingOrderss : remainingOrders with cancelled order
            ->select('subscription.id as subscriptionID', 
                'packageEntity.orderCount - count(orderEntity.id) as remainingOrderss', 'packageEntity.orderCount',
                'packageEntity.name as packageName', 'packageEntity.id as packageID',
                'count(orderEntity.id) as countOrdersDelivered ', 'subscription.startDate as subscriptionStartDate',
                'subscription.endDate as subscriptionEndDate', 'storeOwnerProfileEntity.storeOwnerId',
                'storeOwnerProfileEntity.storeOwnerName', 'packageEntity.carCount as packageCarCount', 
                'packageEntity.orderCount as packageOrderCount')

            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.subscribeId = subscription.id')

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.storeOwnerId = subscription.storeOwner')

            ->leftJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.packageID')

            ->andWhere('subscription.storeOwner = :storeOwner' )
            ->andWhere('subscription.id=:id')
            
            ->addGroupBy('subscription.id')
            ->setMaxResults(1)
            ->addOrderBy('subscription.id', 'DESC')
           
            ->setParameter('storeOwner', $storeOwner)
            ->setParameter('id', $id)
           
            ->getQuery()
            ->getOneOrNullResult();
    }
}
