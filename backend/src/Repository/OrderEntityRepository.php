<?php

namespace App\Repository;

use App\Constant\ChatRoom\ChatRoomConstant;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Entity\BidDetailsEntity;
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
use App\Request\Order\OrderFilterByCaptainRequest;
use App\Request\Order\OrderFilterRequest;
use DateTime;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Entity\RateEntity;
use App\Entity\SupplierProfileEntity;
use App\Constant\Order\OrderIsHideConstant;
use App\Constant\Order\OrderIsMainConstant;

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
             'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'orderEntity.isHide', 'orderEntity.orderIsMain')
            ->addSelect('storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName',
             'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            
            ->andWhere('orderEntity.storeOwner = :storeOwner')

            ->setParameter('storeOwner', $storeOwner)
            
            ->andWhere('orderEntity.isHide != :isHide')
            ->setParameter('isHide', OrderIsHideConstant::ORDER_HIDE)

            ->andWhere('orderEntity.isHide != :hide')
            ->setParameter('hide', OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE)

           
            ->orderBy('orderEntity.id', 'DESC')
       
            ->getQuery()

            ->getResult();
    }

    public function getSpecificOrderForStore(int $id): ?array
     {   
        return $this->createQueryBuilder('orderEntity')
            ->select('IDENTITY (orderEntity.captainId) as captainUserId')
            ->addSelect('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.noteCaptainOrderCost',
             'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'orderEntity.isCaptainArrived', 'orderEntity.dateCaptainArrived', 'orderEntity.captainOrderCost', 'orderEntity.paidToProvider', 'orderEntity.isHide', 'orderEntity.orderIsMain')
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
                'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'orderEntity.isHide', 'orderEntity.orderIsMain', 'storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName',
                'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail', 'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')

            ->andWhere('orderEntity.storeOwner = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwner)

            ->andWhere('orderEntity.orderType = :bidOrderType')
            ->setParameter('bidOrderType', OrderTypeConstant::ORDER_TYPE_NORMAL)
              
            ->andWhere('orderEntity.isHide != :isHide')
            ->setParameter('isHide', OrderIsHideConstant::ORDER_HIDE)

            ->andWhere('orderEntity.isHide != :hide')
            ->setParameter('hide', OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE)

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

        if ($request->getState() !== null && $request->getState() !== "" && $request->getState() !== OrderStateConstant::ORDER_STATE_ONGOING) {
            $query->andWhere('orderEntity.state = :orderState');
            $query->setParameter('orderState', $request->getState());

        } elseif ($request->getState() === OrderStateConstant::ORDER_STATE_ONGOING) {
            $response = [];

            $orders = $query->getQuery()->getResult();

            if ($orders) {
                foreach ($orders as $order) {
                    if (in_array($order['state'], OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY)) {
                        $response[] = $order;

                    } elseif ($order['state'] === OrderStateConstant::ORDER_STATE_DELIVERED) {
                        if (! empty($this->checkIfMainOrderHasUnDeliveredSubOrders($order['id']))) {
                            $response[] = $order;
                        }
                    }
                }
            }

            return $response;
        }

        return $query->getQuery()->getResult();
    }

    public function checkIfMainOrderHasUnDeliveredSubOrders(int $orderId): array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id')

            ->andWhere('orderEntity.id = :orderId')
            ->setParameter('orderId', $orderId)

            ->leftJoin(
                OrderEntity::class,
                'orderEntityTwo',
                 Join::WITH,
                'orderEntityTwo.primaryOrder = orderEntity.id'
            )

            ->andWhere('orderEntityTwo.state IN (:statesArray)')
            ->setParameter('statesArray', OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY)

            ->getQuery()
            ->getResult();
    }

    public function filterStoreBidOrders(OrderFilterRequest $request, $storeOwner): ?array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.deliveryDate',
                'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer')
            ->addSelect('bidDetailsEntity as bidDetails')

            ->andWhere('orderEntity.storeOwner = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwner)

            ->andWhere('orderEntity.orderType = :bidOrderType')
            ->setParameter('bidOrderType', OrderTypeConstant::ORDER_TYPE_BID)

            ->leftJoin(
                BidDetailsEntity::class,
                'bidDetailsEntity',
                Join::WITH,
                'bidDetailsEntity.orderId = orderEntity.id'
            )

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

        if ($request->getOpenToPriceOffer() !== null) {
            $query->andWhere('bidDetailsEntity.openToPriceOffer = :openToPriceOfferValue');
            $query->setParameter('openToPriceOfferValue', $request->getOpenToPriceOffer());
        }

        return $query->getQuery()->getResult();
    }

    public function closestOrders(int $captainId): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment',
            'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state', 'orderEntity.orderIsMain')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')
            ->addSelect('orderChatRoomEntity.roomId', 'orderChatRoomEntity.usedAs')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
            ->addSelect('bidDetailsEntity as bidDetailsInfo')
           
            ->andWhere('orderEntity.state = :pending ')
//            ->andWhere('orderEntity.orderType = :orderTypeNormal')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            ->leftJoin(OrderChatRoomEntity::class, 'orderChatRoomEntity', Join::WITH, 'orderChatRoomEntity.orderId = orderEntity.id and orderChatRoomEntity.captain = :captainId')
            
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = orderEntity.storeOwner')

            ->leftJoin(BidDetailsEntity::class, 'bidDetailsEntity', Join::WITH, 'bidDetailsEntity.orderId = orderEntity.id')

            ->setParameter('pending', OrderStateConstant::ORDER_STATE_PENDING)
            ->setParameter('captainId', $captainId)
//            ->setParameter('orderTypeNormal', OrderTypeConstant::ORDER_TYPE_NORMAL)

            ->andWhere('orderEntity.isHide = :isHide')
            ->setParameter('isHide', OrderIsHideConstant::ORDER_SHOW)

            ->orderBy('orderEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    // Currently we do not need this function
//    public function closestBidOrders(int $captainId): ?array
//    {
//        return $this->createQueryBuilder('orderEntity')
//            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state')
//            ->addSelect('bidDetailsEntity as bidDetails')
//            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
//
//            ->andWhere('orderEntity.state = :pending')
//            ->setParameter('pending', OrderStateConstant::ORDER_STATE_PENDING)
//
//            ->andWhere('orderEntity.orderType = :bidOrderType')
//            ->setParameter('bidOrderType', OrderTypeConstant::ORDER_TYPE_BID)
//
//            ->leftJoin(
//                BidDetailsEntity::class,
//                'bidDetailsEntity',
//                Join::WITH,
//                'bidDetailsEntity.orderId = orderEntity.id'
//            )
//
//            ->leftJoin(
//                StoreOwnerProfileEntity::class,
//                'storeOwnerProfileEntity',
//                Join::WITH,
//                'storeOwnerProfileEntity.id = orderEntity.storeOwner'
//            )
//
//            ->orderBy('orderEntity.id', 'DESC')
//
//            ->getQuery()
//            ->getResult();
//    }
    
    public function acceptedOrderByCaptainId($captainId, int $userId): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment',
            'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state', 'orderEntity.orderIsMain')
            ->addSelect('rateEntity.rating')
            ->addSelect('bidDetailsEntity as bidDetails')
           
            ->leftJoin(RateEntity::class, 'rateEntity', Join::WITH, 'rateEntity.orderId = orderEntity.id and rateEntity.rated = :userId')

            ->leftJoin(BidDetailsEntity::class, 'bidDetailsEntity', Join::WITH, 'bidDetailsEntity.orderId = orderEntity.id')

            ->andWhere('orderEntity.state != :delivered')
            ->andWhere('orderEntity.captainId = :captainId')

            ->setParameter('delivered', OrderStateConstant::ORDER_STATE_DELIVERED)
            ->setParameter('captainId', $captainId)
            ->setParameter('userId', $userId)
           
            ->andWhere('orderEntity.isHide = :isHide')
            ->setParameter('isHide', OrderIsHideConstant::ORDER_SHOW)
           
            ->getQuery()
            ->getResult();
    }

    public function getSpecificOrderForCaptain(int $id, int $captainId, int $userId): ?array
     {   
        return $this->createQueryBuilder('orderEntity')

            ->addSelect('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note',
             'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'orderEntity.paidToProvider', 'orderEntity.orderIsMain')
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

    public function getSpecificBidOrderForCaptain(int $id, int $captainId, int $userId): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt',
                'orderEntity.kilometer', 'orderEntity.paidToProvider')
            ->addSelect('bidDetailsEntity as bidDetails')
            ->addSelect('storeOwnerProfileEntity.id as storeId','storeOwnerProfileEntity.storeOwnerName', 'storeOwnerProfileEntity.phone')
            ->addSelect('orderChatRoomEntity.roomId', 'orderChatRoomEntity.usedAs')
            ->addSelect('rateEntity.rating', 'rateEntity.comment as ratingComment')

            ->leftJoin(
                BidDetailsEntity::class,
                'bidDetailsEntity',
                Join::WITH,
                'bidDetailsEntity.orderId = orderEntity.id'
            )

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = orderEntity.storeOwner'
            )

            ->leftJoin(
                OrderChatRoomEntity::class,
                'orderChatRoomEntity',
                Join::WITH,
                'orderChatRoomEntity.orderId = orderEntity.id and orderChatRoomEntity.captain = :captainId'
            )
            ->setParameter('captainId', $captainId)

            ->leftJoin(
                RateEntity::class,
                'rateEntity',
                Join::WITH,
                'rateEntity.orderId = :id and rateEntity.rated = :userId'
            )
            ->setParameter('userId', $userId)

            ->andWhere('orderEntity.id = :id')
            ->setParameter('id', $id)

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
                'imageEntity.imagePath as orderImage', 'captainEntity.captainName', 'captainEntity.phone', 'orderEntity.paidToProvider', 'orderEntity.noteCaptainOrderCost', 'orderEntity.captainOrderCost')

            ->addSelect('storeOwnerProfileEntity.id as storeOwnerId')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')

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

            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = orderEntity.storeOwner')

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
            ->addSelect('bidDetailsEntity as bidDetails')

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $request->getCaptainId())
         
            ->andWhere('orderEntity.isHide = :isHide')
            ->setParameter('isHide', OrderIsHideConstant::ORDER_SHOW)
         
            ->leftJoin(
                BidDetailsEntity::class,
                'bidDetailsEntity',
                Join::WITH,
                'bidDetailsEntity.orderId = orderEntity.id'
            )

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

        if ($request->getState() != null && $request->getState() != "" && $request->getState() != OrderStateConstant::ORDER_STATE_ONGOING) {
            $query->andWhere('orderEntity.state = :state');
            $query->setParameter('state', $request->getState());

        } elseif ($request->getState() === OrderStateConstant::ORDER_STATE_ONGOING) {
            $response = [];

            $orders = $query->getQuery()->getResult();

            if ($orders) {
                foreach ($orders as $order) {
                    if (in_array($order['state'], OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY)) {
                        $response[] = $order;

                    } elseif ($order['state'] === OrderStateConstant::ORDER_STATE_DELIVERED) {
                        if (! empty($this->checkIfMainOrderHasUnDeliveredSubOrders($order['id']))) {
                            $response[] = $order;
                        }
                    }
                }
            }

            return $response;
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

        $query->groupBy('orderEntity.id');

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

        ->select('orderEntity.id, orderEntity.kilometer', 'orderEntity.payment', 'orderEntity.captainOrderCost', 'orderEntity.paidToProvider')

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

    // This function filter bid orders which the supplier had not provide a price offer for any one of them yet.
    public function filterBidOrdersBySupplier(BidOrderFilterBySupplierRequest $request): array|string
    {
        $supplierProfileStatus = $this->getSupplierProfileStatusBySupplierId($request->getSupplierId());

        if ($supplierProfileStatus === SupplierProfileConstant::INACTIVE_SUPPLIER_PROFILE_STRING_STATUS) {
            return $supplierProfileStatus;
        }

        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.createdAt', 'orderEntity.state', 'orderEntity.updatedAt')
            ->addSelect('bidDetailsEntity as bidDetails')

            ->andWhere('bidDetailsEntity.openToPriceOffer = :openToPriceOfferStatus')
            ->setParameter('openToPriceOfferStatus', 1)

            ->andWhere('orderEntity.state != :cancelledState')
            ->setParameter('cancelledState', OrderStateConstant::ORDER_STATE_CANCEL)

            ->leftJoin(
                BidDetailsEntity::class,
                'bidDetailsEntity',
                Join::WITH,
                'bidDetailsEntity.orderId = orderEntity.id'
            )

            ->leftJoin(
                SupplierCategoryEntity::class,
                'supplierCategoryEntity',
                Join::WITH,
                'supplierCategoryEntity.id = bidDetailsEntity.supplierCategory'
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
            $query->andWhere('bidDetailsEntity.id NOT IN (:bidOrderIds)');
            $query->setParameter('bidOrderIds', $bidOrderIds);
        }
        //---- End checking block

        if (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === "")) {
            $query->andWhere('bidDetailsEntity.createdAt >= :createdAt');
            $query->setParameter('createdAt', $request->getFromDate());

        } elseif (($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('bidDetailsEntity.createdAt <= :createdAt');
            $query->setParameter('createdAt', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));

        } elseif (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('bidDetailsEntity.createdAt >= :fromDate');
            $query->setParameter('fromDate', $request->getFromDate());

            $query->andWhere('bidDetailsEntity.createdAt <= :toDate');
            $query->setParameter('toDate', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));
        }

        return $query->getQuery()->getResult();
    }

    public function getSupplierProfileStatusBySupplierId(int $supplierId): string
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('DISTINCT(supplierProfileEntity.status) as status')

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.user = :supplierId'
            )

            ->setParameter('supplierId', $supplierId)

            ->getQuery()
            ->getSingleScalarResult();
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
            ->select('DISTINCT(bidDetailsEntity.id)')

            ->leftJoin(
                BidDetailsEntity::class,
                'bidDetailsEntity',
                Join::WITH,
                'bidDetailsEntity.orderId = orderEntity.id'
            )

            ->andWhere('bidDetailsEntity.openToPriceOffer = :openToPriceOfferStatus')
            ->setParameter('openToPriceOfferStatus', 1)

            ->leftJoin(
                PriceOfferEntity::class,
                'priceOfferEntity',
                Join::WITH,
                'priceOfferEntity.bidDetails = bidDetailsEntity.id'
            )

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.id = priceOfferEntity.supplierProfile'
            )

            ->andWhere('supplierProfileEntity.user = :supplierId')
            ->setParameter('supplierId', $supplierId)

            ->orderBy('bidDetailsEntity.id', 'DESC')

            ->getQuery()
            ->getSingleColumnResult();
    }

    public function getOrderByIdForSupplier(int $orderId): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.orderType', 'orderEntity.noteCaptainOrderCost', 'orderEntity.note', 'orderEntity.state', 'orderEntity.createdAt', 'orderEntity.captainOrderCost',
                'orderEntity.updatedAt', 'orderEntity.dateCaptainArrived', 'orderEntity.deliveryDate', 'orderEntity.isCaptainArrived', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.kilometer')
            ->addSelect('bidDetailsEntity as bidDetails')
            ->addSelect('orderChatRoomEntity.roomId', 'orderChatRoomEntity.usedAs')

            ->leftJoin(
                BidDetailsEntity::class,
                'bidDetailsEntity',
                Join::WITH,
                'bidDetailsEntity.orderId = orderEntity.id'
            )

            ->leftJoin(
                OrderChatRoomEntity::class,
                'orderChatRoomEntity',
                Join::WITH,
                'orderChatRoomEntity.orderId = orderEntity.id AND orderChatRoomEntity.usedAs = :chatRoomUsedAs'
            )

            ->setParameter('chatRoomUsedAs', ChatRoomConstant::CAPTAIN_SUPPLIER)

            ->andWhere('orderEntity.id = :orderId')
            ->setParameter('orderId', $orderId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    // This function filter bid orders which have price offers made by the supplier (who request the filter).
    public function filterBidOrdersThatHavePriceOffersBySupplier(BidOrderFilterBySupplierRequest $request): array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('DISTINCT(orderEntity.id) as id', 'orderEntity.createdAt', 'orderEntity.state', 'orderEntity.updatedAt')
            ->addSelect('bidDetailsEntity.id as bidDetailsId', 'bidDetailsEntity.title', 'bidDetailsEntity.openToPriceOffer')

            ->andWhere('orderEntity.state != :cancelledState')
            ->setParameter('cancelledState', OrderStateConstant::ORDER_STATE_CANCEL)

            ->leftJoin(
                BidDetailsEntity::class,
                'bidDetailsEntity',
                Join::WITH,
                'bidDetailsEntity.orderId = orderEntity.id'
            )

            ->leftJoin(
                PriceOfferEntity::class,
                'priceOfferEntity',
                Join::WITH,
                'priceOfferEntity.bidDetails = bidDetailsEntity.id'
            )

            ->leftJoin(
                SupplierProfileEntity::class,
                'supplierProfileEntity',
                Join::WITH,
                'supplierProfileEntity.id = priceOfferEntity.supplierProfile'
            )

            ->andWhere('supplierProfileEntity.user = :supplierId')
            ->setParameter('supplierId', $request->getSupplierId())

            ->orderBy('bidDetailsEntity.id', 'DESC');

        if ($request->getOpenToPriceOffer() !== null) {
            $query->andWhere('bidDetailsEntity.openToPriceOffer = :openToPriceOffer');
            $query->setParameter('openToPriceOffer', $request->getOpenToPriceOffer());
        }

        if (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === "")) {
            $query->andWhere('bidDetailsEntity.createdAt >= :createdAt');
            $query->setParameter('createdAt', $request->getFromDate());

        } elseif (($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('bidDetailsEntity.createdAt <= :createdAt');
            $query->setParameter('createdAt', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));

        } elseif (($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $query->andWhere('bidDetailsEntity.createdAt >= :fromDate');
            $query->setParameter('fromDate', $request->getFromDate());

            $query->andWhere('bidDetailsEntity.createdAt <= :toDate');
            $query->setParameter('toDate', (new DateTime($request->getToDate()))->modify('+1 day')->format('Y-m-d'));
        }

        return $query->getQuery()->getResult();
    }

    public function getLastPriceOfferByBidDetailsId(int $bidDetailsId): array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('priceOfferEntity.id', 'priceOfferEntity.priceOfferStatus')

            ->leftJoin(
                BidDetailsEntity::class,
                'bidDetailsEntity',
                Join::WITH,
                'bidDetailsEntity.orderId = orderEntity.id'
            )

            ->andWhere('bidDetailsEntity.id = :bidDetailsId')
            ->setParameter('bidDetailsId', $bidDetailsId)

            ->leftJoin(
                PriceOfferEntity::class,
                'priceOfferEntity',
                Join::WITH,
                'priceOfferEntity.bidDetails = bidDetailsEntity.id'
            )

            ->orderBy('priceOfferEntity.id', 'DESC')
            ->setMaxResults(1)

            ->getQuery()
            ->getSingleResult();
    }

    public function getSpecificBidOrderForStore(int $id): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('IDENTITY (orderEntity.captainId) as captainUserId')
            ->addSelect('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.noteCaptainOrderCost',
                'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'orderEntity.isCaptainArrived', 'orderEntity.dateCaptainArrived', 'orderEntity.captainOrderCost')
            ->addSelect('storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName', 'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail')
//            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName', 'storeOwnerBranch.branchPhone')
            ->addSelect('orderChatRoomEntity.roomId')
            ->addSelect('captainEntity.captainName', 'captainEntity.phone')
            ->addSelect('bidDetailsEntity as bidDetails')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
//            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            ->leftJoin(OrderChatRoomEntity::class, 'orderChatRoomEntity', Join::WITH, 'orderChatRoomEntity.orderId = orderEntity.id and orderChatRoomEntity.captain = orderEntity.captainId')
            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.id = orderEntity.captainId')
            ->leftJoin(BidDetailsEntity::class, 'bidDetailsEntity', Join::WITH, 'bidDetailsEntity.orderId = orderEntity.id')

            ->andWhere('orderEntity.id = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function filterStoreBidOrdersByAdmin(OrderFilterByAdminRequest $request): ?array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.state', 'orderEntity.orderType', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt',
                'bidDetailsEntity as bidOrderDetails')

            ->leftJoin(
                BidDetailsEntity::class,
                'bidDetailsEntity',
                Join::WITH,
                'bidDetailsEntity.orderId = orderEntity.id'
            )

            ->andWhere('orderEntity.orderType = :orderType')
            ->setParameter('orderType', OrderTypeConstant::ORDER_TYPE_BID)

            ->orderBy('orderEntity.id', 'DESC');

        if ($request->getStoreOwnerProfileId()) {
            $query->andWhere('orderEntity.storeOwner = :storeOwner');
            $query->setParameter('storeOwner', $request->getStoreOwnerProfileId());
        }

        if ($request->getOpenToPriceOffer() !== null) {
            $query->andWhere('bidDetailsEntity.openToPriceOffer = :openToPriceOffer');
            $query->setParameter('openToPriceOffer', $request->getOpenToPriceOffer());
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

    public function getSpecificBidOrderByIdForAdmin(int $id): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.noteCaptainOrderCost', 'orderEntity.captainOrderCost',
                'orderEntity.dateCaptainArrived', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'bidDetailsEntity as bidOrderDetails', 'IDENTITY(orderEntity.captainId) as captainUserId',
                'captainEntity.captainName', 'captainEntity.phone')

            ->leftJoin(
                BidDetailsEntity::class,
                'bidDetailsEntity',
                Join::WITH,
                'bidDetailsEntity.orderId = orderEntity.id'
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

    public function getOrdersPendingBeforeSpecificDate(DateTime $specificTime): ?array
    {
        return $this->createQueryBuilder('orderEntity')

            ->andWhere('orderEntity.deliveryDate < :specificTime')
            ->setParameter('specificTime', $specificTime)

            ->andWhere('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_PENDING)

            ->getQuery()
            ->getResult();
    }

    public function getOrdersPending(): ?array
    {
        return $this->createQueryBuilder('orderEntity')

            ->andWhere('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_PENDING)

            ->andWhere('orderEntity.orderType = :normalOrderType')
            ->setParameter('normalOrderType', OrderTypeConstant::ORDER_TYPE_NORMAL)

            ->andWhere('orderEntity.isHide != :hide')
            ->setParameter('hide', OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE)

            ->getQuery()
            ->getResult();
    }

    public function getSubOrdersByPrimaryOrderId(int $primaryOrderId): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment',
            'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
           
            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = orderEntity.storeOwner')

            ->andWhere('orderEntity.isHide = :isHide')
            ->setParameter('isHide', OrderIsHideConstant::ORDER_HIDE)

            ->andWhere('orderEntity.primaryOrder = :primaryOrderId')
            ->setParameter('primaryOrderId', $primaryOrderId)

            ->orderBy('orderEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function getSubOrdersByPrimaryOrderIdForStore(int $primaryOrderId): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment',
            'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
           
            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = orderEntity.storeOwner')

            ->andWhere('orderEntity.primaryOrder = :primaryOrderId')
            ->setParameter('primaryOrderId', $primaryOrderId)

            ->orderBy('orderEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }
    
    public function getordersHiddenDueToExceedingDeliveryTime(int $userId): ?array
     {   
        return $this->createQueryBuilder('orderEntity')

            ->addSelect('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note',
             'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'orderEntity.isHide', 'orderEntity.orderIsMain')
            ->addSelect('storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName',
             'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfile', Join::WITH, 'storeOwnerProfile.storeOwnerId = :userId')
            
            ->andWhere('orderEntity.storeOwner = storeOwnerProfile.id')
            
            ->andWhere('storeOwnerProfile.storeOwnerId = :userId')
            ->setParameter('userId', $userId)
            
            ->andWhere('orderEntity.isHide = :isHide')
            ->setParameter('isHide', OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE)
   
            ->andWhere('orderEntity.orderType = :orderTypeNormal')
            ->setParameter('orderTypeNormal', OrderTypeConstant::ORDER_TYPE_NORMAL)
   
//            ->andWhere('orderEntity.orderIsMain = :orderIsMain')
//            ->setParameter('orderIsMain', OrderIsMainConstant::ORDER_MAIN)
   
            ->andWhere('orderEntity.state != :cancelledState')
            ->setParameter('cancelledState', OrderStateConstant::ORDER_STATE_CANCEL)

            ->orderBy('orderEntity.id', 'DESC')
       
            ->getQuery()

            ->getResult();
    }

    public function acceptedOrderNewByCaptainId($captainId, int $userId): ?array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment',
            'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state', 'orderEntity.orderIsMain')
            ->addSelect('rateEntity.rating')
            ->addSelect('bidDetailsEntity as bidDetails')
           
            ->leftJoin(RateEntity::class, 'rateEntity', Join::WITH, 'rateEntity.orderId = orderEntity.id and rateEntity.rated = :userId')

            ->leftJoin(BidDetailsEntity::class, 'bidDetailsEntity', Join::WITH, 'bidDetailsEntity.orderId = orderEntity.id')
            
            ->andWhere('orderEntity.captainId = :captainId')

            ->setParameter('captainId', $captainId)
            ->setParameter('userId', $userId)
           
            ->andWhere('orderEntity.isHide = :isHide')
            ->setParameter('isHide', OrderIsHideConstant::ORDER_SHOW);

        $orders = $query->addSelect('orderEntity.state as state')->getQuery()->getResult();

        if ($orders) {
            $response = [];

            foreach($orders as $order) {
                if (in_array($order['state'], OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY)) {
                    $response[] = $order;

                } elseif ($order['state'] === OrderStateConstant::ORDER_STATE_DELIVERED) {
                    if (! empty($this->checkIfMainOrderHasUnDeliveredSubOrders($order['id']))) {
                        $response[] = $order;
                    }
                }
            }

            return $response;
        }

        return $orders;
    }

    public function getPendingOrdersForAdmin(): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment',
            'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state', 'orderEntity.orderIsMain', 'orderEntity.isHide')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
            ->addSelect('bidDetailsEntity as bidDetailsInfo')
           
            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')            
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = orderEntity.storeOwner')

            ->leftJoin(BidDetailsEntity::class, 'bidDetailsEntity', Join::WITH, 'bidDetailsEntity.orderId = orderEntity.id')
           
            ->andWhere('orderEntity.state = :pending ')
            ->setParameter('pending', OrderStateConstant::ORDER_STATE_PENDING)

            ->andWhere('orderEntity.isHide = :show')
            ->setParameter('show', OrderIsHideConstant::ORDER_SHOW)
//            ->setParameter('hide', OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE)

            ->getQuery()
            ->getResult();
    }

    public function getHiddenOrdersForAdmin(): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment',
                'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state', 'orderEntity.orderIsMain', 'orderEntity.isHide')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
            ->addSelect('bidDetailsEntity as bidDetailsInfo')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = orderEntity.storeOwner')

            ->leftJoin(BidDetailsEntity::class, 'bidDetailsEntity', Join::WITH, 'bidDetailsEntity.orderId = orderEntity.id')

            ->andWhere('orderEntity.isHide = :hide')
            ->setParameter('hide', OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE)
           
            ->andWhere('orderEntity.state != :cancelledState')
            ->setParameter('cancelledState', OrderStateConstant::ORDER_STATE_CANCEL)

            ->getQuery()
            ->getResult();
    }

    /**
     * Not delivered orders are all orders which status = on way to pick order, in store, picked, or on going
     */
    public function getNotDeliveredOrdersForAdmin(): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment',
                'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state', 'orderEntity.orderIsMain', 'orderEntity.isHide')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
            ->addSelect('bidDetailsEntity as bidDetailsInfo')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = orderEntity.storeOwner')

            ->leftJoin(BidDetailsEntity::class, 'bidDetailsEntity', Join::WITH, 'bidDetailsEntity.orderId = orderEntity.id')

            ->andWhere('orderEntity.state IN (:onGoingStatusArray)')
            ->setParameter('onGoingStatusArray', OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY)

            ->andWhere('orderEntity.isHide = :show')
            ->setParameter('show', OrderIsHideConstant::ORDER_SHOW)

            ->getQuery()
            ->getResult();
    }

    public function getOrdersByCaptainId(int $captainId): array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id')

            ->leftJoin(
                CaptainEntity::class,
                'captainProfileEntity',
                Join::WITH,
                'captainProfileEntity.id = orderEntity.captainId'
            )

            ->andWhere('captainProfileEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->orderBy('orderEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    public function getCountOrderOngoingForAdmin(): int
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('count (orderEntity.id) as ongoingOrdersCount')
           
            ->andWhere('orderEntity.state IN (:statesArray)')
            ->setParameter('statesArray', OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function getPendingOrdersCountForAdmin(): int
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('count (orderEntity.id) as pendingOrdersCount')

            ->andWhere('orderEntity.state = :pending')
            ->setParameter('pending', OrderStateConstant::ORDER_STATE_PENDING)

            ->andWhere('orderEntity.isHide = :orderShow')
            ->setParameter('orderShow', OrderIsHideConstant::ORDER_SHOW)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function getDeliveredOrdersCountBetweenTwoDatesForAdmin(DateTime $fromDate, DateTime $toDate): int
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('count (orderEntity.id) as deliveredOrdersCount')

            ->andWhere('orderEntity.state = :delivered')
            ->setParameter('delivered', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.updatedAt BETWEEN :fromDate AND :toDate')
            ->setParameter('fromDate', $fromDate)
            ->setParameter('toDate', $toDate)

            ->getQuery()
            ->getSingleScalarResult();
    }

    public function getOrderByIdWithStoreOrderDetail(int $id): ?array
    {   
       return $this->createQueryBuilder('orderEntity')
           ->select('IDENTITY (orderEntity.captainId) as captainUserId')
           ->addSelect('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.noteCaptainOrderCost',
            'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'orderEntity.isCaptainArrived', 'orderEntity.dateCaptainArrived', 'orderEntity.captainOrderCost', 'orderEntity.paidToProvider', 'orderEntity.isHide', 'orderEntity.orderIsMain')
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
   
   public function getOrdersOngoingCountByCaptainIdForAdmin($captainId): int
   {
       return $this->createQueryBuilder('orderEntity')
           ->select('count (orderEntity.id) as ongoingOrdersCount')
          
           ->andWhere('orderEntity.state IN (:statesArray)')
           ->setParameter('statesArray', OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY)
         
           ->andWhere('orderEntity.captainId = :captainId')
           ->setParameter('captainId', $captainId)

           ->getQuery()
           ->getSingleScalarResult();
   }
}
