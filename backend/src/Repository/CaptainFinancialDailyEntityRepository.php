<?php

namespace App\Repository;

use App\Entity\CaptainFinancialDailyEntity;
use DateTime;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
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

    public function getCaptainFinancialDailyByDate(DateTime $date): ?CaptainFinancialDailyEntity
    {
        return $this->createQueryBuilder('captainFinancialDailyEntity')

            ->andWhere('captainFinancialDailyEntity.createdAt BETWEEN :fromDate AND :toDate')
            ->setParameter('fromDate', $date->format('Y-m-d 00:00:00'))
            ->setParameter('toDate', $date->format('Y-m-d 23:59:59'))

            ->getQuery()
            ->getOneOrNullResult();
    }
}
