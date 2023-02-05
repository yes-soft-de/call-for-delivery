<?php

namespace App\Manager\ChatRoom;

use App\AutoMapping;
use App\Constant\ChatRoom\ChatRoomResultConstant;
use App\Entity\ChatRoomEntity;
use App\Repository\ChatRoomEntityRepository;
use App\Request\ChatRoom\ChatRoomCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use DateTime;
use Symfony\Component\Uid\Uuid;

class ChatRoomManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private ChatRoomEntityRepository $chatRoomRepository
    )
    {
    }

    /**
     * @param ChatRoomCreateRequest $request
     * @return ChatRoomEntity
     */
    public function create(ChatRoomCreateRequest $request): ChatRoomEntity
    {
        $uuid = Uuid::v4();

        $chatRoom = $this->autoMapping->map(ChatRoomCreateRequest::class, ChatRoomEntity::class, $request);

        $chatRoom->setRoomId($uuid);
        $chatRoom->setCreatedAt(new DateTime());

        $this->entityManager->persist($chatRoom);
        $this->entityManager->flush();

        return $chatRoom;
    }

    public function createChatRoom(int $userId, int $usedAs): ChatRoomEntity
    { 
        $request = new ChatRoomCreateRequest();
     
        $request->setUserId($userId);
        $request->setUsedAs($usedAs);

        return $this->create($request);
    }

    public function getChatRoom(int $userId): ?ChatRoomEntity
    { 
        return $this->chatRoomRepository->findOneBy(["userId" => $userId]);
    }

    public function getChatRoomsWithStores(): ?array
    { 
        return $this->chatRoomRepository->getChatRoomsWithStores();
    }

    public function getChatRoomsWithCaptains(): ?array
    {
        return $this->chatRoomRepository->getChatRoomsWithCaptains();
    }

    public function getChatRoomsWithSuppliers(): ?array
    {
        return $this->chatRoomRepository->getChatRoomsWithSuppliers();
    }

    public function deleteChatRoomByUserId(int $userId): ChatRoomEntity|int
    {
        $chatRoom = $this->chatRoomRepository->findOneBy(['userId' => $userId]);

        if (! $chatRoom) {
            return ChatRoomResultConstant::CHAT_ROOM_DOES_NOT_EXIST_CONST;
        }

        $this->entityManager->remove($chatRoom);
        $this->entityManager->flush();

        return $chatRoom;
    }
}
