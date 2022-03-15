<?php

namespace App\Manager\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\CaptainEntity;
use App\Repository\CaptainEntityRepository;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\Captain\CaptainProfileUpdateRequest;
use App\Request\User\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\User\UserManager;
use App\Constant\ChatRoom\ChatRoomConstant;

class CaptainManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private UserManager $userManager;
    private CaptainEntityRepository $captainEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserManager $userManager, CaptainEntityRepository $captainEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->userManager = $userManager;
        $this->captainEntityRepository = $captainEntityRepository;
    }

    public function captainRegister(UserRegisterRequest $request): mixed
    {
        $user = $this->userManager->getUserByUserId($request->getUserId());

        if (! $user) {
            $request->setRoles(["ROLE_CAPTAIN", "ROLE_USER"]);

            $userRegister = $this->userManager->createUser($request, ChatRoomConstant::ADMIN_CAPTAIN);

            if ($userRegister) {
             
                return $this->createProfile($request, $userRegister);
            }

            return UserReturnResultConstant::USER_IS_NOT_CREATED_RESULT;
        } 
        
        return $this->createProfileWithUserFound($user, $request);
        
    }

    public function createProfile(UserRegisterRequest $request, $userRegister): mixed
    {
        $captainProfile = $this->captainEntityRepository->getCaptainByCaptainId($request->getUserID());

        if (! $captainProfile) {
            $captainProfile = $this->autoMapping->map(UserRegisterRequest::class, CaptainEntity::class, $request);
          //TODO change to CAPTAIN_INACTIVE
            $captainProfile->setStatus(CaptainConstant::CAPTAIN_ACTIVE);
            $captainProfile->setCaptainId($userRegister->getId());
            $captainProfile->setCaptainName(0);
            $captainProfile->setIsOnline(CaptainConstant::CAPTAIN_ONLINE_TRUE);
            $captainProfile->setCompleteAccountStatus(CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED);

            $this->entityManager->persist($captainProfile);
            $this->entityManager->flush();
        }

        return $userRegister;
    }

    public function createProfileWithUserFound($user, UserRegisterRequest $request): string
    {
        $captainProfile = $this->captainEntityRepository->getCaptainByCaptainId($user['id']);

        if (! $captainProfile) {
            $captainProfile = $this->autoMapping->map(UserRegisterRequest::class, CaptainEntity::class, $request);

            //TODO change to CAPTAIN_INACTIVE
            $captainProfile->setStatus(CaptainConstant::CAPTAIN_ACTIVE);
            $captainProfile->setCaptainId($user['id']);
            $captainProfile->setCaptainName(0);
            $captainProfile->setIsOnline(CaptainConstant::CAPTAIN_ONLINE_TRUE);
            $captainProfile->setCompleteAccountStatus(CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED);

            $this->entityManager->persist($captainProfile);
            $this->entityManager->flush();
        }

        return UserReturnResultConstant::USER_IS_FOUND_RESULT;
    }

    public function captainProfileUpdate(CaptainProfileUpdateRequest $request): mixed
    {
        $item = $this->captainEntityRepository->getUserProfile($request->getCaptainId());

        if ($item) {
            if ($request->getCaptainName() === null) {
                $request->setCaptainName($item->getCaptainName());
            }

            $item = $this->autoMapping->mapToObject(CaptainProfileUpdateRequest::class, CaptainEntity::class, $request, $item);

            if($item->getCompleteAccountStatus() === CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED) {
                $item->setCompleteAccountStatus(CaptainConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_COMPLETED);
            }

            $this->entityManager->flush();

            return $item;
        }
    }

    public function getCaptainProfile($userId): ?array
    {
        return $this->captainEntityRepository->getCaptainByCaptainId($userId);
    }

    /**
     * @param $id
     * @return StoreOwnerProfileEntity|null
     */
    public function getStoreOwnerProfile($id): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileEntityRepository->find($id);
    }

    /**
     * @param $storeOwnerId
     * @return StoreOwnerProfileEntity|null
     */
    public function getStoreOwnerProfileByStoreId($storeOwnerId): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileEntityRepository->findOneBy(["storeOwnerId"=>$storeOwnerId]);
    }

    public function getStoreOwnerProfileByStoreOwnerId($storeOwnerId): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerProfileByStoreOwnerId($storeOwnerId);
    }

    public function getCompleteAccountStatusOfCaptainProfile($storeOwnerId): ?array
    {
        return $this->captainEntityRepository->getCompleteAccountStatusByCaptainId($storeOwnerId);
    }

    public function storeOwnerProfileCompleteAccountStatusUpdate(CompleteAccountStatusUpdateRequest $request): StoreOwnerProfileEntity|string
    {
        if(! $this->checkCompleteAccountStatusValidity($request->getCompleteAccountStatus())) {
            return StoreProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS;

        } else {
            $storeOwnerProfile = $this->storeOwnerProfileEntityRepository->getUserProfile($request->getUserId());

            if ($storeOwnerProfile) {
                $storeOwnerProfile = $this->autoMapping->mapToObject(CompleteAccountStatusUpdateRequest::class, StoreOwnerProfileEntity::class, $request, $storeOwnerProfile);

                $this->entityManager->flush();

                return $storeOwnerProfile;
            }
        }
    }

    public function checkCompleteAccountStatusValidity(string $completeAccountStatus): bool
    {
        if ($completeAccountStatus !== StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED && $completeAccountStatus !== StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_COMPLETED &&
            $completeAccountStatus !== StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_SUBSCRIPTION_CREATED && $completeAccountStatus !== StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_BRANCH_CREATED) {
            return false;
        }

        return true;
    }

    public function getStoreOwnersProfilesByStatusForAdmin(string $storeOwnerProfileStatus): ?array
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnersProfilesByStatusForAdmin($storeOwnerProfileStatus);
    }

    public function getStoreOwnerProfileByIdForAdmin(int $storeOwnerProfileId): ?array
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerProfileByIdForAdmin($storeOwnerProfileId);
    }

    public function getStoreOwnerBranchesByStoreOwnerProfileIdForAdmin(int $storeOwnerProfileId): ?array
    {
        return $this->storeOwnerProfileEntityRepository->getStoreOwnerBranchesByStoreOwnerProfileIdForAdmin($storeOwnerProfileId);
    }

    public function updateStoreOwnerProfileStatusByAdmin(StoreOwnerProfileStatusUpdateByAdminRequest $request): string|StoreOwnerProfileEntity
    {
        $storeOwnerProfileEntity = $this->storeOwnerProfileEntityRepository->find($request->getId());

        if(! $storeOwnerProfileEntity) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $storeOwnerProfileEntity = $this->autoMapping->mapToObject(StoreOwnerProfileStatusUpdateByAdminRequest::class, StoreOwnerProfileEntity::class,
         $request, $storeOwnerProfileEntity);

        $this->entityManager->flush();

        return $storeOwnerProfileEntity;
    }

    public function updateStoreOwnerProfileByAdmin(StoreOwnerProfileUpdateByAdminRequest $request): string|StoreOwnerProfileEntity
    {
        $storeOwnerProfileEntity = $this->storeOwnerProfileEntityRepository->find($request->getId());

        if(! $storeOwnerProfileEntity) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        $storeOwnerProfileEntity = $this->autoMapping->mapToObject(StoreOwnerProfileUpdateByAdminRequest::class, StoreOwnerProfileEntity::class,
            $request, $storeOwnerProfileEntity);

        $storeOwnerProfileEntity->setOpeningTime($request->getOpeningTime());
        $storeOwnerProfileEntity->setClosingTime($request->getClosingTime());

        $this->entityManager->flush();

        return $storeOwnerProfileEntity;
    }
}
