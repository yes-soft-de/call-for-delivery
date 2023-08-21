<?php

namespace App\Repository;

use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Constant\StoreOwnerDueFromCashOrder\StoreOwnerDueFromCashOrderStoreAmountConstant;
use App\Entity\OrderEntity;
use App\Entity\StoreOwnerDuesFromCashOrdersEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\SubscriptionEntity;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreDueSumFromCashOrderFilterByAdminRequest;
use App\Request\Admin\StoreOwnerDuesFromCashOrders\StoreOwnerDueFromCashOrderFilterByAdminRequest;
use DateTime;
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
            ->addSelect('storeOwnerDuesFromCashOrders.id', 'storeOwnerDuesFromCashOrders.amount', 'storeOwnerDuesFromCashOrders.flag', 'storeOwnerDuesFromCashOrders.createdAt',
                'storeOwnerDuesFromCashOrders.storeAmount', 'storeOwnerDuesFromCashOrders.captainNote')
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
    
            ->select('IDENTITY(storeOwnerDuesFromCashOrders.orderId) as orderId')
            ->addSelect('storeOwnerDuesFromCashOrders.id', 'storeOwnerDuesFromCashOrders.amount', 'storeOwnerDuesFromCashOrders.flag', 'storeOwnerDuesFromCashOrders.createdAt',
                'storeOwnerDuesFromCashOrders.storeAmount')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
           
            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = storeOwnerDuesFromCashOrders.store'
            )
            
            ->andWhere('storeOwnerDuesFromCashOrders.store = :store')
            ->setParameter('store', $storeId)
           
            ->andWhere('storeOwnerDuesFromCashOrders.createdDate >= :fromDate')
            ->setParameter('fromDate', (new \DateTime($fromDate))->setTime(0, 0,0))
           
            ->andWhere('storeOwnerDuesFromCashOrders.createdDate <= :toDate')
            ->setParameter('toDate', (new \DateTime($toDate))->setTime(0, 0,0))
            
            ->andWhere('storeOwnerDuesFromCashOrders.flag = :flag OR storeOwnerDuesFromCashOrders.flag = :partiallyPaidFlag')
            ->setParameter('flag', OrderAmountCashConstant::ORDER_PAID_FLAG_NO)
            ->setParameter('partiallyPaidFlag', OrderAmountCashConstant::ORDER_PAID_FLAG_PARTIALLY_CONST)

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
            ->select('SUM(storeOwnerDuesFromCashOrdersEntity.storeAmount)')

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

    /**
     * Get all stores due sum from cash orders depending on filtering options
     */
    public function filterStoreDueFromCashOrdersByAdmin(StoreDueSumFromCashOrderFilterByAdminRequest $request): array
    {
        $query = $this->createQueryBuilder('storeOwnerDuesFromCashOrdersEntity')

            ->andWhere('storeOwnerDuesFromCashOrdersEntity.storeAmount != :zeroValue')
            ->setParameter('zeroValue', StoreOwnerDueFromCashOrderStoreAmountConstant::STORE_AMOUNT_ZERO_VALUE_CONST);

        if ($request->getIsPaid()) {
            if ($request->getIsPaid() === OrderAmountCashConstant::ORDER_PAID_FLAG_NO) {
                $query->andWhere('storeOwnerDuesFromCashOrdersEntity.flag = :notPaidFlag OR storeOwnerDuesFromCashOrdersEntity.flag = :paidPartiallyFlag')
                    ->setParameter('notPaidFlag', OrderAmountCashConstant::ORDER_PAID_FLAG_NO)
                    ->setParameter('paidPartiallyFlag', OrderAmountCashConstant::ORDER_PAID_FLAG_PARTIALLY_CONST);
            }
        }

        return $query->getQuery()->getResult();
    }

    /**
     * Get the sum of a specific store due and depending on paid flag
     */
    public function getStoreOwnerDueSumFromCashOrderByIsPaidFlagAndStoreOwnerProfileId(int $storeOwnerProfileId, int $isPaid = null): array
    {
        $query = $this->createQueryBuilder('storeOwnerDuesFromCashOrdersEntity')
            ->select('SUM(storeOwnerDuesFromCashOrdersEntity.storeAmount)')

            ->andWhere('storeOwnerDuesFromCashOrdersEntity.store = :storeOwnerProfileId')
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId);

        if ($isPaid) {
            if ($isPaid === OrderAmountCashConstant::ORDER_PAID_FLAG_NO) {
                $query->andWhere('storeOwnerDuesFromCashOrdersEntity.flag = :notPaidFlag OR storeOwnerDuesFromCashOrdersEntity.flag = :paidPartiallyFlag')
                    ->setParameter('notPaidFlag', OrderAmountCashConstant::ORDER_PAID_FLAG_NO)
                    ->setParameter('paidPartiallyFlag', OrderAmountCashConstant::ORDER_PAID_FLAG_PARTIALLY_CONST);
            }
        }

        return $query->getQuery()->getSingleColumnResult();
    }

    /**
     * Filter all store owners due from cash orders by admin
     */
    public function filterStoreOwnerDueFromCashOrderByAdmin(StoreOwnerDueFromCashOrderFilterByAdminRequest $request): array
    {
        $query = $this->createQueryBuilder('storeOwnerDuesFromCashOrdersEntity')

            ->andWhere('storeOwnerDuesFromCashOrdersEntity.storeAmount != :zeroValue')
            ->setParameter('zeroValue', StoreOwnerDueFromCashOrderStoreAmountConstant::STORE_AMOUNT_ZERO_VALUE_CONST)

            ->orderBy('storeOwnerDuesFromCashOrdersEntity.id', 'DESC');

        if ($request->getStoreOwnerProfileId()) {
            $query->andWhere('storeOwnerDuesFromCashOrdersEntity.store = :storeOwnerProfileId')
                ->setParameter('storeOwnerProfileId', $request->getStoreOwnerProfileId());
        }

        if ($request->getIsPaid()) {
            $query->andWhere('storeOwnerDuesFromCashOrdersEntity.flag = :isPaidFlag')
                ->setParameter('isPaidFlag', $request->getIsPaid());
        }

        if (((($request->getFromDate()) || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && (($request->getToDate()) || $request->getToDate() != "")
            || (($request->getFromDate()) || $request->getFromDate() != "") && (($request->getToDate()) || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            // Filter array of store owners due from cash orders entities by optional dates
            return $this->filterStoreDueFromCashOrderEntitiesArrayByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
        }

        return $query->getQuery()->getResult();
    }

    /**
     * Filter array of store owners due from cash orders entities by optional dates
     */
    public function filterStoreDueFromCashOrderEntitiesArrayByDates(array $tempOrders, ?string $fromDate, ?string $toDate, ?string $timeZone): array
    {
        $filteredStoreDueFromCashOrder = [];

        if (count($tempOrders) > 0) {
            if (($fromDate != null || $fromDate != "") && ($toDate === null || $toDate === "")) {
                foreach ($tempOrders as $value) {
                    if ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) >=
                        new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) {
                        $filteredStoreDueFromCashOrder[] = $value;
                    }
                }

            } elseif (($fromDate === null || $fromDate === "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $value) {
                    if ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) <=
                        new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59'))) {
                        $filteredStoreDueFromCashOrder[] = $value;
                    }
                }

            } elseif (($fromDate != null || $fromDate != "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $value) {
                    if (($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) >=
                            new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) &&
                        ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) <=
                            new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59')))) {
                        $filteredStoreDueFromCashOrder[] = $value;
                    }
                }
            }
        }

        return $filteredStoreDueFromCashOrder;
    }

    /**
     * Get the sum of a specific store due and depending on dates
     */
    public function getStoreOwnerDueSumFromCashOrderByStoreOwnerProfileIdAndTwoDates(int $storeOwnerProfileId, DateTime $firstDayOfMonth, DateTime $lastDayOfMonth): array
    {
        return $this->createQueryBuilder('storeOwnerDuesFromCashOrdersEntity')
            ->select('SUM(storeOwnerDuesFromCashOrdersEntity.storeAmount)')

            ->andWhere('storeOwnerDuesFromCashOrdersEntity.store = :storeOwnerProfileId')
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->andWhere('storeOwnerDuesFromCashOrdersEntity.createdDate >= :firstDayOfMonth')
            ->setParameter('firstDayOfMonth', $firstDayOfMonth)

            ->andWhere('storeOwnerDuesFromCashOrdersEntity.createdDate <= :lastDayOfMonth')
            ->setParameter('lastDayOfMonth', $lastDayOfMonth)

            ->getQuery()
            ->getSingleColumnResult();
    }

    public function getStoreOwnerDueFromCashOrderByStoreOwnerProfileIdAndTwoDates(int $storeOwnerProfileId, DateTime $firstDayOfMonth, DateTime $lastDayOfMonth): array
    {
        return $this->createQueryBuilder('storeOwnerDuesFromCashOrdersEntity')

            ->andWhere('storeOwnerDuesFromCashOrdersEntity.store = :storeOwnerProfileId')
            ->setParameter('storeOwnerProfileId', $storeOwnerProfileId)

            ->andWhere('storeOwnerDuesFromCashOrdersEntity.createdDate >= :firstDayOfMonth')
            ->setParameter('firstDayOfMonth', $firstDayOfMonth)

            ->andWhere('storeOwnerDuesFromCashOrdersEntity.createdDate <= :lastDayOfMonth')
            ->setParameter('lastDayOfMonth', $lastDayOfMonth)

            ->getQuery()
            ->getResult();
    }
}
