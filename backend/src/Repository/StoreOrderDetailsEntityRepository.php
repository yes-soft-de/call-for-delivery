<?php

namespace App\Repository;

use App\Entity\StoreOrderDetailsEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method StoreOrderDetailsEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StoreOrderDetailsEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StoreOrderDetailsEntity[]    findAll()
 * @method StoreOrderDetailsEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StoreOrderDetailsEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StoreOrderDetailsEntity::class);
    }

    // /**
    //  * @return StoreOrderDetailsEntity[] Returns an array of StoreOrderDetailsEntity objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('s')
            ->andWhere('s.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('s.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?StoreOrderDetailsEntity
    {
        return $this->createQueryBuilder('s')
            ->andWhere('s.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
