<?php

namespace App\Manager\ChatRoom;

use App\AutoMapping;
use App\Entity\ChatRoomEntity;
use App\Repository\ChatRoomEntityRepository;
use App\Request\ChatRoom\ChatRoomCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use DateTime;
use Symfony\Component\Uid\Uuid;

class ChatRoomManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private ChatRoomEntityRepository $chatRoomRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ChatRoomEntityRepository $chatRoomRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->chatRoomRepository = $chatRoomRepository;
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
}
