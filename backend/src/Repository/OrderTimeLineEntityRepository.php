<?php

namespace App\Repository;

use App\Entity\OrderTimeLineEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method OrderTimeLineEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method OrderTimeLineEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method OrderTimeLineEntity[]    findAll()
 * @method OrderTimeLineEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class OrderTimeLineEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, OrderTimeLineEntity::class);
    }

    public function getOrderTimeLineByOrderId(int $orderId): ?array
    {
        return $this->createQueryBuilder('orderTimeLineEntity')
            ->select('orderTimeLineEntity.id, orderTimeLineEntity.createdAt, orderTimeLineEntity.orderState, orderTimeLineEntity.isCaptainArrived')

            ->andWhere("orderTimeLineEntity.orderId = :orderId")
            
            ->setParameter('orderId',$orderId)
            
            ->orderBy('orderTimeLineEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function getCurrentStage(int $orderId): ?array
    {
        return $this->createQueryBuilder('orderTimeLineEntity')
            ->select('orderTimeLineEntity.id, orderTimeLineEntity.createdAt, orderTimeLineEntity.orderState')

            ->andWhere("orderTimeLineEntity.orderId = :orderId")
            
            ->setParameter('orderId',$orderId)
            
            ->orderBy('orderTimeLineEntity.id', 'DESC')

            ->setMaxResults(1)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
