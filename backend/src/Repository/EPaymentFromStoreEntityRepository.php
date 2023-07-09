<?php

namespace App\Repository;

use App\Entity\EPaymentFromStoreEntity;
use App\Request\Admin\EPaymentFromStore\EPaymentFromStoreFilterByAdminRequest;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method EPaymentFromStoreEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method EPaymentFromStoreEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method EPaymentFromStoreEntity[]    findAll()
 * @method EPaymentFromStoreEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class EPaymentFromStoreEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, EPaymentFromStoreEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(EPaymentFromStoreEntity $entity, bool $flush = true): void
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
    public function remove(EPaymentFromStoreEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function filterEPaymentFromStoreByAdmin(EPaymentFromStoreFilterByAdminRequest $request): array
    {
        $query = $this->createQueryBuilder('ePaymentFromStoreEntity')

            ->orderBy('ePaymentFromStoreEntity.id', 'DESC');

        if ($request->getStoreOwnerProfileId()) {
            $query->andWhere('ePaymentFromStoreEntity.storeOwnerProfile = :storeOwnerProfileId')
                ->setParameter('storeOwnerProfileId', $request->getStoreOwnerProfileId());
        }

        if (((($request->getFromDate()) || $request->getFromDate() != "") && ((! $request->getToDate()) || $request->getToDate() === ""))
            || ((! $request->getFromDate()) || $request->getFromDate() === "") && (($request->getToDate()) || $request->getToDate() != "")
            || (($request->getFromDate()) || $request->getFromDate() != "") && (($request->getToDate())|| $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterEPaymentFromStoreEntitiesArrayByDates($tempQuery, $request->getFromDate(),
                $request->getToDate(), $request->getCustomizedTimezone());
        }

        return $query->getQuery()->getResult();
    }

    private function filterEPaymentFromStoreEntitiesArrayByDates(array $tempOrders, ?string $fromDate, ?string $toDate, ?string $timeZone): array
    {
        $filteredOrders = [];

        if (count($tempOrders) > 0) {
            if ((($fromDate) || $fromDate != "") && ((! $toDate) || $toDate === "")) {
                foreach ($tempOrders as $value) {
                    if ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) >=
                        new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) {
                        $filteredOrders[] = $value;
                    }
                }

            } elseif (((! $fromDate) || $fromDate === "") && (($toDate) || $toDate != "")) {
                foreach ($tempOrders as $value) {
                    if ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) <=
                        new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59'))) {
                        $filteredOrders[] = $value;
                    }
                }

            } elseif ((($fromDate) || $fromDate != "") && (($toDate) || $toDate != "")) {
                foreach ($tempOrders as $value) {
                    if (($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) >=
                            new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) &&
                        ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) <=
                            new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59')))) {
                        $filteredOrders[] = $value;
                    }
                }
            }
        }

        return $filteredOrders;
    }
}
