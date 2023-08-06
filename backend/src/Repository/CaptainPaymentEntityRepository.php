<?php

namespace App\Repository;

use App\Constant\CaptainPayment\PaymentToCaptain\CaptainPaymentConstant;
use App\Entity\CaptainFinancialDemandEntity;
use App\Entity\CaptainPaymentEntity;
use App\Entity\CaptainEntity;
use App\Request\Admin\CaptainPayment\PaymentToCaptain\CaptainPaymentFilterByAdminRequest;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use DateTime;
use App\Request\CaptainPayment\CaptainPaymentFilterRequest;
use App\Entity\CaptainFinancialDuesEntity;

/**
 * @method CaptainPaymentEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainPaymentEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainPaymentEntity[]    findAll()
 * @method CaptainPaymentEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainPaymentEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainPaymentEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(CaptainPaymentEntity $entity, bool $flush = true): void
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
    public function remove(CaptainPaymentEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }
    
    public function getAllCaptainPayments(int $captainId): array
    {
        return $this->createQueryBuilder('captainPaymentEntity')
           
            ->select('IDENTITY (captainPaymentEntity.captain) as captainId')
            ->addSelect('captainPaymentEntity.id', 'captainPaymentEntity.amount', 'captainPaymentEntity.createdAt', 'captainPaymentEntity.note')
            ->addSelect('captainEntity.captainName')
           
            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.id = captainPaymentEntity.captain')
            
            ->andWhere('captainPaymentEntity.captain = :id')
            ->setParameter('id', $captainId)

            ->andWhere('captainPaymentEntity.captainFinancialDailyEntity IS NULL')

            ->orderBy('captainPaymentEntity.id', 'DESC')
            
            ->getQuery()
            ->getResult();
    }
    
    public function  getCaptainPaymentsFilter(CaptainPaymentFilterRequest $request): array
    { 
        $query = $this->createQueryBuilder('captainPaymentEntity')
                    ->select('captainPaymentEntity.id', 'captainPaymentEntity.amount', 'captainPaymentEntity.createdAt', 'captainPaymentEntity.note')
           
                    ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.captainId = :userId')
            
                    ->andWhere('captainPaymentEntity.captain = captainEntity.id')
                    
                    ->setParameter('userId', $request->getUserId())
                    
                    ->orderBy('captainPaymentEntity.id', 'DESC');

        if (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === "")) {
            $query->andWhere('captainPaymentEntity.createdAt >= :createdAt');
            $query->setParameter('createdAt', $request->getFromDate());

        } elseif (($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('captainPaymentEntity.createdAt <= :createdAt');
            $query->setParameter('createdAt', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));

        } elseif (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('captainPaymentEntity.createdAt >= :fromDate');
            $query->setParameter('fromDate', $request->getFromDate());

            $query->andWhere('captainPaymentEntity.createdAt <= :toDate');
            $query->setParameter('toDate', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));
        }

        return $query->getQuery()->getResult();
    }

    public function getSumPayments(int $captainId): array
    {
        return $this->createQueryBuilder('captainPaymentEntity')

            ->select('sum(captainPaymentEntity.amount) as sumPayments')

            ->where('captainPaymentEntity.captain = :captainId')
            ->setParameter('captainId', $captainId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getPaymentsByCaptainFinancialDues(int $captainFinancialDues): array
    {
        return $this->createQueryBuilder('captainPaymentEntity')

            ->select('captainPaymentEntity.id', 'captainPaymentEntity.amount', 'captainPaymentEntity.createdAt', 'captainPaymentEntity.note')

            ->where('captainPaymentEntity.captainFinancialDues = :captainFinancialDues')
            ->setParameter('captainFinancialDues', $captainFinancialDues)

            ->getQuery()
            ->getResult();
    }

    public function getSumPaymentsToCaptainByCaptainFinancialDuesId(int $captainFinancialDues): array
    {
        return $this->createQueryBuilder('captainPaymentEntity')

            ->select('sum(captainPaymentEntity.amount) as sumPaymentsToCaptain')

            ->where('captainPaymentEntity.captainFinancialDues = :captainFinancialDues')
            ->setParameter('captainFinancialDues', $captainFinancialDues)

            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function getSumPaymentsToCaptainByCaptainIdAndDate(dateTime $fromDate, dateTime $toDate, int $captainId): ?array
    {
        return $this->createQueryBuilder('captainPaymentEntity')

            ->select('sum(captainPaymentEntity.amount) as sumPaymentsToCaptain')

            ->leftJoin(captainFinancialDuesEntity::class, 'captainFinancialDuesEntity', Join::WITH, 'captainFinancialDuesEntity.captain = :captainId')

            ->andWhere('captainFinancialDuesEntity.startDate >= :fromDate')
            ->andWhere('captainFinancialDuesEntity.endDate <= :toDate')
            ->andWhere('captainPaymentEntity.captainFinancialDues = captainFinancialDuesEntity.id')
            ->andWhere('captainPaymentEntity.captainFinancialDailyEntity IS NULL')

            ->setParameter('captainId', $captainId)
            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)
            
            ->getQuery()

            ->getOneOrNullResult();
    }

    public function getPaymentsByCaptainId(int $captainId): array
    {
        return $this->createQueryBuilder('captainPaymentEntity')
            ->select('captainPaymentEntity.id')

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = captainPaymentEntity.captain'
            )

            ->andWhere('captainEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->orderBy('captainPaymentEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function filterCaptainPaymentByAdmin(CaptainPaymentFilterByAdminRequest $request): array
    {
        $query = $this->createQueryBuilder('captainPaymentEntity')

            ->andWhere('captainPaymentEntity.captainFinancialDues IS NULL')
            ->andWhere('captainPaymentEntity.captainFinancialDailyEntity IS NOT NULL')

            ->orderBy('captainPaymentEntity.id', 'DESC');

        if ($request->getCaptainProfileId()) {
            $query->andWhere('captainPaymentEntity.captain = :captainProfileId')
                ->setParameter('captainProfileId', $request->getCaptainProfileId());
        }

        return $query->getQuery()->getResult();
    }

    /**
     * epic 13
     */
    public function filterCaptainPaymentByAdminV2(CaptainPaymentFilterByAdminRequest $request): array
    {
        $query = $this->createQueryBuilder('captainPaymentEntity')

            // following conditions is just to retrieve the payments which started after merging
            // Epic 13 on 2023-07-24
            ->andWhere('captainPaymentEntity.createdAt > :specificDate')
            ->setParameter('specificDate', new DateTime('2023-07-04 00:00:00'))

            ->orderBy('captainPaymentEntity.id', 'DESC');

        if ($request->getCaptainProfileId()) {
            $query->andWhere('captainPaymentEntity.captain = :captainProfileId')
                ->setParameter('captainProfileId', $request->getCaptainProfileId());
        }

        if ($request->getCaptainId()) {
            $query->andWhere('captainPaymentEntity.captain = :captainId')
                ->setParameter('captainId', $request->getCaptainId());
        }

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
            || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterCaptainPaymentEntitiesByOptionalStringDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
        }

        return $query->getQuery()->getResult();
    }

    /**
     * epic 13
     */
    public function filterCaptainPaymentCaptain(CaptainPaymentFilterRequest $request): array
    {
        $query = $this->createQueryBuilder('captainPaymentEntity')

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = captainPaymentEntity.captain'
            )

            ->andWhere('captainEntity.captainId = :captainUserId')
            ->setParameter('captainUserId', $request->getUserId())

            // this condition for preventing previous payments (before Epic 13) from returning
            ->andWhere('captainPaymentEntity.paymentGetaway != :notSpecifiedPaymentGetaway')
            ->setParameter('notSpecifiedPaymentGetaway', CaptainPaymentConstant::PAYMENT_GETAWAY_NOT_SPECIFIED_CONST)

            ->orderBy('captainPaymentEntity.id', 'DESC');

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
            || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterCaptainPaymentEntitiesByOptionalStringDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
        }

        return $query->getQuery()->getResult();
    }

    public function filterCaptainPaymentEntitiesByOptionalStringDates(array $tempOrders, ?string $fromDate, ?string $toDate, ?string $timeZone): array
    {
        $filteredOrders = [];

        if (count($tempOrders) > 0) {
            if (($fromDate != null || $fromDate != "") && ($toDate === null || $toDate === "")) {
                foreach ($tempOrders as $value) {
                    if ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) >=
                        new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) {
                        $filteredOrders[] = $value;
                    }
                }

            } elseif (($fromDate === null || $fromDate === "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $value) {
                    if ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) <=
                        new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59'))) {
                        $filteredOrders[] = $value;
                    }
                }

            } elseif (($fromDate != null || $fromDate != "") && ($toDate != null || $toDate != "")) {
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

    public function getCaptainPaymentSumByCaptainProfileIdAndCaptainFinancialDemand(int $captainProfileId): array
    {
        return $this->createQueryBuilder('captainPaymentEntity')
            ->select('SUM(captainPaymentEntity.amount)')

            ->andWhere('captainPaymentEntity.captain = :captainProfileId')
            ->setParameter('captainProfileId', $captainProfileId)

            ->leftJoin(
                CaptainFinancialDuesEntity::class,
                'captainFinancialDueEntity',
                Join::WITH,
                'captainFinancialDueEntity.id = captainPaymentEntity.captainFinancialDues'
            )

            ->leftJoin(
                CaptainFinancialDemandEntity::class,
                'captainFinancialDemandEntity',
                Join::WITH,
                'captainFinancialDemandEntity.captainFinancialDueId = captainFinancialDueEntity.id'
            )

            ->andWhere('captainFinancialDemandEntity.id IS NOT NULL')
            // following conditions is just to retrieve the financial due (cycle) which started after merging
            // Epic 13 on 2023-07-24
            ->andWhere('captainFinancialDueEntity.startDate >= :specificStartDate')
            ->setParameter('specificStartDate', new DateTime('2023-07-23 00:00:00'))
            ->andWhere('captainFinancialDueEntity.endDate > :specificEndDate')
            ->setParameter('specificEndDate', new DateTime('2023-07-25 23:59:59'))
            // ----------------------------------------------------------------------------------------

            ->getQuery()
            ->getSingleColumnResult();
    }

    public function getLastCaptainPaymentByCaptainProfileId(int $captainProfileId): array
    {
        return $this->createQueryBuilder('captainPaymentEntity')

            ->andWhere('captainPaymentEntity.captain = :captainProfileId')
            ->setParameter('captainProfileId', $captainProfileId)

            ->andWhere('captainPaymentEntity.createdAt >= :date')
            ->setParameter('date', new DateTime('2023-07-24 00:00:00'))

            ->orderBy('captainPaymentEntity.id', 'DESC')
            ->setMaxResults(1)

            ->getQuery()
            ->getResult();
    }
}
