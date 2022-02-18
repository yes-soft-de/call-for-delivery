<?php

namespace App\Manager\StoreOwner;

use App\AutoMapping;
use App\Entity\StoreOwnerProfileEntity;
use App\Repository\StoreOwnerProfileEntityRepository;
use App\Request\StoreOwner\StoreOwnerProfileUpdateRequest;
use App\Request\User\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\User\UserManager;

class StoreOwnerProfileManager
{
    private $autoMapping;
    private $entityManager;
    private $userManager;
    private $storeOwnerProfileEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserManager $userManager, StoreOwnerProfileEntityRepository $storeOwnerProfileEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->userManager = $userManager;
        $this->storeOwnerProfileEntityRepository = $storeOwnerProfileEntityRepository;
    }

    public function storeOwnerRegister(UserRegisterRequest $request): mixed
    {
        $user = $this->userManager->getUserByUserId($request->getUserId());

        if (!$user) {
            $request->setRoles(["ROLE_OWNER"]);

            $userRegister = $this->userManager->createUser($request);

            if ($userRegister) {
                return $this->createProfile($request, $userRegister);
            } else {
                return 'not created user';
            }
        } else {
            return $this->createProfileWithUserFound($user, $request);
        }
    }

    public function createProfile(UserRegisterRequest $request, $userRegister): mixed
    {
        $storeProfile = $this->storeOwnerProfileEntityRepository->getStoreProfileByStoreId($request->getUserID());

        if (!$storeProfile) {
            $storeProfile = $this->autoMapping->map(UserRegisterRequest::class, StoreOwnerProfileEntity::class, $request);
            $storeProfile->setStatus('inactive');
            $storeProfile->setStoreOwnerId($userRegister->getId());
            // $storeProfile->setStoreOwnerName($request->getUserName());
            $storeProfile->setStoreOwnerName(0);

            $this->entityManager->persist($storeProfile);
            $this->entityManager->flush();
        }

        return $userRegister;
    }

    public function createProfileWithUserFound($user, UserRegisterRequest $request): string
    {
        $storeProfile = $this->storeOwnerProfileEntityRepository->getStoreProfileByStoreId($user['id']);

        if (!$storeProfile) {
            $storeProfile = $this->autoMapping->map(UserRegisterRequest::class, StoreOwnerProfileEntity::class, $request);

            $storeProfile->setStatus('inactive');
            $storeProfile->setStoreOwnerId($user['id']);
            $storeProfile->setStoreOwnerName($request->getUserName());

            $this->entityManager->persist($storeProfile);
            $this->entityManager->flush();
        }

        return 'user is found';
    }

    public function storeOwnerProfileUpdate(StoreOwnerProfileUpdateRequest $request): mixed
    {
        $item = $this->storeOwnerProfileEntityRepository->getUserProfile($request->getUserId());

        if ($item) {
            if ($request->getStoreOwnerName() === null) {
                $request->setStoreOwnerName($item->getStoreOwnerName());
            }

            $item = $this->autoMapping->mapToObject(StoreOwnerProfileUpdateRequest::class, StoreOwnerProfileEntity::class, $request, $item);
            $item->setOpeningTime($item->getOpeningTime());
            $item->setClosingTime($item->getClosingTime());

            $this->entityManager->flush();

            return $item;
        }
    }

    public function getStoreProfileByStoreId($userId): ?array
    {
        return $this->storeOwnerProfileEntityRepository->getStoreProfileByStoreId($userId);
    }

    /**
     * @param $id
     * @return StoreOwnerProfileEntity|null
     */
    public function getStoreOwnerProfile($id): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileEntityRepository->find($id);
    }
}
