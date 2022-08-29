<?php

namespace App\Repository;

use App\Constant\Order\OrderStateConstant;
use App\Entity\OrderChatRoomEntity;
use App\Entity\OrderEntity;
use App\Entity\OrderLogEntity;
use App\Entity\RateEntity;
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

    public function getOrderIdByRoomId(string $roomId): ?array
    {
        return $this->createQueryBuilder('orderChatRoomEntity')
            ->select('identity(orderChatRoomEntity.orderId) as orderId')
           
            ->andWhere('orderChatRoomEntity.roomId = :roomId')
            ->setParameter('roomId', $roomId)
           
            ->orderBy('orderChatRoomEntity.id')
            ->setMaxResults(1)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getOnGoingOrdersChatRoomsForStore(int $userId): array
    {
        $query = $this->createQueryBuilder('orderChatRoomEntity')
            ->select('identity(orderChatRoomEntity.orderId) as orderId')
            ->addSelect('orderChatRoomEntity.id', 'orderChatRoomEntity.usedAs', 'orderChatRoomEntity.createdAt', 'orderChatRoomEntity.roomId')
            ->addSelect('captainEntity.id as captainId', 'captainEntity.captainName', 'captainEntity.captainId as captainUserId')
            ->addSelect('imageEntity.imagePath')
            ->addSelect('orderEntity.state')

            ->leftJoin(
                OrderEntity::class,
                'orderEntity',
                Join::WITH,
                'orderEntity.id = orderChatRoomEntity.orderId'
            )

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.storeOwnerId = :userId'
            )

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = orderChatRoomEntity.captain'
            )

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = captainEntity.id and imageEntity.usedAs = :usedAs and imageEntity.entityType = :entityType'
            )

            ->andWhere('orderEntity.storeOwner = storeOwnerProfileEntity.id')

            ->andWhere('orderChatRoomEntity.usedAs = :orderChatRoomUsedAs')
            ->setParameter('orderChatRoomUsedAs', ChatRoomConstant::CAPTAIN_STORE)

            ->andWhere('orderEntity.state != :cancelledStatus AND orderEntity.state != :pendingStatus')
            ->setParameter('cancelledStatus', OrderStateConstant::ORDER_STATE_CANCEL)
            ->setParameter('pendingStatus', OrderStateConstant::ORDER_STATE_PENDING)

            ->setParameter('userId', $userId)
            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)
            ->setParameter('usedAs', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);

            $tempQuery = $query->getQuery()->getResult();

            // iterates the results, and if there is a delivered order, then check its deliver date
            if (count($tempQuery) > 0) {
                $response = [];

                foreach ($tempQuery as $order) {

                    if ($order['state'] === OrderStateConstant::ORDER_STATE_DELIVERED) {
                        $result = $this->checkIfDeliveredOrderLogCreatedAtBetweenSpecificDates($order['orderId']);

                        if ($result === 1) {
                            $order['avgRating'] = $this->getRatingAverageByCaptainId($order['captainUserId']);
                            $response[] = $order;
                        }

                    } else {
                        $order['avgRating'] = $this->getRatingAverageByCaptainId($order['captainUserId']);
                        $response[] = $order;
                    }
                }

                return $response;
            }

            return $tempQuery;
    }

    public function getRatingAverageByCaptainId(int $captainId): ?string
    {
        $query = $this->createQueryBuilder('orderChatRoomEntity')
            ->select('avg(rateEntity.rating) as avgRating')

            ->leftJoin(
                RateEntity::class,
                'rateEntity',
                Join::WITH,
                'rateEntity.rated = :captainId'
            )

            ->setParameter('captainId', $captainId)

            ->getQuery()
            ->getSingleColumnResult();

        if (count($query) > 0) {
            return $query[0];
        }

        return null;
    }

    public function checkIfDeliveredOrderLogCreatedAtBetweenSpecificDates(int $orderId): int
    {
        $query = $this->createQueryBuilder('orderChatRoomEntity')

            ->leftJoin(
                OrderLogEntity::class,
                'orderLogEntity',
                Join::WITH,
                'orderLogEntity.orderId = orderChatRoomEntity.orderId'
            )

            ->andWhere('orderChatRoomEntity.orderId = :orderIdValue')
            ->setParameter('orderIdValue', $orderId)

            ->andWhere('orderLogEntity.state = :stateValue')
            ->setParameter('stateValue', OrderStateConstant::ORDER_STATE_ARRAY_INT[OrderStateConstant::ORDER_STATE_DELIVERED])

            ->andWhere('orderLogEntity.createdAt >= :specificDate')
            ->setParameter('specificDate', new \DateTime('- 10 minutes'))

            ->getQuery()
            ->getOneOrNullResult();

        if ($query) {
            return 1;
        }

        return 0;
    }
}
