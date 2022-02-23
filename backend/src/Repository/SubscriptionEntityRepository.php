<?php

namespace App\Repository;

// use App\Constant\Order\OrderStateConstant;
use App\Entity\SubscriptionEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\PackageEntity;
use App\Entity\StoreOwnerProfileEntity;
// use App\Entity\OrderEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\NonUniqueResultException;
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

    public function getSubscriptionsForStoreOwner($storeOwner): array
    {
        return $this->createQueryBuilder('subscription')

            ->select ('IDENTITY( subscription.package)')
            ->addSelect('subscription.id','subscription.status','subscription.startDate',
                'subscription.endDate', 'subscription.note', 'subscription.isFuture')
            ->addSelect('packageEntity.id as packageId', 'packageEntity.name as packageName')
            ->addSelect('subscriptionDetailsEntity.id as subscriptionDetailsId')

            ->andWhere('subscription.storeOwner = :storeOwner')

            ->setParameter('storeOwner', $storeOwner)

            ->innerJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.package')
            ->leftJoin(SubscriptionDetailsEntity::class, 'subscriptionDetailsEntity', Join::WITH, 'subscription.id = subscriptionDetailsEntity.lastSubscription')

            ->getQuery()

            ->getResult();
    }

    public function getSubscriptionCurrentWithRelation($storeOwner): ?array
    {
        return $this->createQueryBuilder('subscription')

            ->select ('IDENTITY( subscription.package)')
            ->addSelect('subscription.id ', 'subscription.startDate', 'subscription.endDate')
            ->addSelect('packageEntity.id as packageId', 'packageEntity.name as packageName', 'packageEntity.carCount as packageCarCount',
             'packageEntity.orderCount as packageOrderCount')
            ->addSelect('subscriptionDetailsEntity.id as subscriptionDetailsId', 'subscriptionDetailsEntity.remainingOrders',
             'subscriptionDetailsEntity.remainingCars', 'subscriptionDetailsEntity.remainingTime', 
             'subscriptionDetailsEntity.status')

            ->andWhere('subscriptionDetailsEntity.storeOwner = :storeOwner')

            ->setParameter('storeOwner', $storeOwner)

            ->innerJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.package')
            ->innerJoin(SubscriptionDetailsEntity::class, 'subscriptionDetailsEntity', Join::WITH, 'subscription.id = subscriptionDetailsEntity.lastSubscription')

            ->getQuery()

            ->getOneOrNullResult();
    }











    






    /**
     * @param $id
     * @return mixed
     * @throws NonUniqueResultException
     */
    public function subscriptionIsActive($id):mixed
    {
        return $this->createQueryBuilder('subscription')

            ->select('subscription.status')

            ->andWhere("subscription.id = :id")

            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    /**
     * @param $storeOwner
     * @param $id
     * @return array|null
     * @throws NonUniqueResultException
     */
    public function getRemainingOrders($storeOwner, $id)
    {
        // return $this->createQueryBuilder('subscription')
        //     ->select('subscription.id as subscriptionId', 'subscription.startDate as subscriptionStartDate',
        //      'subscription.endDate as subscriptionEndDate')
        //     ->addSelect('packageEntity.orderCount', 'packageEntity.name as packageName', 'packageEntity.id as packageId', 
        //      'packageEntity.carCount as packageCarCount', 'packageEntity.orderCount as packageOrderCount')
        //     ->addSelect('packageEntity.orderCount - count(orderEntity.id) as remainingOrders',
        //      'count(orderEntity.id) as countOrdersDelivered ')
        //     ->addSelect('storeOwnerProfileEntity.storeOwnerId', 'storeOwnerProfileEntity.storeOwnerName')
           
        //     ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.subscribe = subscription.id')

        //     ->innerJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.storeOwnerId = subscription.storeOwner')

        //     ->innerJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.package')

        //     ->andWhere('subscription.storeOwner = :storeOwner' )
        //     ->andWhere('subscription.id=:id')
            
        //     ->addGroupBy('subscription.id')

        //     ->setMaxResults(1)

        //     ->addOrderBy('subscription.id', 'DESC')
           
        //     ->setParameter('storeOwner', $storeOwner)
        //     ->setParameter('id', $id)
           
        //     ->getQuery()
        //     ->getOneOrNullResult();
    }

    /**
     * @param $storeOwner
     * @param $subscribeId
     * @return array|null
     * @throws NonUniqueResultException
     */
    public function getCountCarsBusy($storeOwner, $id)
    {
        // return $this->createQueryBuilder('subscription')

        //     ->select('count(orderEntity.id) as countCarsBusy')

        //     ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.subscribe = subscription.id')

        //     ->andWhere("orderEntity.storeOwner = :storeOwner")
        //     ->andWhere("orderEntity.subscribe = :id")
        //     ->andWhere("orderEntity.state != :delivered")
        //     ->andWhere("orderEntity.state != :cancelled")
           
        //     ->setParameter('storeOwner', $storeOwner)
        //     ->setParameter('id', $id)
        //     ->setParameter('delivered', OrderStateConstant::ORDER_STATE_DELIVERED)
        //     ->setParameter('cancelled', OrderStateConstant::ORDER_STATE_CANCEL)

        //     ->getQuery()
        //     ->getOneOrNullResult();
    }
    
    public function getCountDeliveredOrders($storeOwner, $id)
    {
        // return $this->createQueryBuilder('subscription')

        //     ->select('count (orderEntity.id) as countDeliveredOrders')
           
        //     ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.id = subscription.id')
           
        //     ->andWhere("orderEntity.storeOwner = :storeOwner")
        //     ->andWhere("subscription.id = :id")
        //     ->andWhere("orderEntity.state = :delivered")

        //     ->setParameter('storeOwner', $storeOwner)
        //     ->setParameter('id', $id)
        //     ->setParameter('delivered', OrderStateConstant::ORDER_STATE_DELIVERED)

        //     ->getQuery()
        //     ->getOneOrNullResult();
    }
}
