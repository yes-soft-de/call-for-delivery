<?php

namespace App\Manager\ChatRoom;

use App\AutoMapping;
use App\Constant\Order\OrderTypeConstant;
use App\Entity\OrderChatRoomEntity;
use App\Entity\OrderEntity;
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
        $captain = $this->captainManager->getCaptainProfileByUserId($request->getUserId());

        $orderChatRoom = $this->orderChatRoomRepository->findOneBy(["orderId" => $request->getOrderId(), "captain" => $captain,
            "usedAs"=>[ChatRoomConstant::CAPTAIN_STORE, ChatRoomConstant::CAPTAIN_STORE_ENQUIRE]]);
      
        if(! $orderChatRoom) {
           return $this->create($request);
        }
       
        return $orderChatRoom;
    }

    public function createOrderChatRoomOrUpdateCurrent(OrderEntity $order): ?OrderChatRoomEntity
    {
        $orderChatRoom = $this->orderChatRoomRepository->findOneBy(["orderId" => $order->getId(), "captain" => $order->getCaptainId(),
            "usedAs"=>[ChatRoomConstant::CAPTAIN_STORE, ChatRoomConstant::CAPTAIN_STORE_ENQUIRE]]);
       
        if (! $orderChatRoom) {
            if ($order->getOrderType() === OrderTypeConstant::ORDER_TYPE_BID) {
                // if the order is of type bid, then create a chat room id between captain and supplier
                $this->createOrderChatRoomBetweenCaptainAndSupplier($order);
            }

           return  $this->createOrderChatRoomBetWeenCaptainAndStore($order);
        }

        if ($order->getOrderType() === OrderTypeConstant::ORDER_TYPE_NORMAL) {
            return $this->updateUsedAs($orderChatRoom);
        }
    }

    public function updateUsedAs(OrderChatRoomEntity $orderChatRoom): ?OrderChatRoomEntity
    {
        $orderChatRoom = $orderChatRoom->setUsedAs(ChatRoomConstant::CAPTAIN_STORE);
       
        $this->entityManager->flush();

        return $orderChatRoom;
    }

    public function createOrderChatRoomBetWeenCaptainAndStore(OrderEntity $order): ?OrderChatRoomEntity
    {
       $request = new OrderChatRoomRequest();
      
       $request->setOrderId($order->getId());
       $request->setUsedAs(ChatRoomConstant::CAPTAIN_STORE);
       $request->setUserId($order->getCaptainId()->getCaptainId());

       return $this->create($request);
    }

    public function create(OrderChatRoomRequest $request): ?OrderChatRoomEntity
    {
        $uuid = Uuid::v4();

        $orderChatRoom = $this->autoMapping->map(OrderChatRoomRequest::class, OrderChatRoomEntity::class, $request);
    
        $orderChatRoom->setCaptain($this->captainManager->getCaptainProfileByUserId($request->getUserId()));
        $orderChatRoom->setOrderId($this->orderManager->getOrderById($request->getOrderId()));
        $orderChatRoom->setRoomId($uuid);
    
        $this->entityManager->persist($orderChatRoom);
        $this->entityManager->flush();    

        return $orderChatRoom;
    }

    public function createOrderChatRoomBetweenCaptainAndSupplier(OrderEntity $order): ?OrderChatRoomEntity
    {
        $request = new OrderChatRoomRequest();

        $request->setOrderId($order->getId());
        $request->setUsedAs(ChatRoomConstant::CAPTAIN_SUPPLIER);
        $request->setUserId($order->getCaptainId()->getCaptainId());

        return $this->create($request);
    }

    public function deleteOrderChatRoomEntitiesByCaptainId(int $captainId): array
    {
        $orderChatRoomEntities = $this->orderChatRoomRepository->getOrderChatRoomEntitiesByCaptainId($captainId);

        if (! empty($orderChatRoomEntities)) {
            foreach ($orderChatRoomEntities as $orderChatRoomEntity) {
                $this->entityManager->remove($orderChatRoomEntity);
                $this->entityManager->flush();
            }
        }

        return $orderChatRoomEntities;
    }

    public function getOrderIdByRoomId(string $roomId): ?array
    {
       return $this->orderChatRoomRepository->getOrderIdByRoomId($roomId);
    }
}
