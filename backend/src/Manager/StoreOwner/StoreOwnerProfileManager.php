<?php

namespace App\Manager\StoreOwner;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Constant\User\UserRoleConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Repository\StoreOwnerProfileEntityRepository;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\Admin\StoreOwner\StoreOwnerProfileStatusUpdateByAdminRequest;
use App\Request\Admin\StoreOwner\StoreOwnerProfileUpdateByAdminRequest;
use App\Request\StoreOwner\StoreOwnerProfileUpdateRequest;
use App\Request\User\UserRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Manager\User\UserManager;
use App\Constant\ChatRoom\ChatRoomConstant;

class StoreOwnerProfileManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private UserManager $userManager,
        private StoreOwnerProfileEntityRepository $storeOwnerProfileEntityRepository
    )
    {
    }

    public function storeOwnerRegister(UserRegisterRequest $request): mixed
    {
        $user = $this->userManager->getUserByUserId($request->getUserId());

        if (! $user) {
            $request->setRoles(["ROLE_OWNER", "ROLE_USER"]);

            $userRegister = $this->userManager->createUser($request, ChatRoomConstant::ADMIN_STORE);

            if ($userRegister) {
                return $this->createProfile($request, $userRegister);

            } else {
                return UserReturnResultConstant::USER_IS_NOT_CREATED_RESULT;
            }

        } else {
            if (in_array(UserRoleConstant::ROLE_OWNER, $user['roles'])) {
                $storeOwnerProfile = $this->getStoreOwnerProfile($user['id']);

                if (! $storeOwnerProfile) {
                    return $this->createProfileWithUserFound($user, $request);
                }
            }

            return UserReturnResultConstant::USER_IS_FOUND_RESULT;
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
            $storeProfile->setCompleteAccountStatus(StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED);
            $storeProfile->setOpeningSubscriptionWithoutPayment(false);

            $this->entityManager->persist($storeProfile);
            $this->entityManager->flush();
        }

        return $userRegister;
    }

    public function createProfileWithUserFound($user, UserRegisterRequest $request): string
    {
        $storeProfile = $this->storeOwnerProfileEntityRepository->getStoreProfileByStoreId($user['id']);

        if (! $storeProfile) {
            $storeProfile = $this->autoMapping->map(UserRegisterRequest::class, StoreOwnerProfileEntity::class, $request);

            $storeProfile->setStatus('inactive');
            $storeProfile->setStoreOwnerId($user['id']);
            $storeProfile->setStoreOwnerName($request->getUserName());
            $storeProfile->setCompleteAccountStatus(StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED);
            $storeProfile->setOpeningSubscriptionWithoutPayment(false);

            $this->entityManager->persist($storeProfile);
            $this->entityManager->flush();
        }

        return UserReturnResultConstant::USER_IS_FOUND_RESULT;
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

            if($item->getCompleteAccountStatus() === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_CREATED) {
                $item->setCompleteAccountStatus(StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_COMPLETED);
            }

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

    public function getCompleteAccountStatusByStoreOwnerId($storeOwnerId): ?array
    {
        return $this->storeOwnerProfileEntityRepository->getCompleteAccountStatusByStoreOwnerId($storeOwnerId);
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
            $completeAccountStatus !== StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_SUBSCRIPTION_CREATED && $completeAccountStatus !== StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_BRANCH_CREATED
            && $completeAccountStatus !== StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_FREE_SUBSCRIPTION_CREATED && $completeAccountStatus !== StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_BEFORE_FREE_SUBSCRIPTION_CONST) {
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

    public function getStoreProfitMarginByStoreOwnerId(int $userId): ?array
    {
        return $this->storeOwnerProfileEntityRepository->getStoreProfitMarginByStoreOwnerId($userId);
    }

    public function getStoreByUserId(int $userId): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileEntityRepository->findOneBy(["storeOwnerId" => $userId]);
    }

    public function getStoreOwnerProfileEntityByIdForAdmin(int $id): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileEntityRepository->find($id);
    }

    public function deleteStoreOwnerProfileByStoreOwnerId(int $storeOwnerId): ?StoreOwnerProfileEntity
    {
        $storeOwnerProfile = $this->storeOwnerProfileEntityRepository->findOneBy(["storeOwnerId"=>$storeOwnerId]);

        if ($storeOwnerProfile !== null) {
            $this->entityManager->remove($storeOwnerProfile);
            $this->entityManager->flush();
        }

        return $storeOwnerProfile;
    }
}
