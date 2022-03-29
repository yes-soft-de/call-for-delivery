<?php

namespace App\Service\ChatRoom;

use App\AutoMapping;
use App\Manager\ChatRoom\OrderChatRoomManager;
use App\Response\ChatRoom\OrderChatRoomsStoreResponse;
use App\Response\ChatRoom\OrderChatRoomStoreCreateResponse;
use App\Service\FileUpload\UploadFileHelperService;
use App\Constant\ChatRoom\ChatRoomConstant;
use App\Request\ChatRoom\OrderChatRoomRequest;
use App\Entity\OrderChatRoomEntity;
use App\Entity\OrderEntity;

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

    public function createNewOrderChatRoom(OrderChatRoomRequest $request): ?OrderChatRoomStoreCreateResponse
    {
        $request->setUsedAs(ChatRoomConstant::CAPTAIN_STORE_ENQUIRE);
        
        $orderChatRoom = $this->orderChatRoomManager->createNewOrderChatRoom($request);

        $response = $this->autoMapping->map(OrderChatRoomEntity::class, OrderChatRoomStoreCreateResponse::class, $orderChatRoom);
        $response->roomId = $orderChatRoom->getRoomId()->toBase32();
        
        return $response;
    }

    public function createOrderChatRoomOrUpdateCurrent(OrderEntity $order): ?OrderChatRoomEntity
    {
        return $this->orderChatRoomManager->createOrderChatRoomOrUpdateCurrent($order);
    }
}
