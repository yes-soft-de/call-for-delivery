<?php

namespace App\Repository;

use App\Constant\CaptainFinancialSystem\CaptainFinancialDaily\CaptainFinancialDailyIsPaidConstant;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Entity\CaptainEntity;
use App\Entity\CaptainFinancialDailyEntity;
use App\Entity\ImageEntity;
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

    /**
     * Filter captain financial daily entities according on dates
     */
    public function filterCaptainFinancialDailyEntitiesByDates(array $tempOrders, ?string $fromDate, ?string $toDate, ?string $timeZone): array
    {
        $filteredCaptainFinancialDaily = [];

        if (count($tempOrders) > 0) {
            if (($fromDate != null || $fromDate != "") && ($toDate === null || $toDate === "")) {
                foreach ($tempOrders as $key => $value) {
                    if ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) >=
                        new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) {
                        $filteredCaptainFinancialDaily[] = $value;
                    }
                }

            } elseif (($fromDate === null || $fromDate === "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $key => $value) {
                    if ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) <=
                        new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59'))) {
                        $filteredCaptainFinancialDaily[] = $value;
                    }
                }

            } elseif (($fromDate != null || $fromDate != "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $key => $value) {
                    if (($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) >=
                            new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) &&
                        ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) <=
                            new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59')))) {
                        $filteredCaptainFinancialDaily[] = $value;
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

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = captainFinancialDailyEntity.captainProfile AND imageEntity.entityType = :entityType'
            )

            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)

            ->andWhere('imageEntity.usedAs = :profileImage')
            ->setParameter('profileImage', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)

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

    /**
     * Filter captain financial daily array according on dates
     */
    public function filterCaptainFinancialDailyArrayByDates(array $tempOrders, ?string $fromDate, ?string $toDate, ?string $timeZone): array
    {
        $filteredCaptainFinancialDaily = [];

        if (count($tempOrders) > 0) {
            if (($fromDate != null || $fromDate != "") && ($toDate === null || $toDate === "")) {
                foreach ($tempOrders as $key => $value) {
                    if ($value[0]->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) >=
                        new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) {
                        $filteredCaptainFinancialDaily[] = $value;
                    }
                }

            } elseif (($fromDate === null || $fromDate === "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $key => $value) {
                    if ($value[0]->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) <=
                        new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59'))) {
                        $filteredCaptainFinancialDaily[] = $value;
                    }
                }

            } elseif (($fromDate != null || $fromDate != "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $key => $value) {
                    if (($value[0]->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) >=
                            new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) &&
                        ($value[0]->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) <=
                            new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59')))) {
                        $filteredCaptainFinancialDaily[] = $value;
                    }
                }
            }
        }

        return $filteredCaptainFinancialDaily;
    }

    /**
     * Filter captain financial daily and return it with captains' images
     */
    public function filterCaptainFinancialDailyWithImagesByAdmin(CaptainFinancialDailyFilterByAdminRequest $request): array
    {
        $query = $this->createQueryBuilder('captainFinancialDailyEntity')

            ->addSelect('imageEntity.imagePath', 'imageEntity.usedAs')

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = captainFinancialDailyEntity.captainProfile AND imageEntity.entityType = :entityType'
            )

            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)

            ->andWhere('imageEntity.usedAs = :profileImage')
            ->setParameter('profileImage', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)

            ->orderBy('captainFinancialDailyEntity.id', 'DESC');

        if ($request->getCaptainProfileId()) {
            $query->andWhere('captainFinancialDailyEntity.captainProfile = :captainProfileId')
                ->setParameter('captainProfileId', $request->getCaptainProfileId());
        }

        if ($request->getIsPaid()) {
            if ($request->getIsPaid() === CaptainFinancialDailyIsPaidConstant::CAPTAIN_FINANCIAL_DAILY_IS_NOT_PAID_CONST) {
                // If not paid captain financial daily amount is what requested, then get what is not paid and what is
                // paid partially
                $query->andWhere('captainFinancialDailyEntity.isPaid = :isNotPaidValue OR captainFinancialDailyEntity.isPaid = :isPaidPartiallyValue')
                    ->setParameter('isNotPaidValue', CaptainFinancialDailyIsPaidConstant::CAPTAIN_FINANCIAL_DAILY_IS_NOT_PAID_CONST)
                    ->setParameter('isPaidPartiallyValue', CaptainFinancialDailyIsPaidConstant::CAPTAIN_FINANCIAL_DAILY_IS_PAID_PARTIALLY_CONST);

            } else {
                $query->andWhere('captainFinancialDailyEntity.isPaid = :isPaidValue')
                    ->setParameter('isPaidValue', $request->getIsPaid());
            }
        }

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
            || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterCaptainFinancialDailyArrayByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
        }

        return $query->getQuery()->getResult();
    }
}
