<?php

namespace App\Repository;

use App\Entity\CaptainEntity;
use App\Entity\CaptainFinancialDailyEntity;
use App\Request\Admin\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyFilterByAdminRequest;
use App\Request\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyFilterRequest;
use DateTime;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method CaptainFinancialDailyEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainFinancialDailyEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainFinancialDailyEntity[]    findAll()
 * @method CaptainFinancialDailyEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainFinancialDailyEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainFinancialDailyEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(CaptainFinancialDailyEntity $entity, bool $flush = true): void
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
    public function remove(CaptainFinancialDailyEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function getCaptainFinancialDailyByDateAndCaptainProfileId(DateTime $date, int $captainProfileId): ?CaptainFinancialDailyEntity
    {
        return $this->createQueryBuilder('captainFinancialDailyEntity')

            ->andWhere('captainFinancialDailyEntity.createdAt BETWEEN :fromDate AND :toDate')
            ->setParameter('fromDate', $date->format('Y-m-d 00:00:00'))
            ->setParameter('toDate', $date->format('Y-m-d 23:59:59'))

            ->andWhere('captainFinancialDailyEntity.captainProfile = :captainProfileId')
            ->setParameter('captainProfileId', $captainProfileId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCaptainFinancialDailyByDateAndCaptainUserId(DateTime $date, int $captainUserId): ?CaptainFinancialDailyEntity
    {
        return $this->createQueryBuilder('captainFinancialDailyEntity')

            ->andWhere('captainFinancialDailyEntity.createdAt = :specificDate')
            ->setParameter('specificDate', $date)

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = captainFinancialDailyEntity.captainProfile'
            )

            ->andWhere('captainEntity.captainId = :captainId')
            ->setParameter('captainId', $captainUserId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function filterCaptainFinancialDailyEntitiesByDates(array $tempOrders, ?string $fromDate, ?string $toDate, ?string $timeZone): array
    {
        $filteredCaptainFinancialDaily = [];

        if (count($tempOrders) > 0) {
            if (($fromDate != null || $fromDate != "") && ($toDate === null || $toDate === "")) {
                foreach ($tempOrders as $key => $value) {
                    if ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) >=
                        new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) {
                        $filteredCaptainFinancialDaily[$key] = $value;
                    }
                }

            } elseif (($fromDate === null || $fromDate === "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $key => $value) {
                    if ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) <=
                        new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59'))) {
                        $filteredCaptainFinancialDaily[$key] = $value;
                    }
                }

            } elseif (($fromDate != null || $fromDate != "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $key => $value) {
                    if (($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) >=
                            new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) &&
                        ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) <=
                            new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59')))) {
                        $filteredCaptainFinancialDaily[$key] = $value;
                    }
                }
            }
        }

        return $filteredCaptainFinancialDaily;
    }

    public function filterCaptainFinancialDaily(CaptainFinancialDailyFilterRequest $request): array
    {
        $query = $this->createQueryBuilder('captainFinancialDailyEntity')

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = captainFinancialDailyEntity.captainProfile'
            )

            ->andWhere('captainEntity.captainId = :captainId')
            ->setParameter('captainId', $request->getCaptainUserId())

            ->orderBy('captainFinancialDailyEntity.id', 'DESC');

        if ($request->getIsPaid()) {
            $query->andWhere('captainFinancialDailyEntity.isPaid = :isPaidValue')
                ->setParameter('isPaidValue', $request->getIsPaid());
        }

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
            || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterCaptainFinancialDailyEntitiesByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
        }

        return $query->getQuery()->getResult();
    }

    public function filterCaptainFinancialDailyByAdmin(CaptainFinancialDailyFilterByAdminRequest $request): array
    {
        $query = $this->createQueryBuilder('captainFinancialDailyEntity')

            ->orderBy('captainFinancialDailyEntity.id', 'DESC');

        if ($request->getCaptainProfileId()) {
            $query->andWhere('captainFinancialDailyEntity.captainProfile = :captainProfileId')
                ->setParameter('captainProfileId', $request->getCaptainProfileId());
        }

        if ($request->getIsPaid()) {
            $query->andWhere('captainFinancialDailyEntity.isPaid = :isPaidValue')
                ->setParameter('isPaidValue', $request->getIsPaid());
        }

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
            || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterCaptainFinancialDailyEntitiesByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
        }

        return $query->getQuery()->getResult();
    }
}
