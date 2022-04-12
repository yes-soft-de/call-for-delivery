<?php

namespace App\Service\ChatRoom;

use App\AutoMapping;
use App\Entity\ChatRoomEntity;
use App\Manager\ChatRoom\ChatRoomManager;
use App\Response\ChatRoom\ChatRoomCaptainResponse;
use App\Response\ChatRoom\ChatRoomResponse;
use App\Response\ChatRoom\ChatRoomsStoreResponse;
use App\Response\ChatRoom\ChatRoomSupplierResponse;
use App\Service\FileUpload\UploadFileHelperService;
use App\Service\Image\ImageService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class ChatRoomService
{
    private AutoMapping $autoMapping;
    private ChatRoomManager $chatRoomManager;
    private string $params;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, ChatRoomManager $chatRoomManager, ParameterBagInterface $params, UploadFileHelperService $uploadFileHelperService)
    {
        $this->params = $params->get('upload_base_url') . '/';
        $this->autoMapping = $autoMapping;
        $this->chatRoomManager = $chatRoomManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
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
        $response = [];
         
        $chatRooms = $this->chatRoomManager->getChatRoomsWithStores();
        foreach($chatRooms as $chatRoom) {
        
            $chatRoom['roomId'] = $chatRoom['roomId']->toBase32();
            $chatRoom['images'] = $this->getImageParams($chatRoom['images'], $this->params.$chatRoom['images'], $this->params);
         
            $response[] = $this->autoMapping->map("array", ChatRoomsStoreResponse::class, $chatRoom);
        }

        return $response;
    }

    public function getChatRoomsWithCaptains(): array
    {
        $response = [];

        $chatRooms = $this->chatRoomManager->getChatRoomsWithCaptains();
        
        foreach($chatRooms as $chatRoom) {
            $chatRoom['roomId'] = $chatRoom['roomId']->toBase32();

            $chatRoom['images'] = $this->uploadFileHelperService->getImageParams($chatRoom['imagePath']);

            $response[] = $this->autoMapping->map("array", ChatRoomCaptainResponse::class, $chatRoom);
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

    public function getChatRoomsWithSuppliers(): array
    {
        $response = [];

        $chatRooms = $this->chatRoomManager->getChatRoomsWithSuppliers();

        foreach($chatRooms as $chatRoom) {
            $chatRoom['roomId'] = $chatRoom['roomId']->toBase32();

            $chatRoom['images'] = $this->uploadFileHelperService->getImageParams($chatRoom['imagePath']);

            $response[] = $this->autoMapping->map("array", ChatRoomSupplierResponse::class, $chatRoom);
        }

        return $response;
    }
}
