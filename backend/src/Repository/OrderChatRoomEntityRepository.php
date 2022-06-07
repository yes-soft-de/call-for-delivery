<?php

namespace App\Repository;

use App\Entity\OrderChatRoomEntity;
use App\Entity\OrderEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\CaptainEntity;
use App\Entity\ImageEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Constant\ChatRoom\ChatRoomConstant;

/**
 * @method OrderChatRoomEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method OrderChatRoomEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method OrderChatRoomEntity[]    findAll()
 * @method OrderChatRoomEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class OrderChatRoomEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, OrderChatRoomEntity::class);
    }

    public function getOrderChatRoomsForStoreBeforeOrderAccepted($userId): ?array
    {
        return $this->createQueryBuilder('orderChatRoomEntity')
            ->select('identity(orderChatRoomEntity.orderId) as orderId')
            ->addSelect('orderChatRoomEntity.id', 'orderChatRoomEntity.usedAs', 'orderChatRoomEntity.createdAt', 'orderChatRoomEntity.roomId')
            ->addSelect('captainEntity.id as captainId', 'captainEntity.captainName')
            ->addSelect('imageEntity.imagePath')
          
            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.id = orderChatRoomEntity.orderId')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.storeOwnerId = :userId')
            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.id = orderChatRoomEntity.captain')
            ->leftJoin(ImageEntity::class, 'imageEntity', Join::WITH, 'imageEntity.itemId = captainEntity.id and imageEntity.usedAs = :usedAs and imageEntity.entityType = :entityType')
         
            ->andWhere('orderEntity.storeOwner = storeOwnerProfileEntity.id')
            ->andWhere('orderChatRoomEntity.usedAs = :orderChatRoomUsedAs')
         
            ->setParameter('userId', $userId)
            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)
            ->setParameter('usedAs', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)
            ->setParameter('orderChatRoomUsedAs', ChatRoomConstant::CAPTAIN_STORE_ENQUIRE)

            ->getQuery()
            ->getResult();
    }

    public function getOrderChatRoomEntitiesByCaptainId(int $captainId): array
    {
        return $this->createQueryBuilder('orderChatRoomEntity')

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = orderChatRoomEntity.captain'
            )

            ->andWhere('captainEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->getQuery()
            ->getResult();
    }
}
