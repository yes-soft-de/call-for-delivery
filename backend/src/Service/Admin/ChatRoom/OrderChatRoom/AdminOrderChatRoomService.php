<?php

namespace App\Service\Admin\ChatRoom\OrderChatRoom;

use App\Manager\Admin\ChatRoom\OrderChatRoom\AdminOrderChatRoomManager;

class AdminOrderChatRoomService
{
    public function __construct(
        private AdminOrderChatRoomManager $adminOrderChatRoomManager
    )
    {
    }

    public function deleteChatRoomByOrderId(int $orderId): int|array
    {
        return $this->adminOrderChatRoomManager->deleteChatRoomByOrderId($orderId);
    }
}
