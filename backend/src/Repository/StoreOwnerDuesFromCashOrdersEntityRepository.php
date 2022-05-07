<?php

namespace App\Repository;

use App\Entity\StoreOwnerDuesFromCashOrdersEntity;
use App\Entity\StoreOwnerProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Constant\Order\OrderAmountCashConstant;


/**
 * @method StoreOwnerDuesFromCashOrdersEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StoreOwnerDuesFromCashOrdersEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StoreOwnerDuesFromCashOrdersEntity[]    findAll()
 * @method StoreOwnerDuesFromCashOrdersEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StoreOwnerDuesFromCashOrdersEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StoreOwnerDuesFromCashOrdersEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(StoreOwnerDuesFromCashOrdersEntity $entity, bool $flush = true): void
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
    public function remove(StoreOwnerDuesFromCashOrdersEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function filterStoreOwnerDuesFromCashOrders(int $storeId, string $fromDate, string $toDate): ?array
    {
        return $this->createQueryBuilder('storeOwnerDuesFromCashOrders')
    
            ->select('IDENTITY (storeOwnerDuesFromCashOrders.orderId) as orderId')
            ->addSelect('storeOwnerDuesFromCashOrders.id', 'storeOwnerDuesFromCashOrders.amount', 'storeOwnerDuesFromCashOrders.flag', 'storeOwnerDuesFromCashOrders.createdAt')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
           
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = storeOwnerDuesFromCashOrders.store')
            
            ->andWhere('storeOwnerDuesFromCashOrders.store = :store')
            ->setParameter('store', $storeId)
           
            ->andWhere('storeOwnerDuesFromCashOrders.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)
           
            ->andWhere('storeOwnerDuesFromCashOrders.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->andWhere('storeOwnerDuesFromCashOrders.flag = :flag')
            ->setParameter('flag', OrderAmountCashConstant::ORDER_PAID_FLAG_NO)
            
            ->getQuery()
            ->getResult();
    }

    public function getStoreOwnerDuesFromCashOrders(int $storeId, string $fromDate, string $toDate): ?array
    {
        return $this->createQueryBuilder('storeOwnerDuesFromCashOrders')
    
            ->select('IDENTITY (storeOwnerDuesFromCashOrders.orderId) as orderId')
            ->addSelect('storeOwnerDuesFromCashOrders.id', 'storeOwnerDuesFromCashOrders.amount', 'storeOwnerDuesFromCashOrders.flag', 'storeOwnerDuesFromCashOrders.createdAt')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
           
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = storeOwnerDuesFromCashOrders.store')
            
            ->andWhere('storeOwnerDuesFromCashOrders.store = :store')
            ->setParameter('store', $storeId)
           
            ->andWhere('storeOwnerDuesFromCashOrders.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)
           
            ->andWhere('storeOwnerDuesFromCashOrders.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)
            
            ->getQuery()
            ->getResult();
    }
}
