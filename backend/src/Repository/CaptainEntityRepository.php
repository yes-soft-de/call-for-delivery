<?php

namespace App\Repository;

use App\Constant\Captain\CaptainConstant;
use App\Entity\CaptainEntity;
use App\Entity\ImageEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use App\Entity\ChatRoomEntity;
use Doctrine\ORM\Query\Expr\Join;
use App\Constant\Image\ImageEntityTypeConstant;

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
                'captainEntity.salary', 'captainEntity.bounce', 'captainEntity.phone', 'captainEntity.isOnline', 'captainEntity.bankName', 'captainEntity.bankAccountNumber', 'captainEntity.stcPay')
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

    public function getCaptainsProfilesByStatusForAdmin(string $captainProfileStatus): ?array
    {
        $query = $this->createQueryBuilder('captainEntity')
            ->select('captainEntity.id', 'captainEntity.captainId', 'captainEntity.captainName', 'captainEntity.location', 'captainEntity.age', 'captainEntity.car', 'captainEntity.salary',
                'captainEntity.status', 'captainEntity.salary', 'captainEntity.bounce', 'captainEntity.phone', 'captainEntity.isOnline', 'captainEntity.bankName', 'captainEntity.bankAccountNumber', 'captainEntity.stcPay');

        if($captainProfileStatus === CaptainConstant::CAPTAIN_ACTIVE || $captainProfileStatus === CaptainConstant::CAPTAIN_INACTIVE) {
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
                'captainEntity.status', 'chatRoomEntity.roomId')
           ->addSelect('imageEntity.imagePath', 'imageEntity.usedAs')

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
}
