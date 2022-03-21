<?php

namespace App\Manager\ChatRoom;

use App\AutoMapping;
use App\Entity\OrderChatRoomEntity;
use App\Repository\OrderChatRoomEntityRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Uid\Uuid;
use App\Request\ChatRoom\OrderChatRoomRequest;
use App\Manager\Order\OrderManager;
use App\Manager\Captain\CaptainManager;
use App\Constant\ChatRoom\ChatRoomConstant;

class OrderChatRoomManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private OrderChatRoomEntityRepository $orderChatRoomRepository;
    private OrderManager $orderManager;
    private CaptainManager $captainManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, OrderChatRoomEntityRepository $orderChatRoomRepository, OrderManager $orderManager, CaptainManager $captainManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->orderChatRoomRepository = $orderChatRoomRepository;
        $this->orderManager = $orderManager;
        $this->captainManager = $captainManager;
    }

    public function getOrderChatRoomsForStoreBeforeOrderAccepted(int $userId): ?array
    { 
        return $this->orderChatRoomRepository->getOrderChatRoomsForStoreBeforeOrderAccepted($userId);
    }

    public function createNewOrderChatRoom(OrderChatRoomRequest $request): ?OrderChatRoomEntity
    {
        $uuid = Uuid::v4();

        $chatRoom = $this->autoMapping->map(OrderChatRoomRequest::class, OrderChatRoomEntity::class, $request);

        $chatRoom->setCaptain($this->captainManager->getCaptainProfileByUserId($request->getUserId()));
        $chatRoom->setOrderId($this->orderManager->getOrderById($request->getOrderId()));
        $chatRoom->setRoomId($uuid);
        $chatRoom->setUsedAs(ChatRoomConstant::CAPTAIN_STORE_ENQUIRE);

        $this->entityManager->persist($chatRoom);
        $this->entityManager->flush();

        return $chatRoom;
    }
}
