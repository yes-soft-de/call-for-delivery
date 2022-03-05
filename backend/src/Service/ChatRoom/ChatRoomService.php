<?php

namespace App\Service\ChatRoom;

use App\AutoMapping;
use App\Entity\ChatRoomEntity;
use App\Manager\ChatRoom\ChatRoomManager;
use App\Request\ChatRoom\ChatRoomCreateRequest;
use App\Response\ChatRoom\ChatRoomResponse;

class ChatRoomService
{
    private $autoMapping;
    private $chatRoomManager;

    public function __construct(AutoMapping $autoMapping, ChatRoomManager $chatRoomManager)
    {
        $this->autoMapping = $autoMapping;
        $this->chatRoomManager = $chatRoomManager;
    }

    /**
     * @param ChatRoomCreateRequest $request
     * @return ChatRoomResponse
     */
    public function createChatRoom(ChatRoomCreateRequest $request): ChatRoomResponse
    {
        $chatRoom = $this->chatRoomManager->createChatRoom($request);
        
        return $this->autoMapping->map(ChatRoomEntity::class, ChatRoomResponse::class, $chatRoom);
    }

    /**
     * @param $userId
     * @return ChatRoomResponse|null
     */
    public function getChatRoom($userId): ?ChatRoomResponse
    {
        $chatRoom = $this->chatRoomManager->getChatRoom($userId);
        
        $response = $this->autoMapping->map(ChatRoomEntity::class, ChatRoomResponse::class, $chatRoom);
      
        $response->roomId = $chatRoom->getRoomId()->toBase32();

        return $response;
    }
}
