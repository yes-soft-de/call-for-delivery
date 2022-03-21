<?php

namespace App\Manager\ChatRoom;

use App\AutoMapping;
use App\Entity\OrderChatRoomEntity;
use App\Repository\OrderChatRoomEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use DateTime;
use Symfony\Component\Uid\Uuid;

class OrderChatRoomManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private OrderChatRoomEntityRepository $orderChatRoomRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, OrderChatRoomEntityRepository $orderChatRoomRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->orderChatRoomRepository = $orderChatRoomRepository;
    }

    public function getOrderChatRoomsForStoreBeforeOrderAccepted(int $userId): ?array
    { 
        return $this->orderChatRoomRepository->getOrderChatRoomsForStoreBeforeOrderAccepted($userId);
    }
}
