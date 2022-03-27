<?php

namespace App\Repository;

use App\Constant\Order\OrderStateConstant;
use App\Entity\OrderEntity;
use App\Entity\CaptainEntity;
use App\Entity\StoreOrderDetailsEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\ImageEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\OrderChatRoomEntity;
use App\Request\Admin\Order\OrderFilterByAdminRequest;
use App\Request\Order\OrderFilterByCaptainRequest;
use App\Request\Order\OrderFilterRequest;
use DateTime;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Entity\RateEntity;
/**
 * @method OrderEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method OrderEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method OrderEntity[]    findAll()
 * @method OrderEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class OrderEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, OrderEntity::class);
    }

    public function getStoreOrders(int $storeOwner): ?array
     {   
        return $this->createQueryBuilder('orderEntity')

            ->addSelect('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note',
             'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer')
            ->addSelect('storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName',
             'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            
            ->andWhere('orderEntity.storeOwner = :storeOwner')

            ->setParameter('storeOwner', $storeOwner)
       
            ->orderBy('orderEntity.id', 'DESC')
       
            ->getQuery()

            ->getResult();
    }

    public function getSpecificOrderForStore(int $id): ?array
     {   
        return $this->createQueryBuilder('orderEntity')
            ->select('IDENTITY (orderEntity.captainId) as captainUserId')
            ->addSelect('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note',
             'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'orderEntity.isCaptainArrived', 'orderEntity.dateCaptainArrived')
            ->addSelect('storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName',
             'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')
            ->addSelect('orderChatRoomEntity.roomId')
            ->addSelect('imageEntity.imagePath')
            ->addSelect('captainEntity.captainName', 'captainEntity.phone')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            ->leftJoin(OrderChatRoomEntity::class, 'orderChatRoomEntity', Join::WITH, 'orderChatRoomEntity.orderId = orderEntity.id and orderChatRoomEntity.captain = orderEntity.captainId')
            ->leftJoin(ImageEntity::class, 'imageEntity', Join::WITH, 'imageEntity.id = storeOrderDetails.images')
            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.id = orderEntity.captainId')
            
            ->andWhere('orderEntity.id = :id')

            ->setParameter('id', $id)

            ->getQuery()
            
            ->getOneOrNullResult();
    }

    public function filterStoreOrders(OrderFilterRequest $request, $storeOwner): ?array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.deliveryDate',
                'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName',
                'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail', 'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')

            ->andWhere('orderEntity.storeOwner = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwner)

            ->leftJoin(
                StoreOrderDetailsEntity::class,
                'storeOrderDetails',
                Join::WITH,
                'orderEntity.id = storeOrderDetails.orderId')

            ->leftJoin(
                StoreOwnerBranchEntity::class,
                'storeOwnerBranch',
                Join::WITH,
                'storeOrderDetails.branch = storeOwnerBranch.id')

            ->orderBy('orderEntity.id', 'DESC');

        if ($request->getState() === OrderStateConstant::ORDER_STATE_ONGOING) {
            $query->andWhere('orderEntity.state IN (:statesArray)');
            $query->setParameter('statesArray', OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY);

        }

        if ($request->getState() != null && $request->getState() != "" && $request->getState() != OrderStateConstant::ORDER_STATE_ONGOING) {
            $query->andWhere('orderEntity.state = :state');
            $query->setParameter('state', $request->getState());
        }

        if (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === "")) {
            $query->andWhere('orderEntity.createdAt >= :createdAt');
            $query->setParameter('createdAt', $request->getFromDate());

        } elseif (($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('orderEntity.createdAt <= :createdAt');
            $query->setParameter('createdAt', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));

        } elseif (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('orderEntity.createdAt >= :fromDate');
            $query->setParameter('fromDate', $request->getFromDate());

            $query->andWhere('orderEntity.createdAt <= :toDate');
            $query->setParameter('toDate', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));
        }

        return $query->getQuery()->getResult();
    }

    public function closestOrders(int $captainId): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment',
            'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')
            ->addSelect('orderChatRoomEntity.roomId', 'orderChatRoomEntity.usedAs')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
           
            ->andWhere('orderEntity.state = :pending ')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            ->leftJoin(OrderChatRoomEntity::class, 'orderChatRoomEntity', Join::WITH, 'orderChatRoomEntity.orderId = orderEntity.id and orderChatRoomEntity.captain = :captainId')
            
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = orderEntity.storeOwner')

            ->setParameter('pending', OrderStateConstant::ORDER_STATE_PENDING)
            ->setParameter('captainId', $captainId)
            ->getQuery()
            ->getResult();
    }
    
    public function acceptedOrderByCaptainId($captainId, int $userId): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment',
            'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state')
            ->addSelect('rateEntity.rating')
           
            ->leftJoin(RateEntity::class, 'rateEntity', Join::WITH, 'rateEntity.orderId = orderEntity.id and rateEntity.rated = :userId')

            ->andWhere('orderEntity.state != :delivered')
            ->andWhere('orderEntity.captainId = :captainId')

            ->setParameter('delivered', OrderStateConstant::ORDER_STATE_DELIVERED)
            ->setParameter('captainId', $captainId)
            ->setParameter('userId', $userId)

            ->getQuery()
            ->getResult();
    }

    public function getSpecificOrderForCaptain(int $id, int $captainId, int $userId): ?array
     {   
        return $this->createQueryBuilder('orderEntity')

            ->addSelect('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note',
             'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer')
            ->addSelect('storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName',
             'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')
            ->addSelect('orderChatRoomEntity.roomId', 'orderChatRoomEntity.usedAs')
            ->addSelect('imageEntity.imagePath')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName', 'storeOwnerProfileEntity.phone')
            ->addSelect('rateEntity.rating')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            ->leftJoin(OrderChatRoomEntity::class, 'orderChatRoomEntity', Join::WITH, 'orderChatRoomEntity.orderId = orderEntity.id and orderChatRoomEntity.captain = :captainId')
            ->leftJoin(ImageEntity::class, 'imageEntity', Join::WITH, 'imageEntity.id = storeOrderDetails.images')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = orderEntity.storeOwner')
            ->leftJoin(RateEntity::class, 'rateEntity', Join::WITH, 'rateEntity.orderId = :id and rateEntity.rated = :userId')
            
            ->andWhere('orderEntity.id = :id')

            ->setParameter('id', $id)
            ->setParameter('captainId', $captainId)
            ->setParameter('userId', $userId)

            ->getQuery()
            
            ->getOneOrNullResult();
    }

    public function filterStoreOrdersByAdmin(OrderFilterByAdminRequest $request): ?array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.deliveryDate',
                'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName',
                'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail', 'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName',
                'imageEntity.id as imageId', 'imageEntity.imagePath as images')

            ->leftJoin(
                StoreOrderDetailsEntity::class,
                'storeOrderDetails',
                Join::WITH,
                'orderEntity.id = storeOrderDetails.orderId')

            ->leftJoin(
                StoreOwnerBranchEntity::class,
                'storeOwnerBranch',
                Join::WITH,
                'storeOrderDetails.branch = storeOwnerBranch.id')

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.id = storeOrderDetails.images')

            ->orderBy('orderEntity.id', 'DESC');

        if ($request->getStoreOwnerProfileId()) {
            $query->andWhere('orderEntity.storeOwner = :storeOwner');
            $query->setParameter('storeOwner', $request->getStoreOwnerProfileId());
        }

        if ($request->getState() != null && $request->getState() != "" && $request->getState() != OrderStateConstant::ORDER_STATE_ONGOING) {
            $query->andWhere('orderEntity.state = :state');
            $query->setParameter('state', $request->getState());
        }

        if ($request->getState() === OrderStateConstant::ORDER_STATE_ONGOING) {
            $query->andWhere('orderEntity.state IN (:statesArray)');
            $query->setParameter('statesArray', OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY);
        }

        if (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === "")) {
            $query->andWhere('orderEntity.createdAt >= :createdAt');
            $query->setParameter('createdAt', $request->getFromDate());

        } elseif (($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('orderEntity.createdAt <= :createdAt');
            $query->setParameter('createdAt', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));

        } elseif (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('orderEntity.createdAt >= :fromDate');
            $query->setParameter('fromDate', $request->getFromDate());

            $query->andWhere('orderEntity.createdAt <= :toDate');
            $query->setParameter('toDate', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));
        }

        return $query->getQuery()->getResult();
    }

    public function getSpecificOrderByIdForAdmin(int $id): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('IDENTITY (orderEntity.captainId) as captainUserId', 'orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note',
                'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination',
                'storeOrderDetails.recipientName', 'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail', 'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName',
                'imageEntity.imagePath as orderImage', 'captainEntity.captainName', 'captainEntity.phone')

            ->leftJoin(
                StoreOrderDetailsEntity::class,
                'storeOrderDetails',
                Join::WITH,
                'orderEntity.id = storeOrderDetails.orderId'
            )

            ->leftJoin(
                StoreOwnerBranchEntity::class,
                'storeOwnerBranch',
                Join::WITH,
                'storeOrderDetails.branch = storeOwnerBranch.id'
            )

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.id = storeOrderDetails.images'
            )

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = orderEntity.captainId'
            )

            ->andWhere('orderEntity.id = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function filterOrdersByCaptain(OrderFilterByCaptainRequest $request): ?array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment',
                'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state')

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $request->getCaptainId())

            ->orderBy('orderEntity.id', 'DESC');

        if ($request->getState() != null && $request->getState() != "" && $request->getState() != OrderStateConstant::ORDER_STATE_ONGOING) {
            $query->andWhere('orderEntity.state = :state');
            $query->setParameter('state', $request->getState());
        }

        if ($request->getState() === OrderStateConstant::ORDER_STATE_ONGOING) {
            $query->andWhere('orderEntity.state IN (:statesArray)');
            $query->setParameter('statesArray', OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY);
        }

        if (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === "")) {
            $query->andWhere('orderEntity.createdAt >= :createdAt');
            $query->setParameter('createdAt', $request->getFromDate());

        } elseif (($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('orderEntity.createdAt <= :createdAt');
            $query->setParameter('createdAt', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));

        } elseif (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('orderEntity.createdAt >= :fromDate');
            $query->setParameter('fromDate', $request->getFromDate());

            $query->andWhere('orderEntity.createdAt <= :toDate');
            $query->setParameter('toDate', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));
        }

        return $query->getQuery()->getResult();
    }
}
