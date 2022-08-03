<?php

namespace App\Repository;

use App\Entity\StoreOwnerPaymentFromCompanyEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Entity\StoreOwnerProfileEntity;

/**
 * @method StoreOwnerPaymentFromCompanyEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method StoreOwnerPaymentFromCompanyEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method StoreOwnerPaymentFromCompanyEntity[]    findAll()
 * @method StoreOwnerPaymentFromCompanyEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class StoreOwnerPaymentFromCompanyEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StoreOwnerPaymentFromCompanyEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(StoreOwnerPaymentFromCompanyEntity $entity, bool $flush = true): void
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
    public function remove(StoreOwnerPaymentFromCompanyEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function  getAllStorePaymentsFromCompany(int $storeId): ?array
    {
        return $this->createQueryBuilder('storeOwnerPaymentFromCompanyEntity')
           
            ->select('IDENTITY (storeOwnerPaymentFromCompanyEntity.store) as storeId')
            ->addSelect('storeOwnerPaymentFromCompanyEntity.id', 'storeOwnerPaymentFromCompanyEntity.amount', 'storeOwnerPaymentFromCompanyEntity.createdAt', 'storeOwnerPaymentFromCompanyEntity.note')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
           
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = storeOwnerPaymentFromCompanyEntity.store')
            
            ->andWhere('storeOwnerPaymentFromCompanyEntity.store = :id')
            ->setParameter('id', $storeId)

            ->orderBy('storeOwnerPaymentFromCompanyEntity.id', 'DESC')
            
            ->getQuery()
            ->getResult();
    }

    public function  getSumPaymentsFromCompany(int $storeId): ?array
    {
        return $this->createQueryBuilder('storeOwnerPaymentFromCompanyEntity')
           
            ->select('sum (storeOwnerPaymentFromCompanyEntity.amount) as sumPaymentsFromCompany')
           
            ->andWhere('storeOwnerPaymentFromCompanyEntity.store = :storeId')
            ->setParameter('storeId', $storeId)
            
            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function  getSumPaymentsFromCompanyInSpecificDate(int $storeId, string $fromDate, string $toDate): ?array
    {
        return $this->createQueryBuilder('storeOwnerPaymentFromCompanyEntity')
           
            ->select('sum (storeOwnerPaymentFromCompanyEntity.amount) as sumPaymentsFromCompany')
           
            ->andWhere('storeOwnerPaymentFromCompanyEntity.store = :storeId')
            ->setParameter('storeId', $storeId)
            
            ->andWhere('storeOwnerPaymentFromCompanyEntity.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)
           
            ->andWhere('storeOwnerPaymentFromCompanyEntity.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getPaymentsFromCompanyByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->createQueryBuilder('storeOwnerPaymentFromCompanyEntity')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = storeOwnerPaymentFromCompanyEntity.store'
            )

            ->andWhere('storeOwnerProfileEntity.storeOwnerId = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->getQuery()
            ->getResult();
    }
}
