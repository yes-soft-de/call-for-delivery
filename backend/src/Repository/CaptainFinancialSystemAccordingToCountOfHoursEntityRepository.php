<?php

namespace App\Repository;

use App\Entity\CaptainFinancialSystemAccordingToCountOfHoursEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method CaptainFinancialSystemAccordingToCountOfHoursEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainFinancialSystemAccordingToCountOfHoursEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainFinancialSystemAccordingToCountOfHoursEntity[]    findAll()
 * @method CaptainFinancialSystemAccordingToCountOfHoursEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainFinancialSystemAccordingToCountOfHoursEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainFinancialSystemAccordingToCountOfHoursEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(CaptainFinancialSystemAccordingToCountOfHoursEntity $entity, bool $flush = true): void
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
    public function remove(CaptainFinancialSystemAccordingToCountOfHoursEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    // /**
    //  * @return CaptainFinancialSystemAccordingToCountOfHoursEntity[] Returns an array of CaptainFinancialSystemAccordingToCountOfHoursEntity objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('c')
            ->andWhere('c.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('c.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?CaptainFinancialSystemAccordingToCountOfHoursEntity
    {
        return $this->createQueryBuilder('c')
            ->andWhere('c.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
