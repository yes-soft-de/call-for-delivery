<?php

namespace App\Repository;

use App\Entity\CaptainFinancialSystemDetailEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method CaptainFinancialSystemDetailEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainFinancialSystemDetailEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainFinancialSystemDetailEntity[]    findAll()
 * @method CaptainFinancialSystemDetailEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainFinancialSystemDetailEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainFinancialSystemDetailEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(CaptainFinancialSystemDetailEntity $entity, bool $flush = true): void
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
    public function remove(CaptainFinancialSystemDetailEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    // /**
    //  * @return CaptainFinancialSystemDetail[] Returns an array of CaptainFinancialSystemDetail objects
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
    public function findOneBySomeField($value): ?CaptainFinancialSystemDetail
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
