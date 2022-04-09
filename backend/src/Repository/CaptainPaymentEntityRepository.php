<?php

namespace App\Repository;

use App\Entity\CaptainPaymentEntity;
use App\Entity\CaptainEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method CaptainPaymentEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainPaymentEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainPaymentEntity[]    findAll()
 * @method CaptainPaymentEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainPaymentEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainPaymentEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(CaptainPaymentEntity $entity, bool $flush = true): void
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
    public function remove(CaptainPaymentEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }
    
    public function  getAllCaptainPayments(int $captainId): ?array
    {
        return $this->createQueryBuilder('captainPaymentEntity')
           
            ->select('IDENTITY (captainPaymentEntity.captain) as captainId')
            ->addSelect('captainPaymentEntity.id', 'captainPaymentEntity.amount', 'captainPaymentEntity.createdAt', 'captainPaymentEntity.note')
            ->addSelect('captainEntity.captainName')
           
            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.id = captainPaymentEntity.captain')
            
            ->andWhere('captainPaymentEntity.captain = :id')
            ->setParameter('id', $captainId)

            ->orderBy('captainPaymentEntity.id', 'DESC')
            
            ->getQuery()
            ->getResult();
    }
}
