<?php

namespace App\Service\ChatRoom;

use App\AutoMapping;
use App\Manager\ChatRoom\OrderChatRoomManager;
use App\Response\ChatRoom\OrderChatRoomsStoreResponse;
use App\Service\FileUpload\UploadFileHelperService;
use App\Constant\ChatRoom\ChatRoomConstant;

class OrderChatRoomService
{
    private AutoMapping $autoMapping;
    private OrderChatRoomManager $orderChatRoomManager;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, OrderChatRoomManager $orderChatRoomManager, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->uploadFileHelperService = $uploadFileHelperService;
        $this->orderChatRoomManager = $orderChatRoomManager;
    }

    public function getOrderChatRoomsForStoreBeforeOrderAccepted(int $userId): ?array
    {
        $response = [];
        $orderChatRooms = $this->orderChatRoomManager->getOrderChatRoomsForStoreBeforeOrderAccepted($userId);
       
        foreach($orderChatRooms as $orderChatRoom) {
          
            if($orderChatRoom['usedAs'] === ChatRoomConstant::CAPTAIN_STORE_ENQUIRE) {
                $orderChatRoom['usedAs'] = ChatRoomConstant::CAPTAIN_ENQUIRE;
            }

            $orderChatRoom['roomId'] = $orderChatRoom['roomId']->toBase32();
            $orderChatRoom['images'] = $this->uploadFileHelperService->getImageParams($orderChatRoom['imagePath']);
          
            $response[] = $this->autoMapping->map("array", OrderChatRoomsStoreResponse::class, $orderChatRoom);
        }
        
        return $response;
    }
}
