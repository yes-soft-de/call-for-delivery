<?php

namespace App\Repository;

use App\Entity\OrderChatRoomEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method OrderChatRoomEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method OrderChatRoomEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method OrderChatRoomEntity[]    findAll()
 * @method OrderChatRoomEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class OrderChatRoomEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, OrderChatRoomEntity::class);
    }

    // /**
    //  * @return OrderChatRoomEntity[] Returns an array of OrderChatRoomEntity objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('o')
            ->andWhere('o.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('o.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?OrderChatRoomEntity
    {
        return $this->createQueryBuilder('o')
            ->andWhere('o.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
