<?php

namespace App\Repository;

use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Entity\AnnouncementEntity;
use App\Entity\AnnouncementOrderDetailsEntity;
use App\Entity\BidOrderEntity;
use App\Entity\OrderEntity;
use App\Entity\CaptainEntity;
use App\Entity\OrderLogsEntity;
use App\Entity\PriceOfferEntity;
use App\Entity\StoreOrderDetailsEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\ImageEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\OrderChatRoomEntity;
use App\Entity\SupplierCategoryEntity;
use App\Request\Admin\Order\CaptainNotArrivedOrderFilterByAdminRequest;
use App\Request\Admin\Order\OrderFilterByAdminRequest;
use App\Request\Order\BidOrderFilterBySupplierRequest;
use App\Request\Order\AnnouncementOrderFilterBySupplierRequest;
use App\Request\Order\OrderFilterByCaptainRequest;
use App\Request\Order\OrderFilterRequest;
use DateTime;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Entity\RateEntity;
use App\Entity\SupplierProfileEntity;

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
            ->addSelect('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.noteCaptainOrderCost',
             'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'orderEntity.isCaptainArrived', 'orderEntity.dateCaptainArrived', 'orderEntity.captainOrderCost')
            ->addSelect('storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName',
             'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName', 'storeOwnerBranch.branchPhone')
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
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName', 'storeOwnerBranch.branchPhone')
            ->addSelect('orderChatRoomEntity.roomId', 'orderChatRoomEntity.usedAs')
            ->addSelect('imageEntity.imagePath')
            ->addSelect('storeOwnerProfileEntity.id as storeId','storeOwnerProfileEntity.storeOwnerName', 'storeOwnerProfileEntity.phone')
            ->addSelect('rateEntity.rating', 'rateEntity.comment as ratingComment')

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

    // This function filters only orders in which the captain does not arrive the store yet
    public function filterCaptainNotArrivedOrdersByAdmin(CaptainNotArrivedOrderFilterByAdminRequest $request): ?array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.createdAt', 'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.name as branchName', 'captainEntity.captainName',
                'storeOwnerProfileEntity.storeOwnerName')

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
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = orderEntity.captainId'
            )

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = orderEntity.storeOwner'
            )

            ->leftJoin(
                OrderLogsEntity::class,
                'orderLogEntity',
                Join::WITH,
                'orderLogEntity.orderId = orderEntity.id'
            )
            ->andWhere('orderLogEntity.isCaptainArrived = :captainArrived')
            ->setParameter('captainArrived', 0)

            ->orderBy('orderEntity.id', 'DESC');

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
    
    public function getCountOrdersByCaptainId(int $captainId): array
    {
        return $this->createQueryBuilder('orderEntity')

            ->select('count(orderEntity.id) as countOrders')

            ->where('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->getQuery()
            ->getOneOrNullResult();
    }
    
    public function getDetailOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->createQueryBuilder('orderEntity')

        ->select('orderEntity.id, orderEntity.kilometer', 'orderEntity.payment', 'orderEntity.captainOrderCost')

        ->where('orderEntity.state = :state')
        ->setParameter('state', OrderStateConstant::ORDER_STATE_DELIVERED)
      
        ->andWhere('orderEntity.captainId = :captainId')
        ->setParameter('captainId', $captainId)

        ->andWhere('orderEntity.createdAt >= :fromDate')
        ->setParameter('fromDate', $fromDate)

        ->andWhere('orderEntity.createdAt <= :toDate')
        ->setParameter('toDate', $toDate)
        
        ->getQuery()
        ->getResult();
    }
    
    public function getCountOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate,string $toDate): array
    {
        return $this->createQueryBuilder('orderEntity')

        ->select('count(orderEntity.id) as countOrder')

        ->where('orderEntity.state = :state')
        ->setParameter('state', OrderStateConstant::ORDER_STATE_DELIVERED)
      
        ->andWhere('orderEntity.captainId = :captainId')
        ->setParameter('captainId', $captainId)

        ->andWhere('orderEntity.createdAt >= :fromDate')
        ->setParameter('fromDate', $fromDate)

        ->andWhere('orderEntity.createdAt <= :toDate')
        ->setParameter('toDate', $toDate)

        ->getQuery()
        ->getOneOrNullResult();
    }
    
    public function filterAnnouncementOrdersBySupplier(AnnouncementOrderFilterBySupplierRequest $request): ?array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.createdAt')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
            ->addSelect('announcementOrderDetailsEntity.id as announcementOrderDetailsId')
            ->addSelect('announcementEntity.id as announcementId')

            ->andWhere('orderEntity.orderType = :orderType')
            ->setParameter('orderType', OrderTypeConstant::ORDER_TYPE_BID)

            ->leftJoin(
                AnnouncementOrderDetailsEntity::class,
                'announcementOrderDetailsEntity',
                Join::WITH,
                'announcementOrderDetailsEntity.orderId = orderEntity.id'
            )

            ->leftJoin(
                AnnouncementEntity::class,
                'announcementEntity',
                Join::WITH,
                'announcementEntity.id = announcementOrderDetailsEntity.announcement'
            )

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.id = announcementEntity.supplier'
            )

            ->andWhere('supplierProfileEntity.user = :supplierId')
            ->setParameter('supplierId', $request->getSupplierId())

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = orderEntity.storeOwner'
            )

            ->leftJoin(
                OrderLogsEntity::class,
                'orderLogEntity',
                Join::WITH,
                'orderLogEntity.orderId = orderEntity.id'
            )

            ->orderBy('orderEntity.id', 'DESC');

        if ($request->getPriceOfferStatus() !== null) {
            $query->andWhere('announcementOrderDetailsEntity.priceOfferStatus = :priceOfferStatus');
            $query->setParameter('priceOfferStatus', $request->getPriceOfferStatus());
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
    
    public function getCountOrdersByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): array
    {
        return $this->createQueryBuilder('orderEntity')

        ->select('count(orderEntity.id) as countOrder')

        ->where('orderEntity.state = :state')
        ->setParameter('state', OrderStateConstant::ORDER_STATE_DELIVERED)
      
        ->andWhere('orderEntity.captainId = :captainId')
        ->setParameter('captainId', $captainId)

        ->andWhere('orderEntity.createdAt >= :fromDate')
        ->setParameter('fromDate', $fromDate)

        ->andWhere('orderEntity.createdAt <= :toDate')
        ->setParameter('toDate', $toDate)

        ->andWhere('orderEntity.kilometer >= :countKilometersFrom')
        ->setParameter('countKilometersFrom', $countKilometersFrom)

        ->andWhere('orderEntity.kilometer <= :countKilometersTo')
        ->setParameter('countKilometersTo', $countKilometersTo)

        ->getQuery()
        ->getOneOrNullResult();
    }
    
    public function getSpecificAnnouncementOrderByIdForSupplier(int $id): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note',
                'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName', 'storeOwnerProfileEntity.phone')
            ->addSelect('announcementOrderDetailsEntity.id as announcementOrderDetailsId', 'announcementOrderDetailsEntity.priceOfferValue', 'announcementOrderDetailsEntity.priceOfferStatus')
            ->addSelect('announcementEntity.id as announcementId')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = orderEntity.storeOwner'
            )

            ->leftJoin(
                StoreOrderDetailsEntity::class,
                'storeOrderDetails',
                Join::WITH,
                'orderEntity.id = storeOrderDetails.orderId'
            )

            ->leftJoin(
                AnnouncementOrderDetailsEntity::class,
                'announcementOrderDetailsEntity',
                Join::WITH,
                'announcementOrderDetailsEntity.orderId = orderEntity.id'
            )

            ->leftJoin(
                AnnouncementEntity::class,
                'announcementEntity',
                Join::WITH,
                'announcementEntity.id = announcementOrderDetailsEntity.announcement'
            )

            ->andWhere('orderEntity.id = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    // This function filter bid orders which the supplier had not provide a price offer for any one of them yet.
    public function filterBidOrdersBySupplier(BidOrderFilterBySupplierRequest $request): array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id')
            ->addSelect('bidOrderEntity.id as bidOrderId', 'bidOrderEntity.title', 'bidOrderEntity.description', 'bidOrderEntity.createdAt', 'bidOrderEntity.updatedAt')

            ->andWhere('bidOrderEntity.openToPriceOffer = :openToPriceOfferStatus')
            ->setParameter('openToPriceOfferStatus', 1)

            ->leftJoin(
                BidOrderEntity::class,
                'bidOrderEntity',
                Join::WITH,
                'bidOrderEntity.orderId = orderEntity.id'
            )

            ->leftJoin(
                SupplierCategoryEntity::class,
                'supplierCategoryEntity',
                Join::WITH,
                'supplierCategoryEntity.id = bidOrderEntity.supplierCategory'
            )

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierCategoryEntity.id IN (:supCategory)'
            )

            ->setParameter('supCategory', $this->getSupplierCategoriesBySupplierId($request->getSupplierId()))

            ->andWhere('supplierProfileEntity.user = :supplierId')
            ->setParameter('supplierId', $request->getSupplierId())

            ->orderBy('orderEntity.id', 'DESC');

        //---- Check if bid order is among the orders which the supplier had made a previous offer for it
        $bidOrderIds = $this->getBidOrderIdsBySupplierIdAndThatHavePriceOffers($request->getSupplierId());
        if (! empty($bidOrderIds)) {
            $query->andWhere('bidOrderEntity.id NOT IN (:bidOrderIds)');
            $query->setParameter('bidOrderIds', $bidOrderIds);
        }
        //---- End checking block

        if (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === "")) {
            $query->andWhere('bidOrderEntity.createdAt >= :createdAt');
            $query->setParameter('createdAt', $request->getFromDate());

        } elseif (($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('bidOrderEntity.createdAt <= :createdAt');
            $query->setParameter('createdAt', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));

        } elseif (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('bidOrderEntity.createdAt >= :fromDate');
            $query->setParameter('fromDate', $request->getFromDate());

            $query->andWhere('bidOrderEntity.createdAt <= :toDate');
            $query->setParameter('toDate', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));
        }

        return $query->getQuery()->getResult();
    }

    public function getSupplierCategoriesBySupplierId(int $supplierId): array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('DISTINCT(supplierProfileEntity.supplierCategories)')

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.user = :userId'
            )

            ->setParameter('userId', $supplierId)

            ->getQuery()
            ->getSingleColumnResult();

        if (empty($query)) {
            return $query;
        }

        return json_decode($query[0]);
    }

    // This function returns array of bid orders Ids that the supplier had made a price offer for them
    public function getBidOrderIdsBySupplierIdAndThatHavePriceOffers(int $supplierId): array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('DISTINCT(bidOrderEntity.id)')

            ->leftJoin(
                BidOrderEntity::class,
                'bidOrderEntity',
                Join::WITH,
                'bidOrderEntity.orderId = orderEntity.id'
            )

            ->andWhere('bidOrderEntity.openToPriceOffer = :openToPriceOfferStatus')
            ->setParameter('openToPriceOfferStatus', 1)

            ->leftJoin(
                PriceOfferEntity::class,
                'priceOfferEntity',
                Join::WITH,
                'priceOfferEntity.bidOrder = bidOrderEntity.id'
            )

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.id = priceOfferEntity.supplierProfile'
            )

            ->andWhere('supplierProfileEntity.user = :supplierId')
            ->setParameter('supplierId', $supplierId)

            ->orderBy('bidOrderEntity.id', 'DESC')

            ->getQuery()
            ->getSingleColumnResult();
    }
}
