<?php

namespace App\Repository;

use App\Constant\Captain\CaptainConstant;
use App\Entity\CaptainEntity;
use App\Entity\ImageEntity;
use App\Entity\UserEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Entity\ChatRoomEntity;
use Doctrine\ORM\Query\Expr\Join;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\Image\ImageUseAsConstant;
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

            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName', 'captainEntity.location', 'captainEntity.age', 'captainEntity.car', 'captainEntity.salary',
                'captainEntity.salary', 'captainEntity.bounce', 'captainEntity.phone', 'captainEntity.isOnline', 'captainEntity.bankName', 'captainEntity.bankAccountNumber', 'captainEntity.stcPay', 'captainEntity.status')
            ->addSelect('chatRoomEntity.roomId')
            ->addSelect('imageEntity.imagePath', 'imageEntity.usedAs')
           
            ->leftJoin(ChatRoomEntity::class, 'chatRoomEntity', Join::WITH, 'chatRoomEntity.userId = captainEntity.captainId')
            ->leftJoin(ImageEntity::class, 'imageEntity', Join::WITH, 'imageEntity.itemId = captainEntity.id and imageEntity.entityType = :entityType')
            
            ->andWhere('captainEntity.captainId = :id')

            ->setParameter('id', $id)
            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)
            
            ->getQuery()
            ->getResult();
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
            ->addSelect('userEntity.status')

            ->andWhere('captainEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.id = captainEntity.captainId'
            )

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function captainIsActive($captainId): ?array
    {
        return $this->createQueryBuilder('captainEntity')

            ->select('captainEntity.status', 'captainEntity.isOnline')

            ->andWhere('captainEntity.captainId = :captainId')

            ->setParameter('captainId', $captainId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getCaptainsProfilesByStatusForAdmin(string $captainProfileStatus): array
    {
        $query = $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName', 'captainEntity.location', 'captainEntity.age', 'captainEntity.car', 'captainEntity.salary',
                'captainEntity.status', 'captainEntity.bounce', 'captainEntity.phone', 'captainEntity.isOnline', 'captainEntity.bankName', 'captainEntity.bankAccountNumber', 'captainEntity.stcPay', 'captainEntity.completeAccountStatus')
            ->addSelect('userEntity.userId', 'userEntity.verificationStatus')

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.id = captainEntity.captainId'
            );

        if ($captainProfileStatus === CaptainConstant::CAPTAIN_ACTIVE || $captainProfileStatus === CaptainConstant::CAPTAIN_INACTIVE) {
            $query->andWhere('captainEntity.status = :captainProfileStatus');
            $query->setParameter('captainProfileStatus', $captainProfileStatus);
        }

        $query->orderBy('captainEntity.id', 'DESC');

        return $query->getQuery()->getResult();
    }

    public function getCaptainProfileByIdForAdmin(int $captainProfileId): ?array
    {
        return $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName', 'captainEntity.location', 'captainEntity.age', 'captainEntity.car', 'captainEntity.salary',
                'captainEntity.salary', 'captainEntity.bounce', 'captainEntity.phone', 'captainEntity.isOnline', 'captainEntity.bankName', 'captainEntity.bankAccountNumber', 'captainEntity.stcPay',
                'captainEntity.completeAccountStatus', 'captainEntity.status', 'chatRoomEntity.roomId')
            ->addSelect('imageEntity.imagePath', 'imageEntity.usedAs')
            ->addSelect('userEntity.userId', 'userEntity.verificationStatus')

            ->leftJoin(
                UserEntity::class,
                'userEntity',
                Join::WITH,
                'userEntity.id = captainEntity.captainId'
            )

            ->leftJoin(
                ChatRoomEntity::class,
                'chatRoomEntity',
                Join::WITH,
                'chatRoomEntity.userId = captainEntity.captainId')
            
           ->leftJoin(ImageEntity::class, 'imageEntity', Join::WITH, 'imageEntity.itemId = captainEntity.id and imageEntity.entityType = :entityType')

            ->andWhere('captainEntity.id = :captainProfileId')

            ->setParameter('captainProfileId', $captainProfileId)
           
           ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)

            ->getQuery()
            ->getResult();
    }

    public function getCaptain(int $captainProfileId): ?array
    {
        return $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName', 'captainEntity.location', 'captainEntity.age', 'captainEntity.car', 'captainEntity.salary',
                'captainEntity.salary', 'captainEntity.bounce', 'captainEntity.phone', 'captainEntity.isOnline', 'captainEntity.bankName', 'captainEntity.bankAccountNumber', 'captainEntity.stcPay',
                'captainEntity.status')

            ->andWhere('captainEntity.id = :captainProfileId')

            ->setParameter('captainProfileId', $captainProfileId)
           
            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function getCaptainFinancialSystemStatus(int $captainId): ?array
    {
        return $this->createQueryBuilder('captainEntity')

            ->select('captainFinancialSystemDetailEntity.status')
            
            ->leftJoin(CaptainFinancialSystemDetailEntity::class, 'captainFinancialSystemDetailEntity', Join::WITH, 'captainFinancialSystemDetailEntity.captain = captainEntity.id')

            ->andWhere('captainEntity.captainId = :captainId')

            ->setParameter('captainId', $captainId)
            
            ->orderBy('captainFinancialSystemDetailEntity.id', 'DESC')
            
            ->setMaxResults(1)
            
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getReadyCaptainsAndCountOfTheirCurrentOrders(): array
    {
        return $this->createQueryBuilder('captainEntity')

            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName', 'captainEntity.location', 'captainEntity.age', 'captainEntity.car', 'captainEntity.salary',
        'captainEntity.salary', 'captainEntity.bounce', 'captainEntity.phone', 'captainEntity.isOnline', 'captainEntity.bankName', 'captainEntity.bankAccountNumber', 'captainEntity.stcPay',
        'captainEntity.status')
            ->addSelect('imageEntity.imagePath', 'imageEntity.usedAs')
            ->addSelect('chatRoomEntity.roomId')
           
            ->leftJoin(ChatRoomEntity::class, 'chatRoomEntity', Join::WITH, 'chatRoomEntity.userId = captainEntity.captainId')
            ->andWhere('captainEntity.status = :status')
            ->setParameter('status', CaptainConstant::CAPTAIN_ACTIVE)

            ->andWhere('captainEntity.isOnline = :isOnline')
            ->setParameter('isOnline', CaptainConstant::CAPTAIN_ONLINE_TRUE)

            ->leftJoin(CaptainFinancialSystemDetailEntity::class, 'captainFinancialSystemDetailEntity', Join::WITH, 'captainFinancialSystemDetailEntity.captain = captainEntity.id')

            ->andWhere('captainFinancialSystemDetailEntity.status = :financialSystemStatus')
            ->setParameter('financialSystemStatus', CaptainFinancialSystem::CAPTAIN_FINANCIAL_SYSTEM_ACTIVE)
         
            ->leftJoin(ImageEntity::class, 'imageEntity', Join::WITH, 'imageEntity.itemId = captainEntity.id and imageEntity.entityType = :entityType and imageEntity.usedAs = :usedAs')
        
            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)
            ->setParameter('usedAs', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)
            
            ->orderBy('captainEntity.id', 'DESC')
            
            ->getQuery()
            ->getResult();
    }
}
