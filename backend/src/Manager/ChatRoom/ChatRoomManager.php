<?php

namespace App\Manager\ChatRoom;

use App\AutoMapping;
use App\Entity\ChatRoomEntity;
use App\Repository\ChatRoomEntityRepository;
use App\Request\ChatRoom\ChatRoomCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use DateTime;
use App\Constant\ChatRoom\ChatRoomConstant;

class ChatRoomManager
{
    public function __construct(private AutoMapping $autoMapping, private EntityManagerInterface $entityManager, private ChatRoomEntityRepository $chatRoomRepository)
    {
    }

    /**
     * @param ChatRoomCreateRequest $request
     */
    public function create(ChatRoomCreateRequest $request): ChatRoomEntity
    {       
        $chatRoom = $this->autoMapping->map(ChatRoomCreateRequest::class, ChatRoomEntity::class, $request);

        $chatRoom->setCreatedAt(new DateTime());
        $chatRoom->setUsedAs(ChatRoomConstant::ADMIN_USER);

        $this->entityManager->persist($chatRoom);
        $this->entityManager->flush();

        return $chatRoom;
    }

    /**
     * @param $userId
     */
    public function createChatRoom($userId)
    { 
        $request = new ChatRoomCreateRequest();
        $request->setUserId($userId);

        return $this->create($request);
    }
}
