<?php

namespace App\Manager\Admin\Order;

use App\Constant\Order\OrderStateConstant;
use App\Entity\OrderEntity;
use App\Repository\OrderEntityRepository;
use App\Request\Admin\Order\CaptainNotArrivedOrderFilterByAdminRequest;
use App\Request\Admin\Order\OrderFilterByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminOrderManager
{
    private EntityManagerInterface $entityManager;
    private OrderEntityRepository $orderEntityRepository;

    public function __construct(EntityManagerInterface $entityManager, OrderEntityRepository $orderEntityRepository)
    {
        $this->entityManager = $entityManager;
        $this->orderEntityRepository = $orderEntityRepository;
    }

    public function getOrdersByStateForAdmin(string $state): int
    {
        return $this->orderEntityRepository->count(["state" => $state]);
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

        $this->entityManager->flush();

        return $orderEntity;
    }
}
