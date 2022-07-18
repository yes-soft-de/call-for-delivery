<?php

namespace App\Repository;

use App\Entity\StoreOwnerPaymentEntity;
use App\Entity\StoreOwnerProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method StoreOwnerPaymentEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StoreOwnerPaymentEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StoreOwnerPaymentEntity[]    findAll()
 * @method StoreOwnerPaymentEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StoreOwnerPaymentEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StoreOwnerPaymentEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(StoreOwnerPaymentEntity $entity, bool $flush = true): void
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
    public function remove(StoreOwnerPaymentEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }
    
    public function  getAllStorePayments(int $storeId): ?array
    {
        return $this->createQueryBuilder('storeOwnerPaymentEntity')
           
            ->select('IDENTITY (storeOwnerPaymentEntity.store) as storeId')
            ->addSelect('storeOwnerPaymentEntity.id', 'storeOwnerPaymentEntity.amount', 'storeOwnerPaymentEntity.date', 'storeOwnerPaymentEntity.note')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
           
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = storeOwnerPaymentEntity.store')
            
            ->andWhere('storeOwnerPaymentEntity.store = :id')
            ->setParameter('id', $storeId)

            ->orderBy('storeOwnerPaymentEntity.id', 'DESC')
            
            ->getQuery()
            ->getResult();
    }
    
    public function  getStorePaymentsBySubscriptionId(int $subscriptionId): ?array
    {
        return $this->createQueryBuilder('storeOwnerPaymentEntity')
           
            ->addSelect('storeOwnerPaymentEntity.id', 'storeOwnerPaymentEntity.amount', 'storeOwnerPaymentEntity.date', 'storeOwnerPaymentEntity.note')
           
            ->andWhere('storeOwnerPaymentEntity.subscription = :subscriptionId')
            ->setParameter('subscriptionId', $subscriptionId)

            ->orderBy('storeOwnerPaymentEntity.id', 'DESC')
            
            ->getQuery()
            ->getResult();
    }

    public function getPaymentsByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->createQueryBuilder('storeOwnerPaymentEntity')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = storeOwnerPaymentEntity.store'
            )

            ->andWhere('storeOwnerProfileEntity.storeOwnerId = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->getQuery()
            ->getResult();
    }
}