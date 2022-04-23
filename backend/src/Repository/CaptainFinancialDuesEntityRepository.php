<?php

namespace App\Repository;

use App\Entity\CaptainFinancialDuesEntity;
use App\Entity\CaptainEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method CaptainFinancialDuesEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainFinancialDuesEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainFinancialDuesEntity[]    findAll()
 * @method CaptainFinancialDuesEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainFinancialDuesEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainFinancialDuesEntity::class);
    }

    /**
     * @throws ORMException
     * @throws OptimisticLockException
     */
    public function add(CaptainFinancialDuesEntity $entity, bool $flush = true): void
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
    public function remove(CaptainFinancialDuesEntity $entity, bool $flush = true): void
    {
        $this->_em->remove($entity);
        if ($flush) {
            $this->_em->flush();
        }
    }

    public function getCaptainFinancialDuesByUserId(int $userId): array
    {
        return $this->createQueryBuilder('captainFinancialDuesEntity')

            ->select('captainFinancialDuesEntity.id, captainFinancialDuesEntity.status, captainFinancialDuesEntity.amount, captainFinancialDuesEntity.startDate, captainFinancialDuesEntity.endDate, captainFinancialDuesEntity.amountForStore, captainFinancialDuesEntity.statusAmountForStore')
            ->addSelect('captainEntity.id as captainId, captainEntity.captainName')
            
            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.captainId = :userId')

            ->andWhere('captainFinancialDuesEntity.captain = captainEntity.id')

            ->setParameter('userId', $userId)
            
            ->orderBy('captainFinancialDuesEntity.id', 'DESC')
            
            ->getQuery()

            ->getResult();
    }

    public function getCaptainFinancialDuesByCaptainId(int $captainId): array
    {
        return $this->createQueryBuilder('captainFinancialDuesEntity')

            ->select('captainFinancialDuesEntity.id, captainFinancialDuesEntity.status, captainFinancialDuesEntity.amount, captainFinancialDuesEntity.startDate, captainFinancialDuesEntity.endDate, captainFinancialDuesEntity.amountForStore, captainFinancialDuesEntity.statusAmountForStore')
            ->addSelect('captainEntity.id as captainId, captainEntity.captainName')
            
            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.id = captainFinancialDuesEntity.captain')

            ->andWhere('captainFinancialDuesEntity.captain = :captainId')

            ->setParameter('captainId', $captainId)
            
            ->orderBy('captainFinancialDuesEntity.id', 'DESC')
            
            ->getQuery()

            ->getResult();
    }
}
