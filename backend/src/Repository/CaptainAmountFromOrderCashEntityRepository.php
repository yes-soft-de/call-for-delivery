<?php

namespace App\Repository;

use App\Entity\CaptainAmountFromOrderCashEntity;
use App\Entity\CaptainEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Constant\Order\OrderAmountCashConstant;

/**
 * @method CaptainAmountFromOrderCashEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainAmountFromOrderCashEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainAmountFromOrderCashEntity[]    findAll()
 * @method CaptainAmountFromOrderCashEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainAmountFromOrderCashEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainAmountFromOrderCashEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(CaptainAmountFromOrderCashEntity $entity, bool $flush = true): void
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
    public function remove(CaptainAmountFromOrderCashEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function filterCaptainAmountFromOrderCash(int $captainId, string $fromDate, string $toDate): ?array
    {
        return $this->createQueryBuilder('captainAmountFromOrderCash')
    
            ->select('IDENTITY (captainAmountFromOrderCash.orderId) as orderId')
            ->addSelect('captainAmountFromOrderCash.id', 'captainAmountFromOrderCash.amount', 'captainAmountFromOrderCash.flag', 'captainAmountFromOrderCash.createdAt')
            ->addSelect('captainEntity.captainName')
           
            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.id = captainAmountFromOrderCash.captain')
            
            ->andWhere('captainAmountFromOrderCash.captain = :captainId')
            ->setParameter('captainId', $captainId)
           
            ->andWhere('captainAmountFromOrderCash.flag = :flag')
            ->setParameter('flag', OrderAmountCashConstant::ORDER_PAID_FLAG_NO)
            
            ->andWhere('captainAmountFromOrderCash.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)
           
            ->andWhere('captainAmountFromOrderCash.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->getQuery()
            ->getResult();
    }

    public function getCaptainAmountFromOrderCash(int $captainId, string $fromDate, string $toDate): ?array
    {
        return $this->createQueryBuilder('captainAmountFromOrderCash')
    
            ->select('IDENTITY (captainAmountFromOrderCash.orderId) as orderId')
            ->addSelect('captainAmountFromOrderCash.id', 'captainAmountFromOrderCash.amount', 'captainAmountFromOrderCash.flag', 'captainAmountFromOrderCash.createdAt')
            ->addSelect('captainEntity.captainName')
           
            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.id = captainAmountFromOrderCash.captain')
            
            ->andWhere('captainAmountFromOrderCash.captain = :captainId')
            ->setParameter('captainId', $captainId)
            
            ->andWhere('captainAmountFromOrderCash.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)
           
            ->andWhere('captainAmountFromOrderCash.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->getQuery()
            ->getResult();
    }
}
