<?php

namespace App\Repository;

use App\Entity\SubscriptionHistoryEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method SubscriptionHistoryEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method SubscriptionHistoryEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method SubscriptionHistoryEntity[]    findAll()
 * @method SubscriptionHistoryEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class SubscriptionHistoryEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, SubscriptionHistoryEntity::class);
    }

    // /**
    //  * @return SubscriptionHistoryEntity[] Returns an array of SubscriptionHistoryEntity objects
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
    public function findOneBySomeField($value): ?SubscriptionHistoryEntity
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
