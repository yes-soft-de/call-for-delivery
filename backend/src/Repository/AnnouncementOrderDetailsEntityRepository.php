<?php

namespace App\Repository;

use App\Entity\AnnouncementOrderDetailsEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method AnnouncementOrderDetailsEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method AnnouncementOrderDetailsEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method AnnouncementOrderDetailsEntity[]    findAll()
 * @method AnnouncementOrderDetailsEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AnnouncementOrderDetailsEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, AnnouncementOrderDetailsEntity::class);
    }

    // /**
    //  * @return AnnouncementOrderDetailsEntity[] Returns an array of AnnouncementOrderDetailsEntity objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('a')
            ->andWhere('a.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('a.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?AnnouncementOrderDetailsEntity
    {
        return $this->createQueryBuilder('a')
            ->andWhere('a.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
