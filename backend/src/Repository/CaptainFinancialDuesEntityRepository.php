<?php

namespace App\Repository;

use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Entity\CaptainFinancialDemandEntity;
use App\Entity\CaptainFinancialDuesEntity;
use App\Entity\CaptainEntity;
use App\Entity\ImageEntity;
use App\Request\Admin\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueFilterByAdminRequest;
use DateTimeInterface;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\OptimisticLockException;
use Doctrine\ORM\ORMException;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
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

            ->select('captainFinancialDuesEntity.id', 'captainFinancialDuesEntity.status', 'captainFinancialDuesEntity.amount', 'captainFinancialDuesEntity.startDate', 'captainFinancialDuesEntity.endDate',
            'captainFinancialDuesEntity.amountForStore', 'captainFinancialDuesEntity.statusAmountForStore', 'captainFinancialDuesEntity.state', 'captainFinancialDuesEntity.captainStoppedFinancialCycle')
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

    /**
     * Following function commented out because it isn't being used anywhere
     */
//    public function getCaptainFinancialDuesByEndDate(int $userId, DateTime $date): ?array
//    {
//        return $this->createQueryBuilder('captainFinancialDuesEntity')
//
//            ->select('captainFinancialDuesEntity.id, captainFinancialDuesEntity.status, captainFinancialDuesEntity.amount, captainFinancialDuesEntity.startDate, captainFinancialDuesEntity.endDate, captainFinancialDuesEntity.amountForStore')
//
//            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.id = captainFinancialDuesEntity.captain')
//
//            ->andWhere('captainEntity.captainId = :userId')
//
//            ->setParameter('userId', $userId)
//
//            // ->andWhere('captainFinancialDuesEntity.endDate = :date')
//
//            // ->setParameter('date', $date)
//
//            ->andWhere('captainFinancialDuesEntity.state = :state')
//
//            ->setParameter('state', CaptainFinancialDues::FINANCIAL_STATE_ACTIVE)
//
//            ->getQuery()
//
//            ->getOneOrNullResult();
//    }

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

    //get the financial cycle to which the order belongs
//    public function getCaptainFinancialDuesByUserIDAndOrderId(int $userId, int $orderId, string $orderCreatedAt): ?CaptainFinancialDuesEntity
//    {
//        return $this->createQueryBuilder('captainFinancialDuesEntity')
//
//            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.captainId = :userId')
//            ->setParameter('userId', $userId)
//
//            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.id = :orderId')
//            ->setParameter('orderId', $orderId)
//
//            ->andWhere('captainFinancialDuesEntity.captain = captainEntity.id')
//
//            // ->andWhere('captainFinancialDuesEntity.startDate <= orderEntity.createdAt')
//            // ->andWhere('captainFinancialDuesEntity.endDate >= orderEntity.createdAt')
//            ->andWhere('captainFinancialDuesEntity.startDate <= :orderCreatedAt')
//            ->andWhere('captainFinancialDuesEntity.endDate >= :orderCreatedAt')
//            ->setParameter('orderCreatedAt', $orderCreatedAt)
//
//            ->getQuery()
//
//            ->getOneOrNullResult();
//    }

    //--------------->START fix create financial dues
    public function getCaptainFinancialDuesByUserIDAndOrderIdForFixByUserID(int $userId, int $orderId, $createdDate): ?CaptainFinancialDuesEntity
    {
        return $this->createQueryBuilder('captainFinancialDuesEntity')

            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.captainId = :userId')
            ->setParameter('userId', $userId)
           
            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.id = :orderId')
            ->setParameter('orderId', $orderId)

            ->andWhere('captainFinancialDuesEntity.captain = captainEntity.id')

            ->andWhere('captainFinancialDuesEntity.startDate <= :createdDate')
            ->andWhere('captainFinancialDuesEntity.endDate >= :createdDate')  
            ->setParameter('createdDate', $createdDate)                

            ->getQuery()

            ->getOneOrNullResult();
    }

    public function getCaptainFinancialDuesByUserIDAndOrderIdForFix(int $captainId, int $orderId, $createdDate)
    {
        return $this->createQueryBuilder('captainFinancialDuesEntity')
           
            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.id = :orderId')
            ->setParameter('orderId', $orderId)

            ->andWhere('captainFinancialDuesEntity.captain = :captainId')
            ->setParameter('captainId', $captainId)

            ->andWhere('captainFinancialDuesEntity.startDate <= :createdDate')
            ->andWhere('captainFinancialDuesEntity.endDate >= :createdDate')  
            ->setParameter('createdDate', $createdDate)          

            ->getQuery()

            ->getOneOrNullResult();
    }
    //--------------->END fix create financial dues

    public function getFinancialDuesSumByCaptainId(int $captainId): array
    {
        return $this->createQueryBuilder('captainFinancialDuesEntity')
            ->select('SUM(captainFinancialDuesEntity.amount)', 'SUM(captainFinancialDuesEntity.amountForStore)')

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = captainFinancialDuesEntity.captain')

            ->andWhere('captainEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->getQuery()
            ->getSingleResult();
    }

    public function getCaptainFinancialDueEntitiesByCaptainId(int $captainId): array
    {
        return $this->createQueryBuilder('captainFinancialDuesEntity')

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

    public function getCaptainFinancialDueByCaptainProfileIdAndOrderCreationDate(int $captainProfileId, \DateTimeInterface $orderCreationDate)
    {
        return $this->createQueryBuilder('captainFinancialDuesEntity')

            ->andWhere('captainFinancialDuesEntity.captain = :captainProfileId')
            ->setParameter('captainProfileId', $captainProfileId)

            ->andWhere('captainFinancialDuesEntity.startDate <= :specificDate')
            ->andWhere('captainFinancialDuesEntity.endDate >= :specificDate')
            ->setParameter('specificDate', $orderCreationDate)

            ->getQuery()
            ->getResult();
    }

    /**
     * Return Captain Financial Due Sum for each captain and according to filtering options
     */
    public function filterCaptainFinancialDueByAdmin(CaptainFinancialDueFilterByAdminRequest $request)
    {
        $query = $this->createQueryBuilder('captainFinancialDuesEntity')
            ->select('SUM(captainFinancialDuesEntity.amount - captainFinancialDuesEntity.amountForStore) as financialDueAmount',
                'captainEntity.id as captainProfileId', 'captainEntity.captainName', 'imageEntity.imagePath')

            ->andWhere('captainFinancialDuesEntity.amount != :zeroValue')
            ->setParameter('zeroValue', 0)

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = captainFinancialDuesEntity.captain'
            )

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = captainEntity.id AND imageEntity.entityType = :entityType'
                .' AND imageEntity.usedAs = :profileImage'
            )

            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)
            ->setParameter('profileImage', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)
            // following conditions is just to retrieve the financial due (cycle) which started after merging
            // Epic 13 on 2023-07-24
            ->andWhere('captainFinancialDuesEntity.startDate >= :specificStartDate')
            ->setParameter('specificStartDate', new DateTime('2023-07-23 00:00:00'))
            ->andWhere('captainFinancialDuesEntity.endDate > :specificEndDate')
            ->setParameter('specificEndDate', new DateTime('2023-07-25 23:59:59'))
            // ----------------------------------------------------------------------------------------

            ->groupBy('captainFinancialDuesEntity.captain')

            ->orderBy('captainFinancialDuesEntity.id');

        if ($request->getStatus() === CaptainFinancialDues::FINANCIAL_DUES_UNPAID) {
            $query->andWhere('captainFinancialDuesEntity.status = :unpaidStatus')
                ->setParameter('unpaidStatus', CaptainFinancialDues::FINANCIAL_DUES_UNPAID);
        }

        if ($request->getHasCaptainFinancialDueDemanded() === true) {
            $query->leftJoin(
                CaptainFinancialDemandEntity::class,
                'captainFinancialDemandEntity',
                Join::WITH,
                'captainFinancialDemandEntity.captainFinancialDueId = captainFinancialDuesEntity.id'
            )
                ->andWhere('captainFinancialDemandEntity.id IS NOT NULL');
        }

        return $query->getQuery()->getResult();
    }

    public function getCaptainFinancialDuesByCaptainUserIdAndOrderCreationDate(int $captainUserId, DateTimeInterface $dateTimeInterface): array
    {
        return $this->createQueryBuilder('captainFinancialDuesEntity')

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = captainFinancialDuesEntity.captain'
            )

            ->andWhere('captainEntity.captainId = :captainUserId')
            ->setParameter('captainUserId', $captainUserId)

            ->andWhere('captainFinancialDuesEntity.startDate <= :dateTimeInterface')
            ->andWhere('captainFinancialDuesEntity.endDate >= :dateTimeInterface')
            ->setParameter('dateTimeInterface', $dateTimeInterface)

            ->getQuery()
            ->getResult();
    }
}
