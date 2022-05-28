<?php

namespace App\Repository;

// use App\Constant\Order\OrderStateConstant;
use App\Entity\SubscriptionEntity;
use App\Entity\SubscriptionDetailsEntity;
use App\Entity\PackageEntity;
use App\Entity\SubscriptionHistoryEntity;
use App\Entity\SubscriptionCaptainOfferEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\OrderEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\NonUniqueResultException;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Subscription\SubscriptionCaptainOffer;
use App\Entity\CaptainOfferEntity;

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
            ->addSelect('subscription.id', 'subscription.status', 'subscription.startDate', 'subscription.endDate', 'subscription.note', 'subscription.isFuture')
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
            ->addSelect ('IDENTITY( subscription.subscriptionCaptainOffer) as subscriptionCaptainOfferId')
            ->addSelect('subscription.id ', 'subscription.startDate', 'subscription.endDate', 'subscription.status as subscriptionStatus')
            ->addSelect('packageEntity.id as packageId', 'packageEntity.name as packageName', 'packageEntity.carCount as packageCarCount',
             'packageEntity.orderCount as packageOrderCount', 'packageEntity.expired')
            ->addSelect('subscriptionDetailsEntity.id as subscriptionDetailsId', 'subscriptionDetailsEntity.remainingOrders',
             'subscriptionDetailsEntity.remainingCars', 'subscriptionDetailsEntity.remainingTime', 
             'subscriptionDetailsEntity.status', 'subscriptionDetailsEntity.hasExtra')
            ->addSelect('subscriptionHistoryEntity.type')
            ->addSelect('subscriptionCaptainOfferEntity.startDate as subscriptionCaptainOfferStartDate', 'subscriptionCaptainOfferEntity.expired as subscriptionCaptainOfferExpired', 'subscriptionCaptainOfferEntity.carCount as subscriptionCaptainOfferCarCount', 'subscriptionCaptainOfferEntity.status as subscriptionCaptainOfferCarStatus')

            ->andWhere('subscriptionDetailsEntity.storeOwner = :storeOwner')

            ->setParameter('storeOwner', $storeOwner)

            ->innerJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.package')
            ->innerJoin(SubscriptionDetailsEntity::class, 'subscriptionDetailsEntity', Join::WITH, 'subscription.id = subscriptionDetailsEntity.lastSubscription')
            ->leftJoin(SubscriptionHistoryEntity::class, 'subscriptionHistoryEntity', Join::WITH, 'subscription.id = subscriptionHistoryEntity.subscription')
            ->leftJoin(SubscriptionCaptainOfferEntity::class, 'subscriptionCaptainOfferEntity', Join::WITH, 'subscription.subscriptionCaptainOffer = subscriptionCaptainOfferEntity.id')

            ->getQuery()

            ->getOneOrNullResult();
    }

    public function getSubscriptionForNextTime($storeOwner): ?array
    {
        return $this->createQueryBuilder('subscription')
     
            ->select ('IDENTITY( subscription.package)')
         
            ->addSelect('subscription.id ', 'subscription.startDate', 'subscription.endDate', 'subscription.status as subscriptionStatus')
            ->addSelect('packageEntity.id as packageId')

            ->andWhere('subscription.storeOwner = :storeOwner')
            ->andWhere('subscription.isFuture = :isFuture')

            ->setParameter('storeOwner', $storeOwner)
            ->setParameter('isFuture', 1)

            ->innerJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.package')
           
            ->addGroupBy('subscription.id')

            ->setMaxResults(1)

            ->addOrderBy('subscription.id', 'ASC')
        
            ->getQuery()

            ->getOneOrNullResult();
    }

    public function countOrders(int $subscriptionId): ?array
    {
        return $this->createQueryBuilder('subscription')
         
            ->select('count (orderEntity.id) as countOrders')
    
            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.storeOwner = subscription.storeOwner')
        
            ->where('subscription.id = :id')
            ->andWhere('orderEntity.state != :cancel')
            ->andWhere('orderEntity.state != :delivered')
            ->andWhere('orderEntity.state != :pending')
             //Orders made within the current subscription date only
            ->andWhere('orderEntity.createdAt >= subscription.startDate')
            ->andWhere('orderEntity.createdAt <= subscription.endDate')

            ->setParameter('id', $subscriptionId)
            ->setParameter('cancel', OrderStateConstant::ORDER_STATE_CANCEL)
            ->setParameter('delivered', OrderStateConstant::ORDER_STATE_DELIVERED)
            ->setParameter('pending', OrderStateConstant::ORDER_STATE_PENDING)
        
            ->getQuery()

            ->getOneOrNullResult();
    }

    public function getSubscriptionCurrentByOrderId($orderId): ?array
    {
        return $this->createQueryBuilder('subscription')

            ->select ('IDENTITY( subscription.package)')
            ->addSelect ('IDENTITY( subscription.subscriptionCaptainOffer) as subscriptionCaptainOfferId')
            ->addSelect('subscription.id ', 'subscription.startDate', 'subscription.endDate', 'subscription.status as subscriptionStatus')
            ->addSelect('packageEntity.id as packageId', 'packageEntity.name as packageName', 'packageEntity.carCount as packageCarCount',
             'packageEntity.orderCount as packageOrderCount', 'packageEntity.expired')
            ->addSelect('subscriptionDetailsEntity.id as subscriptionDetailsId', 'subscriptionDetailsEntity.remainingOrders',
             'subscriptionDetailsEntity.remainingCars', 'subscriptionDetailsEntity.remainingTime', 
             'subscriptionDetailsEntity.status', 'subscriptionDetailsEntity.hasExtra')
            ->addSelect('subscriptionCaptainOfferEntity.startDate as subscriptionCaptainOfferStartDate', 'subscriptionCaptainOfferEntity.expired as subscriptionCaptainOfferExpired', 'subscriptionCaptainOfferEntity.carCount as subscriptionCaptainOfferCarCount', 'subscriptionCaptainOfferEntity.status as subscriptionCaptainOfferCarStatus')

            ->innerJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.package')
            ->innerJoin(SubscriptionDetailsEntity::class, 'subscriptionDetailsEntity', Join::WITH, 'subscription.id = subscriptionDetailsEntity.lastSubscription')
            ->leftJoin(SubscriptionCaptainOfferEntity::class, 'subscriptionCaptainOfferEntity', Join::WITH, 'subscription.subscriptionCaptainOffer = subscriptionCaptainOfferEntity.id')
            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'subscription.storeOwner = orderEntity.storeOwner')

            ->andWhere('orderEntity.id = :orderId')
            
            ->setParameter('orderId', $orderId)

            ->getQuery()

            ->getOneOrNullResult();
    }

    public function checkWhetherThereIsActiveCaptainsOffer(int $storeOwner): ?SubscriptionEntity
    {
        return $this->createQueryBuilder('subscription')

            ->andWhere('subscriptionCaptainOfferEntity.storeOwner = :storeOwner')
            ->setParameter('storeOwner', $storeOwner)

            ->andWhere('subscriptionCaptainOfferEntity.status = :status')
            ->setParameter('status', SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_ACTIVE)
            
            ->leftJoin(SubscriptionCaptainOfferEntity::class, 'subscriptionCaptainOfferEntity', Join::WITH, 'subscription.subscriptionCaptainOffer = subscriptionCaptainOfferEntity.id')
           
            ->orderBy('subscriptionCaptainOfferEntity.id', 'DESC')
           
            ->setMaxResults(1)
           
            ->getQuery()

            ->getOneOrNullResult();
    }

    public function getSubscriptionsSpecificStoreForAdmin(int $storeId): array
    {
        return $this->createQueryBuilder('subscription')

            ->select ('IDENTITY( subscription.package)')
            ->addSelect('subscription.id', 'subscription.status', 'subscription.startDate', 'subscription.endDate', 'subscription.note', 'subscription.isFuture', 'subscription.flag')
            ->addSelect('packageEntity.id as packageId', 'packageEntity.name as packageName', 'packageEntity.cost as packageCost')
            ->andWhere('subscription.storeOwner = :storeId')

            ->setParameter('storeId', $storeId)

            ->innerJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.package')

            ->getQuery()

            ->getResult();
    }

    public function getSubscriptionsByUserID(int $storeOwnerId): array
    {
        return $this->createQueryBuilder('subscription')

            ->select ('IDENTITY( subscription.package)')
            ->addSelect('subscription.id', 'subscription.status', 'subscription.startDate', 'subscription.endDate', 'subscription.note', 'subscription.isFuture', 'subscription.flag')
            ->addSelect('packageEntity.id as packageId', 'packageEntity.name as packageName', 'packageEntity.cost as packageCost')

            ->innerJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.package')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.storeOwnerId = :storeOwnerId')

            ->andWhere('subscription.storeOwner = storeOwnerProfileEntity.id')

            ->setParameter('storeOwnerId', $storeOwnerId)

            ->getQuery()

            ->getResult();
    }

    public function getCaptainOfferFirstTimeBySubscriptionId(int $subscriptionId): ?array
    {
        return $this->createQueryBuilder('subscription')

            ->select ('captainOfferEntity.price')
           
            ->andWhere('subscription.id = :subscriptionId')
            ->setParameter('subscriptionId', $subscriptionId)
           
            ->andWhere('subscription.captainOfferFirstTime = :captainOfferFirstTime')
            ->setParameter('captainOfferFirstTime', 1)
            
            ->leftJoin(SubscriptionCaptainOfferEntity::class, 'subscriptionCaptainOfferEntity', Join::WITH, 'subscription.subscriptionCaptainOffer = subscriptionCaptainOfferEntity.id')
           
            ->leftJoin(CaptainOfferEntity::class, 'captainOfferEntity', Join::WITH, 'captainOfferEntity.id = subscriptionCaptainOfferEntity.captainOffer')

            ->getQuery()

            ->getOneOrNullResult();
    }

    public function getCaptainOffersBySubscriptionId(int $subscriptionId): ?array
    {
        return $this->createQueryBuilder('subscription')

            ->select ('subscriptionCaptainOfferEntity.id', 'subscriptionCaptainOfferEntity.startDate', 'captainOfferEntity.price')
           
            ->andWhere('subscription.id = :subscriptionId')
            ->setParameter('subscriptionId', $subscriptionId)
            
            ->leftJoin(SubscriptionCaptainOfferEntity::class, 'subscriptionCaptainOfferEntity', Join::WITH, 'subscriptionCaptainOfferEntity.startDate >= subscription.startDate
             and 
             subscriptionCaptainOfferEntity.startDate <= subscription.endDate')
           
            ->leftJoin(CaptainOfferEntity::class, 'captainOfferEntity', Join::WITH, 'captainOfferEntity.id = subscriptionCaptainOfferEntity.captainOffer')

            ->getQuery()

            ->getResult();
    }
}
