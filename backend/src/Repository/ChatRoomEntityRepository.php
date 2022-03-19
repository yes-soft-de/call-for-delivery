<?php

namespace App\Repository;

use App\Entity\CaptainEntity;
use App\Entity\ChatRoomEntity;
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

            ->select('chatRoom.roomId')
            ->addSelect('captainEntity.id as captainProfileId, captainEntity.captainName')

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'chatRoom.userId = captainEntity.captainId'
            )

            ->andWhere('chatRoom.usedAs = :usedAs')
            ->setParameter('usedAs', ChatRoomConstant::ADMIN_CAPTAIN)

            ->getQuery()
            ->getResult();
    }
}
