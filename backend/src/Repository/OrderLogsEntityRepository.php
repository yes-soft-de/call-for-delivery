<?php

namespace App\Repository;

use App\Entity\OrderLogsEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method OrderLogsEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method OrderLogsEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method OrderLogsEntity[]    findAll()
 * @method OrderLogsEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class OrderLogsEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, OrderLogsEntity::class);
    }

    public function getOrderLogsByOrderId(int $orderId): ?array
    {
        return $this->createQueryBuilder('orderLogsEntity')
            ->select('orderLogsEntity.id, orderLogsEntity.createdAt, orderLogsEntity.orderState, orderLogsEntity.isCaptainArrived')

            ->andWhere("orderLogsEntity.orderId = :orderId")
            
            ->setParameter('orderId',$orderId)
            
            ->orderBy('orderLogsEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function getCurrentStage(int $orderId): ?array
    {
        return $this->createQueryBuilder('orderLogsEntity')
            ->select('orderLogsEntity.id, orderLogsEntity.createdAt, orderLogsEntity.orderState')

            ->andWhere("orderLogsEntity.orderId = :orderId")
            
            ->setParameter('orderId',$orderId)
            
            ->orderBy('orderLogsEntity.id', 'DESC')

            ->setMaxResults(1)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
