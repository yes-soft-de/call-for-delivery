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
            ->addSelect('captainEntity.captainName')
            ->addSelect('imageEntity.imagePath')
          
            ->leftJoin(OrderEntity::class, 'orderEntity', Join::WITH, 'orderEntity.id = orderChatRoomEntity.orderId')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.storeOwnerId = :userId')
            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.id = orderEntity.captainId')
            ->leftJoin(ImageEntity::class, 'imageEntity', Join::WITH, 'imageEntity.itemId = captainEntity.id')
         
            ->andWhere('orderEntity.storeOwner = storeOwnerProfileEntity.id ')
            ->andWhere('imageEntity.entityType = :entityType ')
            ->andWhere('imageEntity.usedAs = :usedAs ')
         
            ->setParameter('userId', $userId)
            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)
            ->setParameter('usedAs', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)

            ->getQuery()
            ->getResult();
    }
}
