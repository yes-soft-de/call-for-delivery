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

    public function getOrderLogsByOrderId($orderId): ?array
    {
        return $this->createQueryBuilder('orderLogsEntity')
            ->select('orderLogsEntity.id, orderLogsEntity.createdAt, orderLogsEntity.orderState')

            ->andWhere("orderLogsEntity.orderId = :orderId")
            
            ->setParameter('orderId',$orderId)
            
            ->getQuery()
            ->getResult();
    }
}
