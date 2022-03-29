<?php

namespace App\Repository;

use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Entity\CaptainEntity;
use App\Entity\ChatRoomEntity;
use App\Entity\ImageEntity;
use App\Entity\StoreOwnerProfileEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Constant\ChatRoom\ChatRoomConstant;

/**
 * @method ChatRoomEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ChatRoomEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ChatRoomEntity[]    findAll()
 * @method ChatRoomEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ChatRoomEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ChatRoomEntity::class);
    }

    public function getChatRoomsWithStores(): ?array
     {   
        return $this->createQueryBuilder('chatRoom')

            ->select('chatRoom.roomId')
            ->addSelect('storeOwnerProfile.id as storeOwnerProfileId, storeOwnerProfile.storeOwnerName, storeOwnerProfile.images')
          
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'chatRoom.userId = storeOwnerProfile.storeOwnerId')

            ->andWhere('chatRoom.usedAs = :usedAs')
            ->setParameter('usedAs', ChatRoomConstant::ADMIN_STORE)

            ->getQuery()

            ->getResult();
     }

    public function getChatRoomsWithCaptains(): ?array
    {
        return $this->createQueryBuilder('chatRoom')
            ->select('chatRoom.roomId', 'captainEntity.id as captainProfileId, captainEntity.captainName')
            ->addSelect('imageEntity.imagePath')
        
            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'chatRoom.userId = captainEntity.captainId'
            )

           ->leftJoin(
               ImageEntity::class,
               'imageEntity',
               Join::WITH,
               'imageEntity.itemId = captainEntity.id and imageEntity.usedAs = :usedAsImage and imageEntity.entityType = :entityType')

           ->andWhere('chatRoom.usedAs = :usedAsChat')

           ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)
           ->setParameter('usedAsImage', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)
           ->setParameter('usedAsChat', ChatRoomConstant::ADMIN_CAPTAIN)

            ->getQuery()
            ->getResult();
    }
}
