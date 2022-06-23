<?php

namespace App\Manager\Admin\Order;

use App\Constant\Order\OrderStateConstant;
use App\Constant\Order\OrderTypeConstant;
use App\Entity\OrderEntity;
use App\Repository\OrderEntityRepository;
use App\Request\Admin\Order\CaptainNotArrivedOrderFilterByAdminRequest;
use App\Request\Admin\Order\OrderCreateByAdminRequest;
use App\Request\Admin\Order\OrderFilterByAdminRequest;
use DateTime;
use Doctrine\ORM\EntityManagerInterface;
use App\Constant\Order\OrderIsHideConstant;
use App\Constant\Order\OrderResultConstant;
use App\Request\Admin\Order\UpdateOrderByAdminRequest;
use App\AutoMapping;
use App\Manager\Admin\Order\AdminStoreOrderDetailsManager;

class AdminOrderManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private OrderEntityRepository $orderEntityRepository;
    private AdminStoreOrderDetailsManager $adminStoreOrderDetailsManager;

    public function __construct(EntityManagerInterface $entityManager, OrderEntityRepository $orderEntityRepository, AutoMapping $autoMapping, AdminStoreOrderDetailsManager $adminStoreOrderDetailsManager)
    {
        $this->entityManager = $entityManager;
        $this->orderEntityRepository = $orderEntityRepository;
        $this->autoMapping = $autoMapping;
        $this->adminStoreOrderDetailsManager = $adminStoreOrderDetailsManager;
    }

    public function getCountOrderOngoingForAdmin(): int
    {
        return $this->orderEntityRepository->getCountOrderOngoingForAdmin();
    }

    public function getAllOrdersCountForAdmin(): int
    {
        return count($this->orderEntityRepository->findAll());
    }

    public function filterStoreOrdersByAdmin(OrderFilterByAdminRequest $request): ?array
    {
        return $this->orderEntityRepository->filterStoreOrdersByAdmin($request);
    }

    public function getSpecificOrderByIdForAdmin(int $id): ?array
    {
        return $this->orderEntityRepository->getSpecificOrderByIdForAdmin($id);
    }

    // This function filters only orders in which the captain does not arrive the store yet
    public function filterCaptainNotArrivedOrdersByAdmin(CaptainNotArrivedOrderFilterByAdminRequest $request): ?array
    {
        return $this->orderEntityRepository->filterCaptainNotArrivedOrdersByAdmin($request);
    }

    public function filterStoreBidOrdersByAdmin(OrderFilterByAdminRequest $request): ?array
    {
        return $this->orderEntityRepository->filterStoreBidOrdersByAdmin($request);
    }

    public function getSpecificBidOrderByIdForAdmin(int $id): ?array
    {
        return $this->orderEntityRepository->getSpecificBidOrderByIdForAdmin($id);
    }
     
    public function getPendingOrdersForAdmin(): ?array
    {
        return $this->orderEntityRepository->getPendingOrdersForAdmin();
    }

    public function getHiddenOrdersForAdmin(): ?array
    {
        return $this->orderEntityRepository->getHiddenOrdersForAdmin();
    }

    /**
     * Not delivered orders are all orders which status = on way to pick order, in store, picked, or on going
     */
    public function getNotDeliveredOrdersForAdmin(): ?array
    {
        return $this->orderEntityRepository->getNotDeliveredOrdersForAdmin();
    }

    public function getOrderByIdForAdmin(int $orderId): ?OrderEntity
    {
        return $this->orderEntityRepository->find($orderId);
    }

    // This function updates the order info according to be become a pending orders
    public function returnOrderToPendingStatus(OrderEntity $orderEntity): OrderEntity
    {
        $orderEntity->setState(OrderStateConstant::ORDER_STATE_PENDING);
        $orderEntity->setCaptainId(null);
        $orderEntity->setDateCaptainArrived(null);
        $orderEntity->setIsCaptainArrived(false);
        $orderEntity->setUpdatedAt(new DateTime('now'));

        $this->entityManager->flush();

        return $orderEntity;
    }

    public function getPendingOrdersCountForAdmin(): int
    {
        return $this->orderEntityRepository->getPendingOrdersCountForAdmin();
    }

    public function getDeliveredOrdersCountBetweenTwoDatesForAdmin(DateTime $fromDate, DateTime $toDate): int
    {
        return $this->orderEntityRepository->getDeliveredOrdersCountBetweenTwoDatesForAdmin($fromDate, $toDate);
    }

    public function updateOrderToHidden(int $id): OrderEntity|string
    {
        $orderEntity = $this->orderEntityRepository->find($id);
        if(! $orderEntity) {
            return OrderResultConstant::ORDER_NOT_FOUND_RESULT;
        }

        $orderEntity->setIsHide(OrderIsHideConstant::ORDER_HIDE_EXCEEDING_DELIVERED_DATE);

        $this->entityManager->flush();

        return $orderEntity;
    }

    public function getOrderByIdWithStoreOrderDetailForAdmin(int $orderId): ?array
    {
        return $this->orderEntityRepository->getOrderByIdWithStoreOrderDetail($orderId);
    }

    public function orderUpdateByAdmin(UpdateOrderByAdminRequest $request): OrderEntity
    {
        $orderEntity = $this->orderEntityRepository->find($request->getId());

        $orderEntity->setIsHide(OrderIsHideConstant::ORDER_SHOW);

        $orderEntity = $this->autoMapping->mapToObject(UpdateOrderByAdminRequest::class, OrderEntity::class, $request, $orderEntity);
        $orderEntity->setDeliveryDate($request->getDeliveryDate());
        
        $this->entityManager->flush();

        $this->adminStoreOrderDetailsManager->updateOrderDetail($orderEntity, $request);
        
        return $orderEntity;
    }

    public function createOrderByAdmin(OrderCreateByAdminRequest $request): OrderEntity
    {
        $orderEntity = $this->autoMapping->map(OrderCreateByAdminRequest::class, OrderEntity::class, $request);

        $orderEntity->setDeliveryDate($orderEntity->getDeliveryDate());
        $orderEntity->setState(OrderStateConstant::ORDER_STATE_PENDING);
        $orderEntity->setOrderType(OrderTypeConstant::ORDER_TYPE_NORMAL);
        $orderEntity->setIsHide(OrderIsHideConstant::ORDER_SHOW);

        $this->entityManager->persist($orderEntity);
        $this->entityManager->flush();

        $this->adminStoreOrderDetailsManager->createOrderDetailsByAdmin($orderEntity, $request);

        return $orderEntity;
    }
}
