<?php

namespace App\Repository;

use App\Entity\CaptainPaymentEntity;
use App\Entity\CaptainEntity;
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
    
    public function  getAllCaptainPayments(int $captainId): ?array
    {
        return $this->createQueryBuilder('captainPaymentEntity')
           
            ->select('IDENTITY (captainPaymentEntity.captain) as captainId')
            ->addSelect('captainPaymentEntity.id', 'captainPaymentEntity.amount', 'captainPaymentEntity.createdAt', 'captainPaymentEntity.note')
            ->addSelect('captainEntity.captainName')
           
            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.id = captainPaymentEntity.captain')
            
            ->andWhere('captainPaymentEntity.captain = :id')
            ->setParameter('id', $captainId)

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
}
