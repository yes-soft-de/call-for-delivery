<?php

namespace App\Repository;

// use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderAmountCashConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Constant\Subscription\SubscriptionConstant;
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
use App\Constant\Order\OrderIsHideConstant;
use App\Constant\Order\OrderIsMainConstant;

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
             'packageEntity.orderCount as packageOrderCount', 'packageEntity.expired, packageEntity.type as packageType, packageEntity.geographicalRange, packageEntity.extraCost as packageExtraCost, packageEntity.cost as packageCost')
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
            //not sub-order
            // ->andWhere('orderEntity.isHide != :isHide')
            ->andWhere('orderEntity.orderIsMain = :mainTrue or orderEntity.orderIsMain = :mainFalse')

            ->setParameter('id', $subscriptionId)
            ->setParameter('cancel', OrderStateConstant::ORDER_STATE_CANCEL)
            ->setParameter('delivered', OrderStateConstant::ORDER_STATE_DELIVERED)
            ->setParameter('pending', OrderStateConstant::ORDER_STATE_PENDING)
            ->setParameter('mainTrue', OrderIsMainConstant::ORDER_MAIN)
            ->setParameter('mainFalse', OrderIsMainConstant::ORDER_MAIN_WITHOUT_SUBORDER)
        
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
            ->addSelect('packageEntity.id as packageId', 'packageEntity.name as packageName', 'packageEntity.cost as packageCost', 'packageEntity.carCount as packageCarCount', 'packageEntity.orderCount as packageOrderCount', 'packageEntity.expired as packageExpired', 'packageEntity.note as packageNote', 'packageEntity.geographicalRange as packageGeographicalRange', 'packageEntity.extraCost as packageExtraCost', 'packageEntity.type as packageType', 'packageEntity.orderCount')

            ->addSelect('subscriptionDetailsEntity.remainingOrders','subscriptionDetailsEntity.remainingCars','subscriptionDetailsEntity.id as subscriptionDetailsId')
         
            ->andWhere('subscription.storeOwner = :storeId')
            ->setParameter('storeId', $storeId)

            ->innerJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.package')
            ->leftJoin(SubscriptionDetailsEntity::class, 'subscriptionDetailsEntity', Join::WITH, 'subscription.id = subscriptionDetailsEntity.lastSubscription')

            ->getQuery()

            ->getResult();
    }

    public function getSubscriptionsByUserID(int $storeOwnerId): array
    {
        return $this->createQueryBuilder('subscription')

            ->select ('IDENTITY( subscription.package)')
            ->addSelect('subscription.id', 'subscription.status', 'subscription.startDate', 'subscription.endDate', 'subscription.note', 'subscription.isFuture', 'subscription.flag')
            ->addSelect('packageEntity.id as packageId', 'packageEntity.name as packageName', 'packageEntity.cost as packageCost', 'packageEntity.geographicalRange as packageGeographicalRange', 'packageEntity.extraCost as packageExtraCost', 'packageEntity.type as packageType', 'packageEntity.orderCount')
            ->addSelect('subscriptionDetailsEntity.remainingOrders')

            ->innerJoin(PackageEntity::class, 'packageEntity', Join::WITH, 'packageEntity.id = subscription.package')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.storeOwnerId = :storeOwnerId')
            ->leftJoin(SubscriptionDetailsEntity::class, 'subscriptionDetailsEntity', Join::WITH, 'subscription.id = subscriptionDetailsEntity.lastSubscription')

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

            ->select ('subscriptionCaptainOfferEntity.id', 'subscriptionCaptainOfferEntity.startDate', 'captainOfferEntity.price', 'subscriptionCaptainOfferEntity.carCount', 'subscriptionCaptainOfferEntity.expired', 'subscriptionCaptainOfferEntity.status', 'subscription.captainOfferFirstTime')
           
//            ->andWhere('subscription.id = :subscriptionId')
//            ->setParameter('subscriptionId', $subscriptionId)
            
            ->leftJoin(SubscriptionCaptainOfferEntity::class, 'subscriptionCaptainOfferEntity', Join::WITH, 'subscriptionCaptainOfferEntity.startDate >= subscription.startDate
             and 
             subscriptionCaptainOfferEntity.startDate <= subscription.endDate')

            ->andWhere('subscription.subscriptionCaptainOffer = subscriptionCaptainOfferEntity.id')
            ->andWhere('subscription.id = :subscriptionId')
            ->setParameter('subscriptionId', $subscriptionId)
           
            ->leftJoin(CaptainOfferEntity::class, 'captainOfferEntity', Join::WITH, 'captainOfferEntity.id = subscriptionCaptainOfferEntity.captainOffer')

            ->getQuery()

            ->getResult();
    }

    public function getAllSubscriptionsEntitiesByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->createQueryBuilder('subscription')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = subscription.storeOwner')

            ->andWhere('storeOwnerProfileEntity.storeOwnerId = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->getQuery()
            ->getResult();
    }

    public function getCaptainOffersBySubscriptionIdForAdmin(int $subscriptionId): ?array
    {
        return $this->createQueryBuilder('subscription')

            ->select ('subscriptionCaptainOfferEntity.id', 'subscriptionCaptainOfferEntity.startDate', 'captainOfferEntity.price', 'subscription.captainOfferFirstTime',
                'subscriptionCaptainOfferEntity.carCount', 'subscriptionCaptainOfferEntity.expired', 'subscriptionCaptainOfferEntity.status')
            
            ->leftJoin(SubscriptionCaptainOfferEntity::class, 'subscriptionCaptainOfferEntity', Join::WITH, 'subscription.subscriptionCaptainOffer = subscriptionCaptainOfferEntity.id')

            ->andWhere('subscription.subscriptionCaptainOffer = subscriptionCaptainOfferEntity.id')
            ->andWhere('subscription.id = :subscriptionId')
            ->setParameter('subscriptionId', $subscriptionId)
           
            ->leftJoin(CaptainOfferEntity::class, 'captainOfferEntity', Join::WITH, 'captainOfferEntity.id = subscriptionCaptainOfferEntity.captainOffer')

            ->getQuery()

            ->getResult();
    }

    /**
     * Get orders which overdue the graphical range of the subscription's package by subscription id and package's
     * geographical range
     */
    public function getOrdersExceedGeographicalRangeBySubscriptionId(int $subscriptionId, float $packageGeographicalRange): ?array
    {
        return $this->createQueryBuilder('subscription')
            ->select('orderEntity.id', 'orderEntity.storeBranchToClientDistance', 'orderEntity.createdAt')
    
            ->leftJoin(
                OrderEntity::class,
                'orderEntity',
                Join::WITH,
                'orderEntity.storeOwner = subscription.storeOwner'
            )
        
            ->where('subscription.id = :id')
            ->setParameter('id', $subscriptionId)

            ->andWhere('subscription.isFuture != :isFutureTrue')
            ->setParameter('isFutureTrue', SubscriptionConstant::IS_FUTURE_TRUE)

            ->andWhere('orderEntity.state = :delivered')
            ->setParameter('delivered', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.storeBranchToClientDistance > :packageGeographicalRange')
            ->setParameter('packageGeographicalRange', $packageGeographicalRange)

             //Orders made within the current subscription date only
            ->andWhere('orderEntity.createdAt >= subscription.startDate')
            ->andWhere('orderEntity.createdAt <= subscription.endDate')
           
            ->getQuery()
            ->getResult();
    }

    /**
     * Get the count of delivered orders which belong to a specific subscription
     */
    public function getCountOfConsumedOrders(int $subscriptionId): ?int
    {
        return $this->createQueryBuilder('subscription')
            ->select('count(orderEntity.id) as countOrders')
    
            ->leftJoin(
                OrderEntity::class,
                'orderEntity',
                Join::WITH,
                'orderEntity.storeOwner = subscription.storeOwner'
            )
        
            ->where('subscription.id = :id')
            ->setParameter('id', $subscriptionId)

            ->andWhere('subscription.isFuture != :isFutureTrue')
            ->setParameter('isFutureTrue', SubscriptionConstant::IS_FUTURE_TRUE)

            ->andWhere('orderEntity.state = :delivered')
            ->setParameter('delivered', OrderStateConstant::ORDER_STATE_DELIVERED)

             //Orders made within the current subscription date only
            ->andWhere('orderEntity.createdAt >= subscription.startDate')
            ->andWhere('orderEntity.createdAt <= subscription.endDate')

            ->getQuery()
            ->getSingleScalarResult();
            // ->getOneOrNullResult();
    }

    // Get sum of unpaid cash orders
    public function getUnPaidCashOrdersSumBySubscriptionId(int $subscriptionId): array
    {
        return $this->createQueryBuilder('subscription')
            ->select('SUM(orderEntity.orderCost)')

            ->andWhere('subscription.id = :id')
            ->setParameter('id', $subscriptionId)

            ->join(
                OrderEntity::class,
                'orderEntity',
                Join::WITH,
                'orderEntity.storeOwner = subscription.storeOwner'
            )

            // Orders made within the subscription dates only
            ->andWhere('orderEntity.createdAt BETWEEN subscription.startDate AND subscription.endDate')

            ->andWhere('orderEntity.state = :delivered')
            ->setParameter('delivered', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.payment = :cashPayment')
            ->setParameter('cashPayment', OrderTypeConstant::ORDER_PAYMENT_CASH)

            // check when store does not confirm that the payment was made for the cash order
            ->andWhere('(orderEntity.isCashPaymentConfirmedByStore IS NULL AND orderEntity.paidToProvider = :notPaid) OR '.
                '(orderEntity.isCashPaymentConfirmedByStore = :notConfirmed AND orderEntity.paidToProvider = :notPaid)')
            ->setParameter('notConfirmed', OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO)
            ->setParameter('notPaid', OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO)

            ->getQuery()
            ->getSingleColumnResult();
    }

    public function getSubscriptionWithActiveCaptainOfferSubscriptionBySubscriptionId(int $subscriptionId): ?SubscriptionEntity
    {
        return $this->createQueryBuilder('subscription')

            ->where('subscription.id = :subscriptionId')
            ->setParameter('subscriptionId', $subscriptionId)

            ->leftJoin(
                SubscriptionCaptainOfferEntity::class,
                'subscriptionCaptainOfferEntity',
                Join::WITH,
                'subscription.subscriptionCaptainOffer = subscriptionCaptainOfferEntity.id'
            )

            ->andWhere('subscriptionCaptainOfferEntity.status = :status')
            ->setParameter('status', SubscriptionCaptainOffer::SUBSCRIBE_CAPTAIN_OFFER_ACTIVE)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
