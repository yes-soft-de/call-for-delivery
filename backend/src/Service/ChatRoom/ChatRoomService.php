<?php

namespace App\Service\ChatRoom;

use App\AutoMapping;
use App\Entity\ChatRoomEntity;
use App\Manager\ChatRoom\ChatRoomManager;
use App\Response\ChatRoom\ChatRoomResponse;
use App\Response\ChatRoom\ChatRoomsStoreResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class ChatRoomService
{
    private AutoMapping $autoMapping;
    private ChatRoomManager $chatRoomManager;
    private string $params;

    public function __construct(AutoMapping $autoMapping, ChatRoomManager $chatRoomManager, ParameterBagInterface $params)
    {
        $this->params = $params->get('upload_base_url') . '/';
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

    public function getChatRoomsWithStores(): ?array 
    {
        $chatRooms = $this->chatRoomManager->getChatRoomsWithStores();
        foreach($chatRooms as $chatRoom) {
        
            $chatRoom['roomId'] = $chatRoom['roomId']->toBase32();
            $chatRoom['images'] = $this->getImageParams($chatRoom['images'], $this->params.$chatRoom['images'], $this->params);
         
            $response[] = $this->autoMapping->map("array", ChatRoomsStoreResponse::class, $chatRoom);
        }

        return $response;
    }

    public function getImageParams($imageURL, $image, $baseURL): array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }
}
