<?php

namespace App\Service\ChatRoom;

use App\AutoMapping;
use App\Entity\ChatRoomEntity;
use App\Manager\ChatRoom\ChatRoomManager;
use App\Request\ChatRoom\ChatRoomCreateRequest;
use App\Response\ChatRoom\ChatRoomResponse;

class ChatRoomService
{
    private AutoMapping $autoMapping;
    private ChatRoomManager $chatRoomManager;

    public function __construct(AutoMapping $autoMapping, ChatRoomManager $chatRoomManager)
    {
        $this->autoMapping = $autoMapping;
        $this->chatRoomManager = $chatRoomManager;
    }

    public function getChatRoom(int $userId): ?ChatRoomResponse
    {
        $chatRoom = $this->chatRoomManager->getChatRoom($userId);
        
        $response = $this->autoMapping->map(ChatRoomEntity::class, ChatRoomResponse::class, $chatRoom);
      
        $response->roomId = $chatRoom->getRoomId()->toBase32();

        return $response;
    }
}
