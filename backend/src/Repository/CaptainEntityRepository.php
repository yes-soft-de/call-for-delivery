<?php

namespace App\Repository;

use App\Entity\CaptainEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Entity\ChatRoomEntity;
use Doctrine\ORM\Query\Expr\Join;

/**
 * @method CaptainEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CaptainEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CaptainEntity[]    findAll()
 * @method CaptainEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CaptainEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CaptainEntity::class);
    }

    public function getCaptainByCaptainId($id): ?array
    {
        return $this->createQueryBuilder('captainEntity')

            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName', 'captainEntity.location', 'captainEntity.images', 'captainEntity.age', 'captainEntity.car', 'captainEntity.drivingLicence', 'captainEntity.salary',
                'captainEntity.salary', 'captainEntity.bounce', 'captainEntity.phone', 'captainEntity.isOnline', 'captainEntity.bankName', 'captainEntity.bankAccountNumber', 'captainEntity.stcPay', 'captainEntity.mechanicLicense', 'captainEntity.identity')
            ->addSelect('chatRoomEntity.roomId')
           
            ->leftJoin(ChatRoomEntity::class, 'chatRoomEntity', Join::WITH, 'chatRoomEntity.userId = captainEntity.captainId')
            
            ->andWhere('captainEntity.captainId = :id')
            ->setParameter('id', $id)
            
            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function getUserProfile($captainId): mixed
    {
        return $this->createQueryBuilder('captainEntity')

            ->andWhere('captainEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCompleteAccountStatusByCaptainId($captainId): ?array
    {
        return $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.completeAccountStatus')

            ->andWhere('captainEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function captainIsActive($captainId): ?array
    {
        return $this->createQueryBuilder('captainEntity')

            ->select('captainEntity.status')

            ->andWhere('captainEntity.captainId = :captainId')

            ->setParameter('captainId', $captainId)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
