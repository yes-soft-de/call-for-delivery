<?php

namespace App\Repository;

use App\Entity\CaptainPaymentToCompanyEntity;
use App\Entity\CaptainEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use DateTime;
use App\Request\CaptainPayment\CaptainPaymentFilterRequest;

/**
 * @method CaptainPaymentToCompanyEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainPaymentToCompanyEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainPaymentToCompanyEntity[]    findAll()
 * @method CaptainPaymentToCompanyEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainPaymentToCompanyEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainPaymentToCompanyEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(CaptainPaymentToCompanyEntity $entity, bool $flush = true): void
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
    public function remove(CaptainPaymentToCompanyEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }
 
    public function  getAllCaptainPaymentsToCompany(int $captainId): ?array
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
    
    public function  getSumPaymentsToCompanyInSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->createQueryBuilder('captainPaymentEntity')

            ->select('sum(captainPaymentEntity.amount) as sumPayments')

            ->where('captainPaymentEntity.captain = :captainId')
            ->setParameter('captainId', $captainId)

            ->andWhere('captainPaymentEntity.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)
           
            ->andWhere('captainPaymentEntity.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getPaymentToCompanyByCaptainId(int $captainId): array
    {
        return $this->createQueryBuilder('captainPaymentToCompanyEntity')
            ->select('captainPaymentToCompanyEntity.id')

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = captainPaymentToCompanyEntity.captain'
            )

            ->andWhere('captainEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->orderBy('captainPaymentToCompanyEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }
}
