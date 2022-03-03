<?php

namespace App\Service\ChatRoom;

use App\AutoMapping;
use App\Entity\ChatRoomEntity;
use App\Manager\ChatRoom\ChatRoomManager;
use App\Request\ChatRoom\ChatRoomCreateRequest;
use App\Response\ChatRoom\ChatRoomResponse;

class ChatRoomService
{
    public function __construct(private AutoMapping $autoMapping, private ChatRoomManager $chatRoomManager)
    {
    }

    /**
     * @param ChatRoomCreateRequest $request
     * @return ChatRoomResponse
     */
    public function createChatRoom(ChatRoomCreateRequest $request): ChatRoomResponse
    {
        $order = $this->chatRoomManager->createChatRoom($request);
        
        return $this->autoMapping->map(ChatRoomEntity::class, ChatRoomResponse::class, $order);
    }
}
