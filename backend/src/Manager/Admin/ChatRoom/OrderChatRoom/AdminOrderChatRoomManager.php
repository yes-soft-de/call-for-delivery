<?php

namespace App\Manager\Admin\ChatRoom\OrderChatRoom;

use App\Constant\ChatRoom\OrderChatRoomConstant;
use App\Repository\OrderChatRoomEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class AdminOrderChatRoomManager
{
    public function __construct(
        private EntityManagerInterface $entityManager,
    private OrderChatRoomEntityRepository $orderChatRoomRepository
    )
    {
    }

    public function deleteChatRoomByOrderId(int $orderId): int|array
    {
        $chatRoomResults = $this->orderChatRoomRepository->findBy(['orderId' => $orderId]);

        if (count($chatRoomResults) === 0) {
            return OrderChatRoomConstant::ORDER_CHAT_ROOM_NOT_EXIST_CONST;
        }

        foreach ($chatRoomResults as $chatRoom) {
            $this->entityManager->remove($chatRoom);

            $this->entityManager->flush();
        }

        return $chatRoomResults;
    }
}
