<?php

namespace App\Manager\SuperAdmin\User;

use App\Constant\ChatRoom\ChatRoomConstant;
use App\Repository\CaptainEntityRepository;
use App\Repository\ChatRoomEntityRepository;
use App\Repository\StoreOwnerProfileEntityRepository;
use App\Repository\UserEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class SuperAdminUserControlManager
{
    private EntityManagerInterface $entityManager;
    private StoreOwnerProfileEntityRepository $storeOwnerProfileEntityRepository;
    private ChatRoomEntityRepository $chatRoomEntityRepository;
    private CaptainEntityRepository $captainEntityRepository;
    private UserEntityRepository $userEntityRepository;

    public function __construct(EntityManagerInterface $entityManager, StoreOwnerProfileEntityRepository $storeOwnerProfileEntityRepository, ChatRoomEntityRepository $chatRoomEntityRepository,
                                CaptainEntityRepository $captainEntityRepository, UserEntityRepository $userEntityRepository)
    {
        $this->entityManager = $entityManager;
        $this->storeOwnerProfileEntityRepository = $storeOwnerProfileEntityRepository;
        $this->chatRoomEntityRepository = $chatRoomEntityRepository;
        $this->captainEntityRepository = $captainEntityRepository;
        $this->userEntityRepository = $userEntityRepository;
    }

    // This function updates createdAt field for all store owners profiles depending on createdAt field for chatRoom
    public function updateCreatedAtForAllStoreOwnersProfilesBySuperAdmin(): array
    {
        $storeOwnersProfiles = $this->storeOwnerProfileEntityRepository->findAll();

        if (! empty($storeOwnersProfiles)) {
            foreach ($storeOwnersProfiles as $storeOwnerProfile) {
                $user = $this->userEntityRepository->findOneBy(['id'=>$storeOwnerProfile->getStoreOwnerId()]);

                $chatRoom = $this->chatRoomEntityRepository->findOneBy(['userId'=>$storeOwnerProfile->getStoreOwnerId(), 'usedAs'=>ChatRoomConstant::ADMIN_STORE]);

                if ($chatRoom !== null) {
                    $storeOwnerProfile->setCreatedAt($chatRoom->getCreatedAt());
                    $user->setCreatedAt($chatRoom->getCreatedAt());

                    $this->entityManager->flush();
                }
            }
        }

        return $storeOwnersProfiles;
    }

    // This function updates createdAt field for all captains profiles depending on createdAt field for chatRoom
    public function updateCreatedAtForAllCaptainsProfilesBySuperAdmin(): array
    {
        $captainsProfiles = $this->captainEntityRepository->findAll();

        if (! empty($captainsProfiles)) {
            foreach ($captainsProfiles as $captainProfile) {
                $user = $this->userEntityRepository->findOneBy(['id'=>$captainProfile->getCaptainId()]);

                $chatRoom = $this->chatRoomEntityRepository->findOneBy(['userId'=>$captainProfile->getCaptainId(), 'usedAs'=>ChatRoomConstant::ADMIN_CAPTAIN]);

                if ($chatRoom !== null) {
                    $captainProfile->setCreatedAt($chatRoom->getCreatedAt());
                    $user->setCreatedAt($chatRoom->getCreatedAt());

                    $this->entityManager->flush();
                }
            }
        }

        return $captainsProfiles;
    }
}
