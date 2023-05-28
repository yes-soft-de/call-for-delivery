<?php

namespace App\Repository;

use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Constant\ChatRoom\ChatRoomConstant;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Constant\Order\OrderCancelledByUserAndAtStateConstant;
use App\Constant\Order\OrderDestinationConstant;
use App\Constant\Order\OrderDistanceConstant;
use App\Constant\Order\OrderHasPayConflictAnswersConstant;
use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Constant\Payment\PaymentConstant;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Entity\BidDetailsEntity;
use App\Entity\CaptainFinancialDuesEntity;
use App\Entity\OrderDistanceConflictEntity;
use App\Entity\OrderEntity;
use App\Entity\CaptainEntity;
use App\Entity\OrderTimeLineEntity;
use App\Entity\PriceOfferEntity;
use App\Entity\StoreOrderDetailsEntity;
use App\Entity\StoreOwnerBranchEntity;
use App\Entity\ImageEntity;
use App\Entity\StoreOwnerProfileEntity;
use App\Entity\OrderChatRoomEntity;
use App\Entity\SubscriptionEntity;
use App\Entity\SupplierCategoryEntity;
use App\Request\Admin\Order\CaptainNotArrivedOrderFilterByAdminRequest;
use App\Request\Admin\Order\FilterDifferentlyAnsweredCashOrdersByAdminRequest;
use App\Request\Admin\Order\OrderDifferentDestinationFilterByAdminRequest;
use App\Request\Admin\Order\OrderFilterByAdminRequest;
use App\Request\Admin\Order\OrderHasPayConflictAnswersUpdateByAdminRequest;
use App\Request\Order\BidOrderFilterBySupplierRequest;
use App\Request\Order\CashOrdersPaidOrNotFilterByStoreRequest;
use App\Request\Order\OrderFilterByCaptainRequest;
use App\Request\Order\OrderFilterRequest;
use DateTime;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;
use App\Entity\RateEntity;
use App\Entity\SupplierProfileEntity;
use App\Constant\Order\OrderIsHideConstant;
use App\Request\Admin\Order\OrderCaptainFilterByAdminRequest;
use App\Request\Admin\Order\FilterOrdersPaidOrNotPaidByAdminRequest;
use App\Request\Admin\Order\FilterOrdersWhoseHasNotDistanceHasCalculatedRequest;
use App\Constant\GeoDistance\GeoDistanceResultConstant;

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

    /**
     * Gets specific order details with store and captain info for store owner
     */
    public function getSpecificOrderForStore(int $id): ?array
     {   
        return $this->createQueryBuilder('orderEntity')
            ->select('IDENTITY (orderEntity.captainId) as captainUserId')
            ->addSelect('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.noteCaptainOrderCost',
             'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'orderEntity.isCaptainArrived', 'orderEntity.dateCaptainArrived',
                'orderEntity.captainOrderCost', 'orderEntity.paidToProvider', 'orderEntity.isHide', 'orderEntity.orderIsMain', 'orderEntity.storeBranchToClientDistance',
                'orderEntity.isCashPaymentConfirmedByStore', 'orderEntity.isCashPaymentConfirmedByStoreUpdateDate', 'orderEntity.costType')
            ->addSelect('storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName',
             'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail', 'storeOrderDetails.filePdf')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName', 'storeOwnerBranch.branchPhone')
            ->addSelect('orderChatRoomEntity.roomId')
            ->addSelect('imageEntity.imagePath')
            ->addSelect('captainEntity.captainName', 'captainEntity.phone')
            ->addSelect('primaryOrderEntity.id as primaryOrderId')
            ->addSelect('orderDistanceConflictEntity as orderDistanceConflict')
            ->addSelect('storeOwnerProfileEntity.roomID as chatSupportRoomId')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            ->leftJoin(OrderChatRoomEntity::class, 'orderChatRoomEntity', Join::WITH, 'orderChatRoomEntity.orderId = orderEntity.id and orderChatRoomEntity.captain = orderEntity.captainId')
            ->leftJoin(ImageEntity::class, 'imageEntity', Join::WITH, 'imageEntity.id = storeOrderDetails.images')
            ->leftJoin(CaptainEntity::class, 'captainEntity', Join::WITH, 'captainEntity.id = orderEntity.captainId')

            ->leftJoin(
                OrderDistanceConflictEntity::class,
                'orderDistanceConflictEntity',
                Join::WITH,
                'orderDistanceConflictEntity.orderId = orderEntity.id'
            )

            ->leftJoin(
                OrderEntity::class,
                'primaryOrderEntity',
                Join::WITH,
                'primaryOrderEntity.id = orderEntity.primaryOrder'
            )

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = orderEntity.storeOwner'
            )
            
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

        if ($request->getState() !== null && $request->getState() !== "" && $request->getState() !== OrderStateConstant::ORDER_STATE_ONGOING) {
            $query->andWhere('orderEntity.state = :orderState');
            $query->setParameter('orderState', $request->getState());

        } elseif ($request->getState() === OrderStateConstant::ORDER_STATE_ONGOING) {
            $response = [];

            $orders = $query->getQuery()->getResult();

            if ($orders) {
                foreach ($orders as $order) {
                    if ($order['state'] === OrderStateConstant::ORDER_STATE_DELIVERED) {
                        if (! empty($this->checkIfMainOrderHasUnDeliveredSubOrders($order['id']))) {
                            $response[] = $order['id'];
                        }
                    }
                }
            }

            $query->andWhere('orderEntity.state IN (:ongoingStates) OR orderEntity.id IN (:ordersIdArray)');
            $query->setParameter('ongoingStates', OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY);
            $query->setParameter('ordersIdArray', $response);
        }

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
            || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterOrdersByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
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

    public function closestOrders(int $captainId, DateTime $date): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment', 'orderEntity.storeBranchToClientDistance',
            'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state', 'orderEntity.orderIsMain')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')
            ->addSelect('orderChatRoomEntity.roomId', 'orderChatRoomEntity.usedAs')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
            ->addSelect('bidDetailsEntity as bidDetailsInfo')
            ->addSelect('storeOrderDetails.destination')
           
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

            ->andWhere('orderEntity.deliveryDate <= :date')
            ->setParameter('date', $date)

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

    public function getSpecificOrderForCaptain(int $id, int $captainId, int $userId): ?array
     {   
        return $this->createQueryBuilder('orderEntity')

            ->addSelect('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note',
             'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'orderEntity.paidToProvider', 'orderEntity.orderIsMain', 'orderEntity.storeBranchToClientDistance')
            ->addSelect('storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName',
             'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail', 'storeOrderDetails.filePdf')
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
                'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'orderEntity.storeBranchToClientDistance', 'storeOrderDetails.id as storeOrderDetailsId',
                'storeOrderDetails.destination', 'storeOrderDetails.recipientName', 'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail', 'storeOwnerBranch.id as storeOwnerBranchId',
                'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName', 'imageEntity.id as imageId', 'imageEntity.imagePath as images',
                'captainEntity.id as captainProfileId')

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

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = orderEntity.captainId'
            )

            ->orderBy('orderEntity.id', 'DESC');

        if ($request->getOrderId()) {
            $query->andWhere('orderEntity.id = :orderId');
            $query->setParameter('orderId', $request->getOrderId());
        }

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

        if ($request->getChosenDistanceIndicator() === OrderDistanceConstant::KILOMETER_DISTANCE_CONST) {
            if (($request->getKilometer()) && ($request->getKilometer() !== "")) {
                $query->andWhere('orderEntity.kilometer = :kilometerValue');
                $query->setParameter('kilometerValue', $request->getKilometer());
            }

        } elseif ($request->getChosenDistanceIndicator() === OrderDistanceConstant::STORE_BRANCH_TO_CLIENT_DISTANCE_CONST) {
            if (($request->getStoreBranchToClientDistance()) && ($request->getStoreBranchToClientDistance() !== "")) {
                $query->andWhere('orderEntity.storeBranchToClientDistance = :storeBranchToClientDistanceValue');
                $query->setParameter('storeBranchToClientDistanceValue', $request->getStoreBranchToClientDistance());
            }
        }

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
         || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
         || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterOrdersByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
        }

        return $query->getQuery()->getResult();
    }

    /**
     * Gets specific order details with store and captain info by order id for admin
     */
    public function getSpecificOrderByIdForAdmin(int $id): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('IDENTITY (orderEntity.captainId) as captainUserId', 'orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note',
                'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination',
                'storeOrderDetails.recipientName', 'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail', 'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName',
                'imageEntity.imagePath as orderImage', 'captainEntity.captainName', 'captainEntity.phone', 'orderEntity.paidToProvider', 'orderEntity.noteCaptainOrderCost', 'orderEntity.captainOrderCost',
                'orderEntity.deliveryCost', 'storeOrderDetails.filePdf', 'orderEntity.storeBranchToClientDistance', 'orderEntity.isCashPaymentConfirmedByStore',
                'orderEntity.isCashPaymentConfirmedByStoreUpdateDate', 'primaryOrderEntity.id as primaryOrderId', 'orderEntity.costType')
            ->addSelect('storeOwnerProfileEntity.id as storeOwnerId')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')
            ->addSelect('subscriptionEntity as storeSubscription')

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

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = orderEntity.storeOwner'
            )

            ->leftJoin(
                OrderEntity::class,
                'primaryOrderEntity',
                Join::WITH,
                'primaryOrderEntity.id = orderEntity.primaryOrder'
            )

            ->leftJoin(
                SubscriptionEntity::class,
                'subscriptionEntity',
                Join::WITH,
                'subscriptionEntity.storeOwner = storeOwnerProfileEntity.id'
                .' AND subscriptionEntity.startDate < orderEntity.createdAt AND subscriptionEntity.endDate > orderEntity.createdAt'
            )

            // orderBy and setMaxResults (besides the date condition) had been used to prevent returning more than one subscription,
            // as long as store could create two subscriptions (current and future) then create an order
            ->orderBy('subscriptionEntity.id', 'DESC')
            ->setMaxResults(1)

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

        if ($request->getState() != null && $request->getState() != "" && $request->getState() != OrderStateConstant::ORDER_STATE_ONGOING) {
            $query->andWhere('orderEntity.state = :state');
            $query->setParameter('state', $request->getState());

        } elseif ($request->getState() === OrderStateConstant::ORDER_STATE_ONGOING) {
            $response = [];

            $orders = $query->getQuery()->getResult();

            if ($orders) {
                foreach ($orders as $order) {
                    if ($order['state'] === OrderStateConstant::ORDER_STATE_DELIVERED) {
                        if (! empty($this->checkIfMainOrderHasUnDeliveredSubOrders($order['id']))) {
                            $response[] = $order['id'];
                        }
                    }
                }
            }

            $query->andWhere('orderEntity.state IN (:ongoingStates) OR orderEntity.id IN (:ordersIdArray)');
            $query->setParameter('ongoingStates', OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY);
            $query->setParameter('ordersIdArray', $response);
        }

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
            || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterOrdersByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
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
                OrderTimeLineEntity::class,
                'orderLogEntity',
                Join::WITH,
                'orderLogEntity.orderId = orderEntity.id'
            )
            ->andWhere('orderLogEntity.isCaptainArrived = :captainArrived')
            ->setParameter('captainArrived', 0)

            ->orderBy('orderEntity.id', 'DESC')

            ->groupBy('orderEntity.id');

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
            || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterOrdersByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
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

        ->select('orderEntity.id, orderEntity.kilometer', 'orderEntity.payment', 'orderEntity.captainOrderCost',
            'orderEntity.paidToProvider, orderEntity.storeBranchToClientDistance')

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

        ->andWhere('orderEntity.storeBranchToClientDistance >= :countKilometersFrom')
        ->setParameter('countKilometersFrom', $countKilometersFrom)

        ->andWhere('orderEntity.storeBranchToClientDistance <= :countKilometersTo')
        ->setParameter('countKilometersTo', $countKilometersTo)

        ->andWhere('orderEntity.storeBranchToClientDistance != :zero')
        ->setParameter('zero', 0)

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

    /**
     * Get pending orders which aren't hidden nor sub orders
     */
    public function getNotHiddenNotSubPendingOrders(): ?array
    {
        return $this->createQueryBuilder('orderEntity')

            ->andWhere('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_PENDING)

            ->andWhere('orderEntity.orderType = :normalOrderType')
            ->setParameter('normalOrderType', OrderTypeConstant::ORDER_TYPE_NORMAL)

            ->andWhere('orderEntity.isHide != :hide AND orderEntity.isHide != :subOrderVisibility')
            ->setParameter('hide', OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE)
            ->setParameter('subOrderVisibility', OrderIsHideConstant::ORDER_HIDE)

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
            ->addSelect('storeOrderDetails.destination')
           
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
            'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state', 'orderEntity.isCashPaymentConfirmedByStore',
                'orderEntity.isCashPaymentConfirmedByStoreUpdateDate')
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
//            ->addSelect('orderEntity.primaryOrder as primaryOrderId')
           
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

            ->orderBy('orderEntity.id', 'DESC')

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
            ->addSelect('captainEntity.id as captainProfileId', 'captainEntity.captainName')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = orderEntity.storeOwner')

            ->leftJoin(BidDetailsEntity::class, 'bidDetailsEntity', Join::WITH, 'bidDetailsEntity.orderId = orderEntity.id')

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = orderEntity.captainId'
            )

            ->andWhere('orderEntity.state IN (:onGoingStatusArray)')
            ->setParameter('onGoingStatusArray', OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY)

            ->andWhere('orderEntity.isHide = :show OR orderEntity.isHide = :subOrderVisibility')
            ->setParameter('show', OrderIsHideConstant::ORDER_SHOW)
            ->setParameter('subOrderVisibility', OrderIsHideConstant::ORDER_HIDE)

            ->orderBy('orderEntity.id', 'DESC')

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

    /**
     * Get array of delivered orders between two dates
     */
    public function getDeliveredOrdersBetweenTwoDatesForAdmin(DateTime $fromDate, DateTime $toDate, string $customizedTimezone = null): array
    {
        $query = $this->createQueryBuilder('orderEntity')

            ->andWhere('orderEntity.state = :delivered')
            ->setParameter('delivered', OrderStateConstant::ORDER_STATE_DELIVERED);

        $tempArrayResult = $query->getQuery()->getResult();

        if (count($tempArrayResult) > 0) {
            return $this->filterOrdersEntitiesByDates($tempArrayResult, $fromDate, $toDate, $customizedTimezone);
        }

        return $tempArrayResult;
    }

    public function getOrderByIdWithStoreOrderDetail(int $id): ?array
    {   
       return $this->createQueryBuilder('orderEntity')
           ->select('IDENTITY (orderEntity.captainId) as captainUserId')
           ->addSelect('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.noteCaptainOrderCost',
            'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'orderEntity.isCaptainArrived', 'orderEntity.dateCaptainArrived', 'orderEntity.captainOrderCost',
               'orderEntity.paidToProvider', 'orderEntity.isHide', 'orderEntity.orderIsMain', 'primaryOrderEntity.id as primaryOrderId')
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

           ->leftJoin(
               OrderEntity::class,
               'primaryOrderEntity',
               Join::WITH,
               'primaryOrderEntity.id = orderEntity.primaryOrder'
           )
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

    public function getOrdersByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): array
    {
        return $this->createQueryBuilder('orderEntity')

            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment',
                'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state', 'orderEntity.orderIsMain')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = orderEntity.storeOwner')

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
            ->getResult();
    }

    public function getOrdersByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment',
                'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state', 'orderEntity.orderIsMain')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = orderEntity.storeOwner')

            ->where('(orderEntity.state = :deliveredState)'
                .' OR (orderEntity.state = :cancelledState AND orderEntity.orderCancelledByUserAndAtState IN (:orderCancelledByUserAndAtStateArray))')
            ->setParameter('deliveredState', OrderStateConstant::ORDER_STATE_DELIVERED)
            ->setParameter('cancelledState', OrderStateConstant::ORDER_STATE_CANCEL)
            ->setParameter('orderCancelledByUserAndAtStateArray', OrderCancelledByUserAndAtStateConstant::ORDER_CANCEL_USER_AND_STATE_ARRAY)

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->andWhere('orderEntity.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)

            ->andWhere('orderEntity.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

           ->getQuery()
           ->getResult();
   }

    public function checkWhetherCaptainReceivedOrderForSpecificStore(int $captainId, int $storeId): ?OrderEntity
    {
        return $this->createQueryBuilder('orderEntity')
            ->andWhere('orderEntity.state IN (:statesArray)')
            ->setParameter('statesArray', OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY)

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->andWhere('orderEntity.storeOwner = :storeId')
            ->setParameter('storeId', $storeId)

            ->setMaxResults(1)
            ->getQuery()
            //    ->getResult();
            ->getOneOrNullResult();
    }

    public function getStoreOrdersByStoreOwnerId(int $storeOwnerId): array
    {
        return $this->createQueryBuilder('orderEntity')

            ->leftJoin(
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = orderEntity.storeOwner'
            )

            ->andWhere('storeOwnerProfileEntity.storeOwnerId = :storeOwnerId')
            ->setParameter('storeOwnerId', $storeOwnerId)

            ->getQuery()
            ->getResult();
    }

    public function filterCaptainOrdersByAdmin(OrderCaptainFilterByAdminRequest $request): array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.deliveryDate', 'orderEntity.captainOrderCost',
                'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName',
                'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail', 'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName',
                'imageEntity.id as imageId', 'imageEntity.imagePath as images', 'orderEntity.isCashPaymentConfirmedByStore', 'orderEntity.isCashPaymentConfirmedByStoreUpdateDate')

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

        if ($request->getCaptainId()) {
            $query->andWhere('orderEntity.captainId = :captainId');
            $query->setParameter('captainId', $request->getCaptainId());
        }

        if ($request->getState() !== null && $request->getState() !== "" && $request->getState() !== OrderStateConstant::ORDER_STATE_ONGOING) {
            $query->andWhere('orderEntity.state = :state');
            $query->setParameter('state', $request->getState());

        } elseif ($request->getState() === OrderStateConstant::ORDER_STATE_ONGOING) {
            $query->andWhere('orderEntity.state IN (:statesArray)');
            $query->setParameter('statesArray', OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY);
        }

        if ($request->getPayment() === PaymentConstant::CASH_PAYMENT_METHOD_CONST || $request->getPayment() === PaymentConstant::CARD_PAYMENT_METHOD_CONST) {
            $query->andWhere('orderEntity.payment = :paymentMethod');
            $query->setParameter('paymentMethod', $request->getPayment());
        }

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
            || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterOrdersByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());

        } elseif (($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() === null || $request->getToDate() === "")) {
            // Get the orders which delivery date is during today
            $tempResult = $query->getQuery()->getResult();

            if (count($tempResult) > 0) {
                // For storing the id of the order which meet the condition
                $acceptedOrdersIdsArray = [];

                $timeZone = $request->getCustomizedTimezone();

                foreach ($tempResult as $order) {
                    if (($order['deliveryDate']->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) >=
                        new \DateTime((new \DateTime('now'))->format('Y-m-d 00:00:00'))) &&
                        ($order['deliveryDate']->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) <=
                            new \DateTime((new \DateTime('now'))->format('Y-m-d 23:59:59'))))
                    {
                        $acceptedOrdersIdsArray[] = $order['id'];
                    }
                }

                $query->andWhere('orderEntity.id IN (:acceptedOrdersIds)');
                $query->setParameter('acceptedOrdersIds', $acceptedOrdersIdsArray);
            }
        }

        return $query->getQuery()->getResult();
    }

    public function getSubOrdersByPrimaryOrderIdForAdmin(int $primaryOrderId): array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment', 'orderEntity.orderCost',
                'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')
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
                StoreOwnerProfileEntity::class,
                'storeOwnerProfileEntity',
                Join::WITH,
                'storeOwnerProfileEntity.id = orderEntity.storeOwner'
            )

            ->andWhere('orderEntity.primaryOrder = :primaryOrderId')
            ->setParameter('primaryOrderId', $primaryOrderId)

            ->orderBy('orderEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    // filter orders in which the store's answer differs from that of the captain (paid or not paid)
    public function filterOrdersPaidOrNotPaidByAdmin(FilterOrdersPaidOrNotPaidByAdminRequest $request): ?array
     {
         $query = $this->createQueryBuilder('orderEntity')
             ->select('orderEntity.id', 'orderEntity.createdAt', 'orderEntity.isCashPaymentConfirmedByStore', 'orderEntity.isCashPaymentConfirmedByStoreUpdateDate',
                 'orderEntity.paidToProvider', 'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.name as branchName', 'captainEntity.captainName',
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
            
             ->andWhere('orderEntity.isCashPaymentConfirmedByStore != orderEntity.paidToProvider')
             ->andWhere('orderEntity.state = :state')
             ->setParameter('state', OrderStateConstant::ORDER_STATE_DELIVERED)

             ->andWhere('orderEntity.payment = :payment')
             ->setParameter('payment', OrderTypeConstant::ORDER_PAYMENT_CASH)
 
             ->orderBy('orderEntity.id', 'DESC')

             ->groupBy('orderEntity.id');

         if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
             || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
             || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
             $tempQuery = $query->getQuery()->getResult();

             return $this->filterOrdersByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
         }
 
         return $query->getQuery()->getResult();
     }

   public function getStoreOrdersWhichTakenByUniqueCaptainsAfterSpecificDate(StoreOwnerProfileEntity $storeOwnerProfileEntity, $specificDateTime): array
   {
       return $this->createQueryBuilder('orderEntity')
           ->select('COUNT(orderEntity.id)')

           ->andWhere('orderEntity.storeOwner = :storeOwnerProfile')
           ->setParameter('storeOwnerProfile', $storeOwnerProfileEntity)

           ->andWhere('orderEntity.orderType = :normalOrderType')
           ->setParameter('normalOrderType', OrderTypeConstant::ORDER_TYPE_NORMAL)

           ->leftJoin(
               OrderTimeLineEntity::class,
               'orderTimeLineEntity',
               Join::WITH,
               'orderTimeLineEntity.orderId = orderEntity.id'
           )

           ->andWhere('orderTimeLineEntity.orderState = :onWayToPickOrderState')
           ->setParameter('onWayToPickOrderState', OrderStateConstant::ORDER_STATE_ON_WAY)

           ->andWhere('orderTimeLineEntity.createdAt > :specificDateTime')
           ->setParameter('specificDateTime', $specificDateTime)

           ->andWhere('orderEntity.captainId IS NOT NULL')
           ->groupBy('orderEntity.captainId')

           ->getQuery()
           ->getSingleColumnResult();
   }

    // filter orders whose has not distance  has calculated
    public function filterOrdersWhoseHasNotDistanceHasCalculated(FilterOrdersWhoseHasNotDistanceHasCalculatedRequest  $request): ?array
     {
         $query = $this->createQueryBuilder('orderEntity')
             ->select('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.deliveryDate', 'orderEntity.captainOrderCost',
             'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName',
             'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail', 'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName', 'orderEntity.storeBranchToClientDistance')
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
            
             ->andWhere('orderEntity.storeBranchToClientDistance is NULL or orderEntity.storeBranchToClientDistance = :zero')
             ->setParameter('zero', GeoDistanceResultConstant::ZERO_DISTANCE_CONST)
 
             ->orderBy('orderEntity.id', 'DESC')

             ->groupBy('orderEntity.id');

         if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
             || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
             || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
             $tempQuery = $query->getQuery()->getResult();

             return $this->filterOrdersByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
         }
 
         return $query->getQuery()->getResult();
     }
   
    // filter orders
    public function filterOrders(FilterOrdersWhoseHasNotDistanceHasCalculatedRequest  $request): ?array
     {
         $query = $this->createQueryBuilder('orderEntity')
             ->select('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.deliveryDate', 'orderEntity.captainOrderCost',
             'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.kilometer', 'storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination', 'storeOrderDetails.recipientName',
             'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail', 'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName', 'orderEntity.storeBranchToClientDistance')
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
            
             ->andWhere('orderEntity.storeBranchToClientDistance is NOT NULL or orderEntity.storeBranchToClientDistance != :zero')
             ->setParameter('zero', GeoDistanceResultConstant::ZERO_DISTANCE_CONST)
            
             ->orderBy('orderEntity.id', 'DESC')

             ->groupBy('orderEntity.id');

         if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
             || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
             || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
             $tempQuery = $query->getQuery()->getResult();

             return $this->filterOrdersByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
         }
 
         return $query->getQuery()->getResult();
     }

    // filter Orders not answered by the store (paid or not paid)
    public function filterOrdersNotAnsweredByTheStore(FilterOrdersPaidOrNotPaidByAdminRequest $request): ?array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.createdAt', 'orderEntity.isCashPaymentConfirmedByStore', 'orderEntity.isCashPaymentConfirmedByStoreUpdateDate',
                'orderEntity.paidToProvider', 'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.name as branchName', 'captainEntity.captainName', 'storeOwnerProfileEntity.storeOwnerName')

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
           
            ->andWhere('orderEntity.isCashPaymentConfirmedByStore IS NULL')
            ->andWhere('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.payment = :payment')
            ->setParameter('payment', OrderTypeConstant::ORDER_PAYMENT_CASH)

            ->orderBy('orderEntity.id', 'DESC')

            ->groupBy('orderEntity.id');

        if ($request->getStoreId() != null || $request->getStoreId() != "") {
            $query->andWhere('orderEntity.storeOwner = :storeOwner');
            $query->setParameter('storeOwner', $request->getStoreId());
        }

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
            || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterOrdersByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
        }

        return $query->getQuery()->getResult();
    }

    /** Following function check if captain has ongoing orders from specific store **/
//    public function checkWhetherCaptainReceivedOrderForSpecificStoreForAdmin(int $captainProfileId, int $storeId): ?OrderEntity
//    {
//        return $this->createQueryBuilder('orderEntity')
//            ->andWhere('orderEntity.state IN (:statesArray)')
//            ->setParameter('statesArray', OrderStateConstant::ORDER_STATE_ONGOING_FILTER_ARRAY)
//
//            ->andWhere('orderEntity.captainId = :captainId')
//            ->setParameter('captainId', $captainProfileId)
//
//            ->andWhere('orderEntity.storeOwner = :storeId')
//            ->setParameter('storeId', $storeId)
//
//            ->setMaxResults(1)
//            ->getQuery()
//            ->getOneOrNullResult();
//    }

    // filter Cash Orders which are not being answered by the store (paid or not paid) (for store)
    public function filterCashOrdersPaidOrNotByStore(CashOrdersPaidOrNotFilterByStoreRequest $request): array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.createdAt', 'orderEntity.isCashPaymentConfirmedByStore', 'orderEntity.isCashPaymentConfirmedByStoreUpdateDate',
                'orderEntity.paidToProvider', 'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.name as branchName', 'captainEntity.captainName', 'storeOwnerProfileEntity.storeOwnerName')

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

            ->andWhere('orderEntity.isCashPaymentConfirmedByStore IS NULL')
            ->andWhere('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.payment = :payment')
            ->setParameter('payment', OrderTypeConstant::ORDER_PAYMENT_CASH)

            ->andWhere('storeOwnerProfileEntity.storeOwnerId = :storeOwnerUserId')
            ->setParameter('storeOwnerUserId', $request->getStoreOwnerUserId())

            ->orderBy('orderEntity.id', 'DESC')

            ->groupBy('orderEntity.id');

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
            || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterOrdersByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
        }

        return $query->getQuery()->getResult();
    }  
    
    // filter cash orders which have different answers for cash payment
    public function filterDifferentAnsweredCashOrdersByAdmin(FilterDifferentlyAnsweredCashOrdersByAdminRequest $request): array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.createdAt', 'orderEntity.isCashPaymentConfirmedByStore', 'orderEntity.isCashPaymentConfirmedByStoreUpdateDate',
                'orderEntity.paidToProvider', 'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.name as branchName', 'captainEntity.captainName', 'storeOwnerProfileEntity.storeOwnerName')

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

//            ->andWhere('orderEntity.isCashPaymentConfirmedByStore IS NOT NULL')
//            ->andWhere('orderEntity.paidToProvider IS NOT NULL')
//            ->andWhere('orderEntity.isCashPaymentConfirmedByStore != orderEntity.paidToProvider')

            ->andWhere('orderEntity.hasPayConflictAnswers = :orderHasPayConflictAnswers')
            ->setParameter('orderHasPayConflictAnswers', OrderHasPayConflictAnswersConstant::ORDER_HAS_PAYMENT_CONFLICT_ANSWERS)

            ->andWhere('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.payment = :payment')
            ->setParameter('payment', OrderTypeConstant::ORDER_PAYMENT_CASH)

            ->orderBy('orderEntity.id', 'DESC')

            ->groupBy('orderEntity.id');

        if ($request->getStoreProfileId() !== null && $request->getStoreProfileId() !== "") {
            $query->andWhere('orderEntity.storeOwner = :storeOwner');
            $query->setParameter('storeOwner', $request->getStoreProfileId());
        }

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
            || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterOrdersByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
        }

        return $query->getQuery()->getResult();
    }

    // Get orders which accepted by captains and their created date is above 8/19/2022
    public function getOrders(): array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('IDENTITY (orderEntity.captainId) as captainId')
            ->addSelect('orderEntity.id, orderEntity.createdAt')
            
            ->andWhere('orderEntity.createdAt > :createdAt')
            ->setParameter('createdAt', new DateTime('2022-08-19 '))
           
            ->andWhere('orderEntity.captainId IS NOT NULL')

            ->getQuery()
            ->getResult();
    }

    // retrieve delivered cash orders which doesn't confirmed by store if cash payment was received or not
    public function getNotConfirmedCashPaymentOrdersBeforeSpecificDate(DateTime $dateTime): array
    {
        return $this->createQueryBuilder('orderEntity')

            ->andWhere('orderEntity.state = :deliveredState')
            ->setParameter('deliveredState', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.payment = :cashMethod')
            ->setParameter('cashMethod', PaymentConstant::CASH_PAYMENT_METHOD_CONST)

            ->andWhere('orderEntity.createdAt < :specificDate')
            ->setParameter('specificDate', $dateTime)

            ->andWhere('orderEntity.isCashPaymentConfirmedByStore IS NULL')

            ->getQuery()
            ->getResult();
    }

    // retrieve delivered cash orders which had been answered by both store and captain before certain date
    public function getCashPaymentAnsweredOrdersBeforeSpecificDate(): array
    {
        return $this->createQueryBuilder('orderEntity')

            ->andWhere('orderEntity.state = :deliveredState')
            ->setParameter('deliveredState', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.payment = :cashMethod')
            ->setParameter('cashMethod', PaymentConstant::CASH_PAYMENT_METHOD_CONST)

            ->andWhere('orderEntity.hasPayConflictAnswers IS NULL')

            ->andWhere('orderEntity.isCashPaymentConfirmedByStore IS NOT NULL')

            ->getQuery()
            ->getResult();
    }

    public function filterCashPaymentAnsweredOrdersForAdmin(OrderHasPayConflictAnswersUpdateByAdminRequest $request): array
    {
        $query = $this->createQueryBuilder('orderEntity')

            ->andWhere('orderEntity.state = :deliveredState')
            ->setParameter('deliveredState', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.payment = :cashMethod')
            ->setParameter('cashMethod', PaymentConstant::CASH_PAYMENT_METHOD_CONST)

            ->andWhere('orderEntity.isCashPaymentConfirmedByStore IS NOT NULL')
            ->andWhere('orderEntity.paidToProvider IS NOT NULL')

            ->andWhere('orderEntity.hasPayConflictAnswers IS NOT NULL')
            ->andWhere('orderEntity.hasPayConflictAnswers = :conflictExist')
            ->setParameter('conflictExist', OrderHasPayConflictAnswersConstant::ORDER_HAS_PAYMENT_CONFLICT_ANSWERS)

            ->orderBy('orderEntity.id', 'DESC');

        if (($request->getFromDate()) && ($request->getFromDate() !== "")) {
            $query->andWhere('orderEntity.createdAt >= :fromDate');
            $query->setParameter('fromDate', $request->getFromDate());
        }

        if (($request->getToDate()) && ($request->getToDate() !== "")) {
            $query->andWhere('orderEntity.createdAt <= :toDate');
            $query->setParameter('toDate', $request->getToDate());
        }

        if ($request->getOrderId()) {
            $query->andWhere('orderEntity.id = :orderId');
            $query->setParameter('orderId', $request->getOrderId());
        }

        return $query->getQuery()->getResult();
    }

    public function filterOrdersByDates(array $tempOrders, ?string $fromDate, ?string $toDate, ?string $timeZone): array
    {
        $filteredOrders = [];

        if (count($tempOrders) > 0) {
            if (($fromDate != null || $fromDate != "") && ($toDate === null || $toDate === "")) {
                foreach ($tempOrders as $key => $value) {
                    if ($value['createdAt']->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) >=
                        new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) {
                        $filteredOrders[$key] = $value;
                    }
                }

            } elseif (($fromDate === null || $fromDate === "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $key => $value) {
                    if ($value['createdAt']->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) <=
                        new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59'))) {
                        $filteredOrders[$key] = $value;
                    }
                }

            } elseif (($fromDate != null || $fromDate != "") && ($toDate != null || $toDate != "")) {
                foreach ($tempOrders as $key => $value) {
                    if (($value['createdAt']->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) >=
                        new \DateTime((new \DateTime($fromDate))->format('Y-m-d 00:00:00'))) &&
                        ($value['createdAt']->setTimeZone(new \DateTimeZone($timeZone ? $timeZone : 'UTC')) <=
                            new \DateTime((new \DateTime($toDate))->format('Y-m-d 23:59:59')))) {
                        $filteredOrders[$key] = $value;
                    }
                }
            }
        }

        return $filteredOrders;
    }

    public function getOverdueDeliveredOrdersByCaptainIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->createQueryBuilder('orderEntity')

            ->select('count(orderEntity.id)')

            ->where('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->andWhere('orderEntity.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)

            ->andWhere('orderEntity.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->andWhere('(orderEntity.storeBranchToClientDistance IS NOT NULL AND orderEntity.storeBranchToClientDistance >= :limitDistance) '
                        .'OR (orderEntity.storeBranchToClientDistance IS NULL AND orderEntity.kilometer >= :limitDistance)')
            ->setParameter('limitDistance', CaptainFinancialSystem::KILOMETER_TO_DOUBLE_ORDER)

            ->getQuery()
            ->getSingleColumnResult();
    }

    // There is another function with similar purpose but it returns the result in different format
    // This is done by Rami for finding another way of calculating captain financial dues of the second financial system
    public function getDeliveredOrdersByCountCaptainIdAndBetweenTwoDates(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->createQueryBuilder('orderEntity')

            ->select('count(orderEntity.id)')

            ->where('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->andWhere('orderEntity.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)

            ->andWhere('orderEntity.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->getQuery()
            ->getSingleColumnResult();
    }

    // Get count of orders without distance and delivered by specific captain during specific time
    public function getOrdersWithoutDistanceCountByCaptainIdOnSpecificDate(int $captainId, string $fromDate, string $toDate): array
    {
        return $this->createQueryBuilder('orderEntity')

            ->select('COUNT(orderEntity.id)')

            ->where('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->andWhere('orderEntity.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)

            ->andWhere('orderEntity.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->andWhere('orderEntity.storeBranchToClientDistance IS NULL OR orderEntity.storeBranchToClientDistance = :zeroValue')
            ->setParameter('zeroValue', 0)

            ->getQuery()
            ->getSingleColumnResult();
    }

    public function getOrderTypeAndDestinationFromStoreOrderDetailsByOrderIdForAdmin(int $orderId): ?array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id ', 'orderEntity.orderType')
            ->addSelect('storeOrderDetails.destination')
            ->addSelect('storeOwnerBranchEntity.location')

            ->leftJoin(
                StoreOrderDetailsEntity::class,
                'storeOrderDetails',
                Join::WITH,
                'orderEntity.id = storeOrderDetails.orderId'
            )

            ->leftJoin(
                StoreOwnerBranchEntity::class,
                'storeOwnerBranchEntity',
                Join::WITH,
                'storeOwnerBranchEntity.id = storeOrderDetails.branch'
            )

            ->andWhere('orderEntity.id = :id')
            ->setParameter('id', $orderId)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getOrderIsHideByOrderId(int $orderId): array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.isHide')

            ->where('orderEntity.id = :orderId')
            ->setParameter('orderId', $orderId)

            ->getQuery()
            ->getSingleColumnResult();
    }

    // Get delivered orders during current active financial cycle of a captain by admin
    public function getOrdersByCaptainProfileIdAndCaptainFinancialCycle(int $captainProfileId): array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id ', 'orderEntity.state', 'orderEntity.payment', 'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.deliveryDate',
                'orderEntity.captainOrderCost', 'orderEntity.createdAt', 'orderEntity.updatedAt', 'orderEntity.orderIsMain', 'storeOrderDetails.id as storeOrderDetailsId', 'storeOrderDetails.destination',
                'storeOrderDetails.recipientName', 'storeOrderDetails.recipientPhone', 'storeOrderDetails.detail', 'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location',
                'storeOwnerBranch.name as branchName')

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
                CaptainFinancialDuesEntity::class,
                'captainFinancialDuesEntity',
                Join::WITH,
                'captainFinancialDuesEntity.captain = :captainProfileId'
            )

            ->andWhere('captainFinancialDuesEntity.state = :activeState')
            ->setParameter('activeState', CaptainFinancialDues::FINANCIAL_STATE_ACTIVE)

            ->andWhere('orderEntity.captainId = :captainProfileId')
            ->setParameter('captainProfileId', $captainProfileId)

            ->andWhere('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->andWhere('orderEntity.createdAt BETWEEN captainFinancialDuesEntity.startDate AND captainFinancialDuesEntity.endDate')

            ->orderBy('orderEntity.id', 'DESC')

            ->getQuery()
            ->getResult();
    }

    /**
     * filter orders which have different destination
     */
    public function filterDifferentDestinationOrdersByAdmin(OrderDifferentDestinationFilterByAdminRequest $request): array
    {
        $query = $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.createdAt', 'orderEntity.isCashPaymentConfirmedByStore', 'orderEntity.isCashPaymentConfirmedByStoreUpdateDate',
                'orderEntity.storeBranchToClientDistanceAdditionExplanation', 'orderEntity.storeBranchToClientDistance', 'orderEntity.paidToProvider',
                'storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.name as branchName', 'captainEntity.captainName', 'storeOwnerProfileEntity.storeOwnerName',
                'storeOrderDetails.destination')

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

            ->andWhere('storeOrderDetails.differentReceiverDestination = :orderDestinationIsDifferentAndUpdatedByCaptain')
            ->setParameter('orderDestinationIsDifferentAndUpdatedByCaptain', OrderDestinationConstant::ORDER_DESTINATION_IS_DIFFERENT_AND_UPDATED_BY_CAPTAIN_CONST)

            ->orderBy('orderEntity.id', 'DESC')

            ->groupBy('orderEntity.id');

        if ((($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() === null || $request->getToDate() === ""))
            || ($request->getFromDate() === null || $request->getFromDate() === "") && ($request->getToDate() != null || $request->getToDate() != "")
            || ($request->getFromDate() != null || $request->getFromDate() != "") && ($request->getToDate() != null || $request->getToDate() != "")) {
            $tempQuery = $query->getQuery()->getResult();

            return $this->filterOrdersByDates($tempQuery, $request->getFromDate(), $request->getToDate(), $request->getCustomizedTimezone());
        }

        return $query->getQuery()->getResult();
    }

    /**
     * Get all orders with details that delivered by specific captain during specific date and storeBranchToClientDistance
     * for each order belong to the specific category of the third financial system
     */
    public function getOrdersDetailsByFinancialSystemThree(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('orderEntity.id', 'orderEntity.deliveryDate', 'orderEntity.createdAt', 'orderEntity.payment',
                'orderEntity.orderCost', 'orderEntity.orderType', 'orderEntity.note', 'orderEntity.state', 'orderEntity.orderIsMain')
            ->addSelect('storeOwnerBranch.id as storeOwnerBranchId', 'storeOwnerBranch.location', 'storeOwnerBranch.name as branchName')
            ->addSelect('storeOwnerProfileEntity.storeOwnerName')

            ->leftJoin(StoreOrderDetailsEntity::class, 'storeOrderDetails', Join::WITH, 'orderEntity.id = storeOrderDetails.orderId')
            ->leftJoin(StoreOwnerBranchEntity::class, 'storeOwnerBranch', Join::WITH, 'storeOrderDetails.branch = storeOwnerBranch.id')
            ->leftJoin(StoreOwnerProfileEntity::class, 'storeOwnerProfileEntity', Join::WITH, 'storeOwnerProfileEntity.id = orderEntity.storeOwner')

            ->where('orderEntity.state = :deliveredState'
                .' OR (orderEntity.state = :cancelledState AND orderEntity.orderCancelledByUserAndAtState IN (:orderCancelledByUserAndAtStateArray))')
            ->setParameter('deliveredState', OrderStateConstant::ORDER_STATE_DELIVERED)
            ->setParameter('cancelledState', OrderStateConstant::ORDER_STATE_CANCEL)
            ->setParameter('orderCancelledByUserAndAtStateArray', OrderCancelledByUserAndAtStateConstant::ORDER_CANCEL_USER_AND_STATE_ARRAY)

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->andWhere('orderEntity.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)

            ->andWhere('orderEntity.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->andWhere('orderEntity.storeBranchToClientDistance IS NOT NULL')

            ->andWhere('orderEntity.storeBranchToClientDistance >= :countKilometersFrom')
            ->setParameter('countKilometersFrom', $countKilometersFrom)

            ->andWhere('orderEntity.storeBranchToClientDistance <= :countKilometersTo')
            ->setParameter('countKilometersTo', $countKilometersTo)

            ->getQuery()
            ->getResult();
    }

    /**
     * Get cancelled orders, by store at 'in store' state, count according to specific captain and dates
     */
    public function getCancelledOrdersCountByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->createQueryBuilder('orderEntity')

            ->select('count(orderEntity.id)')

            ->where('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_CANCEL)

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $captainProfileId)

            ->andWhere('orderEntity.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)

            ->andWhere('orderEntity.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->andWhere('orderEntity.orderCancelledByUserAndAtState IN (:orderCancelledByUserAndAtStateArray)')
            ->setParameter('orderCancelledByUserAndAtStateArray', OrderCancelledByUserAndAtStateConstant::ORDER_CANCEL_USER_AND_STATE_ARRAY)

            ->getQuery()
            ->getSingleColumnResult();
    }

    /**
     * Get cancelled orders, by store at 'in store' state, count and which storeBranchToClientDistance or
     * kilometer is more than 19 kilometer and according to specific captain and dates
     */
    public function getOverdueCancelledOrdersByCaptainProfileIdAndBetweenTwoDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->createQueryBuilder('orderEntity')

            ->select('count(orderEntity.id)')

            ->where('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_CANCEL)

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $captainProfileId)

            ->andWhere('orderEntity.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)

            ->andWhere('orderEntity.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->andWhere('(orderEntity.storeBranchToClientDistance IS NOT NULL AND orderEntity.storeBranchToClientDistance >= :limitDistance) '
                .'OR (orderEntity.storeBranchToClientDistance IS NULL AND orderEntity.kilometer >= :limitDistance)')
            ->setParameter('limitDistance', CaptainFinancialSystem::KILOMETER_TO_DOUBLE_ORDER)

            ->andWhere('orderEntity.orderCancelledByUserAndAtState IN (:orderCancelledByUserAndAtStateArray)')
            ->setParameter('orderCancelledByUserAndAtStateArray', OrderCancelledByUserAndAtStateConstant::ORDER_CANCEL_USER_AND_STATE_ARRAY)

            ->getQuery()
            ->getSingleColumnResult();
    }

    /**
     * Get count of orders without distance and cancelled by store and related to specific captain during specific time
     */
    public function getCancelledOrdersWithoutDistanceCountByCaptainProfileIdOnSpecificDate(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->createQueryBuilder('orderEntity')

            ->select('COUNT(orderEntity.id)')

            ->where('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_CANCEL)

            ->andWhere('orderEntity.orderCancelledByUserAndAtState IN (:orderCancelledByUserAndAtStateArray)')
            ->setParameter('orderCancelledByUserAndAtStateArray', OrderCancelledByUserAndAtStateConstant::ORDER_CANCEL_USER_AND_STATE_ARRAY)

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $captainProfileId)

            ->andWhere('orderEntity.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)

            ->andWhere('orderEntity.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->andWhere('orderEntity.storeBranchToClientDistance IS NULL OR orderEntity.storeBranchToClientDistance = :zeroValue')
            ->setParameter('zeroValue', 0)

            ->getQuery()
            ->getSingleColumnResult();
    }

    public function getCancelledOrdersCountByCaptainProfileIdAndSpecificDateAndSpecificDistanceRange(int $captainId, string $fromDate, string $toDate, float $countKilometersFrom, float $countKilometersTo): array
    {
        return $this->createQueryBuilder('orderEntity')

            ->select('count(orderEntity.id) as countOrder')

            ->where('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_CANCEL)

            ->andWhere('orderEntity.orderCancelledByUserAndAtState IN (:orderCancelledByUserAndAtStateArray)')
            ->setParameter('orderCancelledByUserAndAtStateArray', OrderCancelledByUserAndAtStateConstant::ORDER_CANCEL_USER_AND_STATE_ARRAY)

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $captainId)

            ->andWhere('orderEntity.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)

            ->andWhere('orderEntity.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->andWhere('orderEntity.storeBranchToClientDistance >= :countKilometersFrom')
            ->setParameter('countKilometersFrom', $countKilometersFrom)

            ->andWhere('orderEntity.storeBranchToClientDistance <= :countKilometersTo')
            ->setParameter('countKilometersTo', $countKilometersTo)

            ->andWhere('orderEntity.storeBranchToClientDistance != :zero')
            ->setParameter('zero', 0)

            ->getQuery()
            ->getOneOrNullResult();
    }

    /**
     * Get cancelled orders, by store at 'in store' state, count and which storeBranchToClientDistance is more
     * than 19 kilometer and according to specific captain and dates
     */
    public function getCancelledAndOverdueStoreBranchToClientDistanceOrdersCountByCaptainProfileIdAndDates(int $captainProfileId, string $fromDate, string $toDate): array
    {
        return $this->createQueryBuilder('orderEntity')

            ->select('count(orderEntity.id)')

            ->where('orderEntity.state = :state')
            ->setParameter('state', OrderStateConstant::ORDER_STATE_CANCEL)

            ->andWhere('orderEntity.captainId = :captainId')
            ->setParameter('captainId', $captainProfileId)

            ->andWhere('orderEntity.createdAt >= :fromDate')
            ->setParameter('fromDate', $fromDate)

            ->andWhere('orderEntity.createdAt <= :toDate')
            ->setParameter('toDate', $toDate)

            ->andWhere('(orderEntity.storeBranchToClientDistance IS NOT NULL'
                .' AND orderEntity.storeBranchToClientDistance >= :limitDistance)')
            ->setParameter('limitDistance', CaptainFinancialSystem::KILOMETER_TO_DOUBLE_ORDER)

            ->andWhere('orderEntity.orderCancelledByUserAndAtState IN (:orderCancelledByUserAndAtStateArray)')
            ->setParameter('orderCancelledByUserAndAtStateArray', OrderCancelledByUserAndAtStateConstant::ORDER_CANCEL_USER_AND_STATE_ARRAY)

            ->getQuery()
            ->getSingleColumnResult();
    }

    /**
     * Gets last five delivered orders with captains' images
     */
    public function getLastDeliveredOrdersWithCaptainProfileImage(): array
    {
        return $this->createQueryBuilder('orderEntity')

            ->addSelect('imageEntity.imagePath as captainProfileImage')

            ->andWhere('orderEntity.state = :deliveredState')
            ->setParameter('deliveredState', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->leftJoin(
                CaptainEntity::class,
                'captainEntity',
                Join::WITH,
                'captainEntity.id = orderEntity.captainId'
            )

            ->leftJoin(
                ImageEntity::class,
                'imageEntity',
                Join::WITH,
                'imageEntity.itemId = captainEntity.id and imageEntity.entityType = :entityType and imageEntity.usedAs = :usedAs'
            )

            ->setParameter('entityType', ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE)
            ->setParameter('usedAs', ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE)

            ->orderBy('orderEntity.id', 'DESC')
            ->setMaxResults(5)

            ->getQuery()
            ->getResult();
    }

    /**
     * Get the count of delivered orders according to dates and a specific store's branch
     */
    public function getDeliveredOrdersCountBetweenTwoDatesAndByStoreBranchId(int $storeBranchId, DateTime $fromDate, DateTime $toDate): array
    {
        return $this->createQueryBuilder('orderEntity')
            ->select('COUNT(orderEntity.id)')

            ->andWhere('orderEntity.state = :deliveredState')
            ->setParameter('deliveredState', OrderStateConstant::ORDER_STATE_DELIVERED)

            ->leftJoin(
                StoreOrderDetailsEntity::class,
                'storeOrderDetailsEntity',
                Join::WITH,
                'storeOrderDetailsEntity.orderId = orderEntity.id'
            )

            ->leftJoin(
                StoreOwnerBranchEntity::class,
                'storeOwnerBranchEntity',
                Join::WITH,
                'storeOwnerBranchEntity.id = storeOrderDetailsEntity.branch'
            )

            ->andWhere('storeOwnerBranchEntity.id = :storeBranchId')
            ->setParameter('storeBranchId', $storeBranchId)

            ->andWhere('orderEntity.createdAt BETWEEN :currentMonthStartDate AND :currentMonthEndDate')
            ->setParameter('currentMonthStartDate', $fromDate)
            ->setParameter('currentMonthEndDate', $toDate)

            ->getQuery()
            ->getSingleColumnResult();
    }

    /**
     * Filter array of orders entities by two dates and a customized timezone
     */
    public function filterOrdersEntitiesByDates(array $tempOrders, DateTime $fromDate, DateTime $toDate, ?string $timeZone): array
    {
        $filteredOrders = [];

        if (count($tempOrders) > 0) {
            foreach ($tempOrders as $key => $value) {
                if (($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) >=
                        new \DateTime(($fromDate)->format('Y-m-d 00:00:00')))
                    && ($value->getCreatedAt()->setTimeZone(new \DateTimeZone($timeZone ? : 'UTC')) <=
                        new \DateTime(($toDate)->format('Y-m-d 23:59:59')))) {
                    $filteredOrders[$key] = $value;
                }
            }
        }

        return $filteredOrders;
    }
}
