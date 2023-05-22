<?php

namespace App\Repository;

use App\Entity\OrderDistanceConflictEntity;
use App\Entity\OrderEntity;
use App\Entity\StoreOrderDetailsEntity;
use App\Request\Admin\OrderDistanceConflict\OrderDistanceConflictFilterByAdminRequest;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method OrderDistanceConflictEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method OrderDistanceConflictEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method OrderDistanceConflictEntity[]    findAll()
 * @method OrderDistanceConflictEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class OrderDistanceConflictEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, OrderDistanceConflictEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(OrderDistanceConflictEntity $entity, bool $flush = true): void
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
    public function remove(OrderDistanceConflictEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    /**
     * Filters orders distance conflicts by admin
     */
    public function filterOrderDistanceConflictByAdmin(OrderDistanceConflictFilterByAdminRequest $request)
    {
        $query = $this->createQueryBuilder('orderDistanceConflictEntity')

            ->orderBy('orderDistanceConflictEntity.id', 'DESC');

        if ($request->getIsResolved() !== null) {
            $query->andWhere('orderDistanceConflictEntity.isResolved = :resolvedValue')
                ->setParameter('resolvedValue', $request->getIsResolved());
        }

        if ($request->getStoreOwnerProfileId()) {
            $query->leftJoin(
                OrderEntity::class,
                'orderEntity',
                Join::WITH,
                'orderEntity.id = orderDistanceConflictEntity.orderId'
            )
                ->andWhere('orderEntity.storeOwner = :storeOwnerProfileId')
                ->setParameter('storeOwnerProfileId', $request->getStoreOwnerProfileId());
        }

        if ($request->getStoreBranchId()) {
            $query->leftJoin(
                StoreOrderDetailsEntity::class,
                'storeOrderDetailsEntity',
                Join::WITH,
                'storeOrderDetailsEntity.orderId = orderDistanceConflictEntity.orderId'
            )
                ->andWhere('storeOrderDetailsEntity.branch = :storeBranchId')
                ->setParameter('storeBranchId', $request->getStoreBranchId());
        }

        if (((($request->getFromDate()) || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && (($request->getToDate()) || $request->getToDate() != "")
            || (($request->getFromDate()) || $request->getFromDate() != "") && (($request->getToDate()) || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterOrderDistanceConflictEntitiesByDates($tempQuery, $request->getFromDate(), $request->getToDate(),
                $request->getCustomizedTimezone());
        }

        return $query->getQuery()->getResult();
    }

    /**
     * Filter array of OrderDistanceConflictEntity by two dates of type string and customized timezone
     */
    public function filterOrderDistanceConflictEntitiesByDates(array $tempOrders, ?string $fromDate, ?string $toDate, ?string $timeZone): array
    {
        $filteredOrders = [];

        if (count($tempOrders) > 0) {
            if (($fromDate != null || $fromDate != "") && ($toDate === null || $toDate === "")) {
                foreach ($tempOrders as $key => $value) {
                    if ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) >=
                        new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) {
                        $filteredOrders[$key] = $value;
                    }
                }

            } elseif (($fromDate === null || $fromDate === "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $key => $value) {
                    if ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) <=
                        new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59'))) {
                        $filteredOrders[$key] = $value;
                    }
                }

            } elseif (($fromDate != null || $fromDate != "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $key => $value) {
                    if (($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) >=
                            new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) &&
                        ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) <=
                            new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59')))) {
                        $filteredOrders[$key] = $value;
                    }
                }
            }
        }

        return $filteredOrders;
    }
}
