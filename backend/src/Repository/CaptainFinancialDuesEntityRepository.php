<?php

namespace App\Repository;

use App\Entity\CaptainFinancialDuesEntity;
use App\Entity\CaptainEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Entity\CaptainPaymentEntity;
use DateTime;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Entity\OrderEntity;

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

            ->select('captainFinancialDuesEntity.id, captainFinancialDuesEntity.status, captainFinancialDuesEntity.amount, captainFinancialDuesEntity.startDate, captainFinancialDuesEntity.endDate, captainFinancialDuesEntity.amountForStore, captainFinancialDuesEntity.statusAmountForStore', 'captainFinancialDuesEntity.captainStoppedFinancialCycle')
            ->addSelect('captainEntity.id as captainId, captainEntity.captainName')
            
            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.id = captainFinancialDuesEntity.captain')

            ->andWhere('captainFinancialDuesEntity.captain = :captainId')

            ->setParameter('captainId', $captainId)
            
            ->orderBy('captainFinancialDuesEntity.id', 'DESC')
            
            ->getQuery()

            ->getResult();
    }

    public function getSumCaptainFinancialDuesById(int $id): array
    {
        return $this->createQueryBuilder('captainFinancialDuesEntity')

            ->select('sum( captainFinancialDuesEntity.amount) as sumCaptainFinancialDues')

            ->andWhere('captainFinancialDuesEntity.id = :id')

            ->setParameter('id', $id)
            
            ->getQuery()

            ->getOneOrNullResult();
    }
   
    public function getLatestCaptainFinancialDues(int $captainId): ?array
    {
        return $this->createQueryBuilder('captainFinancialDuesEntity')

            ->select('captainFinancialDuesEntity.id, captainFinancialDuesEntity.status, captainFinancialDuesEntity.amount, captainFinancialDuesEntity.startDate, captainFinancialDuesEntity.endDate, captainFinancialDuesEntity.amountForStore, captainFinancialDuesEntity.captainStoppedFinancialCycle')
            
            ->andWhere('captainFinancialDuesEntity.captain = :captainId')

            ->setParameter('captainId', $captainId)
            
            ->orderBy('captainFinancialDuesEntity.id', 'DESC')
            
            ->setMaxResults(1)

            ->getQuery()

            ->getOneOrNullResult();
    }

    public function getCaptainFinancialDuesByEndDate(int $userId, DateTime $date): ?array
    {
        return $this->createQueryBuilder('captainFinancialDuesEntity')

            ->select('captainFinancialDuesEntity.id, captainFinancialDuesEntity.status, captainFinancialDuesEntity.amount, captainFinancialDuesEntity.startDate, captainFinancialDuesEntity.endDate, captainFinancialDuesEntity.amountForStore')
            
            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.id = captainFinancialDuesEntity.captain')

            ->andWhere('captainEntity.captainId = :userId')

            ->setParameter('userId', $userId)
            
            // ->andWhere('captainFinancialDuesEntity.endDate = :date')

            // ->setParameter('date', $date)

            ->andWhere('captainFinancialDuesEntity.state = :state')

            ->setParameter('state', CaptainFinancialDues::FINANCIAL_STATE_ACTIVE)

            ->getQuery()

            ->getOneOrNullResult();
    }

    public function getFinancialDuesByCaptainId(int $captainId): array
    {
        return $this->createQueryBuilder('captainFinancialDuesEntity')

            ->select('captainFinancialDuesEntity.id')

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = captainFinancialDuesEntity.captain')

            ->andWhere('captainEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->orderBy('captainFinancialDuesEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function getLatestCaptainFinancialDuesByUserId(int $userId): CaptainFinancialDuesEntity
    {
        return $this->createQueryBuilder('captainFinancialDuesEntity')

            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.captainId = :userId')

            ->andWhere('captainFinancialDuesEntity.captain = captainEntity.id')
            ->setParameter('userId', $userId)

            // ->andWhere('captainFinancialDuesEntity.state = :state')
            // ->setParameter('state', CaptainFinancialDues::FINANCIAL_STATE_ACTIVE)
            
            ->orderBy('captainFinancialDuesEntity.id', 'DESC')

            ->setMaxResults(1)

            ->getQuery()

            ->getOneOrNullResult();
    }
    //get the financial cycle to which the order belongs
    public function getCaptainFinancialDuesByUserIDAndOrderId(int $userId, int $orderId): ?CaptainFinancialDuesEntity
    {
        return $this->createQueryBuilder('captainFinancialDuesEntity')

            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.captainId = :userId')
            ->setParameter('userId', $userId)
           
            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.id = :orderId')
            ->setParameter('orderId', $orderId)

            ->andWhere('captainFinancialDuesEntity.captain = captainEntity.id')

            ->andWhere('captainFinancialDuesEntity.startDate <= orderEntity.createdAt')
            ->andWhere('captainFinancialDuesEntity.endDate >= orderEntity.createdAt')            

            ->getQuery()

            ->getOneOrNullResult();
    }
}
