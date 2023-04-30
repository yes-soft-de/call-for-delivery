<?php

namespace App\Repository;

use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Entity\OrderEntity;
use App\Entity\StoreOwnerDuesFromCashOrdersEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Constant\Order\OrderAmountCashConstant;


/**
 * @method StoreOwnerDuesFromCashOrdersEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StoreOwnerDuesFromCashOrdersEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StoreOwnerDuesFromCashOrdersEntity[]    findAll()
 * @method StoreOwnerDuesFromCashOrdersEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StoreOwnerDuesFromCashOrdersEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StoreOwnerDuesFromCashOrdersEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(StoreOwnerDuesFromCashOrdersEntity $entity, bool $flush = true): void
    {
        $this->_em->persist($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function remove(StoreOwnerDuesFromCashOrdersEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function filterStoreOwnerDuesFromCashOrders(int $storeId, string $fromDate, string $toDate): ?array
    {
        return $this->createQueryBuilder('storeOwnerDuesFromCashOrders')
    
            ->select('IDENTITY (storeOwnerDuesFromCashOrders.orderId) as orderId')
            ->addSelect('storeOwnerDuesFromCashOrders.id', 'storeOwnerDuesFromCashOrders.amount', 'storeOwnerDuesFromCashOrders.flag', 'storeOwnerDuesFromCashOrders.createdAt', 'storeOwnerDuesFromCashOrders.storeAmount', 'storeOwnerDuesFromCashOrders.captainNote')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
           
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = storeOwnerDuesFromCashOrders.store')
            
            ->andWhere('storeOwnerDuesFromCashOrders.store = :store')
            ->setParameter('store', $storeId)
           
            ->andWhere('storeOwnerDuesFromCashOrders.createdDate >= :fromDate')
            ->setParameter('fromDate', $fromDate)
           
            ->andWhere('storeOwnerDuesFromCashOrders.createdDate <= :toDate')
            ->setParameter('toDate', $toDate)

            // ->andWhere('storeOwnerDuesFromCashOrders.flag = :flag')
            // ->setParameter('flag', OrderAmountCashConstant::ORDER_PAID_FLAG_NO)
            
            ->getQuery()
            ->getResult();
    }

    public function getStoreOwnerDuesFromCashOrders(int $storeId, string $fromDate, string $toDate): ?array
    {
        return $this->createQueryBuilder('storeOwnerDuesFromCashOrders')
    
            ->select('IDENTITY (storeOwnerDuesFromCashOrders.orderId) as orderId')
            ->addSelect('storeOwnerDuesFromCashOrders.id', 'storeOwnerDuesFromCashOrders.amount', 'storeOwnerDuesFromCashOrders.flag', 'storeOwnerDuesFromCashOrders.createdAt')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
           
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = storeOwnerDuesFromCashOrders.store')
            
            ->andWhere('storeOwnerDuesFromCashOrders.store = :store')
            ->setParameter('store', $storeId)
           
            ->andWhere('storeOwnerDuesFromCashOrders.createdDate >= :fromDate')
            ->setParameter('fromDate', $fromDate)
           
            ->andWhere('storeOwnerDuesFromCashOrders.createdDate <= :toDate')
            ->setParameter('toDate', $toDate)
            
            ->andWhere('storeOwnerDuesFromCashOrders.flag = :flag')
            ->setParameter('flag', OrderAmountCashConstant::ORDER_PAID_FLAG_NO)

            ->getQuery()
            ->getResult();
    }

    public function getStoreOwnerDuesFromCashOrdersByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->createQueryBuilder('storeOwnerDuesFromCashOrders')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = storeOwnerDuesFromCashOrders.store'
            )

            ->andWhere('storeOwnerProfileEntity.storeOwnerId = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->getQuery()
            ->getResult();
    }

    /**
     * Get the sum of unpaid cash and delivered orders amount (for store) by specific captain and among specific date
     */
    public function getUnPaidCashOrdersDuesByCaptainAndDuringSpecificTime(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->createQueryBuilder('storeOwnerDuesFromCashOrdersEntity')
            ->select('SUM(storeOwnerDuesFromCashOrdersEntity.amount)')

            ->andWhere('storeOwnerDuesFromCashOrdersEntity.flag = :notPaid')
            ->setParameter('notPaid', OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO)

            ->leftJoin(
                OrderEntity::class,
                'orderEntity',
                Join::WITH,
                'orderEntity.id = storeOwnerDuesFromCashOrdersEntity.orderId'
            )

            ->andWhere('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->andWhere('orderEntity.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)

            ->andWhere('orderEntity.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->getQuery()
            ->getSingleColumnResult();
    }

    /**
     * Get the sum of the unpaid cash orders to store
     */
    public function getUnPaidStoreOwnerDuesFromCashOrderSumByStoreSubscriptionId(int $subscriptionId): array
    {
        return $this->createQueryBuilder('storeOwnerDuesFromCashOrdersEntity')
            ->select('SUM(storeOwnerDuesFromCashOrdersEntity.storeAmount)')

            ->andWhere('storeOwnerDuesFromCashOrdersEntity.flag = :notPaid')
            ->setParameter('notPaid', OrderTypeConstant::ORDER_PAID_TO_PROVIDER_NO)

            ->leftJoin(
                OrderEntity::class,
                'orderEntity',
                Join::WITH,
                'orderEntity.id = storeOwnerDuesFromCashOrdersEntity.orderId'
            )

            ->leftJoin(
                SubscriptionEntity::class,
                'subscriptionEntity',
                Join::WITH,
                'subscriptionEntity.storeOwner = storeOwnerDuesFromCashOrdersEntity.store'
            )

            ->andWhere('subscriptionEntity.id = :subscriptionId')
            ->setParameter('subscriptionId', $subscriptionId)

            ->andWhere('orderEntity.createdAt BETWEEN subscriptionEntity.startDate AND subscriptionEntity.endDate')

            ->getQuery()
            ->getSingleColumnResult();
    }
}
