<?php

namespace App\Service\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\CaptainEntity;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\Captain\CaptainProfileUpdateRequest;
use App\Response\Captain\CaptainProfileResponse;
use App\Entity\UserEntity;
use App\Request\User\UserRegisterRequest;
use App\Response\User\UserRegisterResponse;
use App\Manager\Captain\CaptainManager;

class CaptainService
{
    private AutoMapping $autoMapping;
    private CaptainManager $captainManager;

    public function __construct(AutoMapping $autoMapping, CaptainManager $captainManager)
    {
        $this->autoMapping = $autoMapping;
        $this->captainManager = $captainManager;
    }

    public function captainRegister(UserRegisterRequest $request): UserRegisterResponse
    {
        $userRegister = $this->captainManager->captainRegister($request);

        if ($userRegister === UserReturnResultConstant::USER_IS_FOUND_RESULT) {

            $user['found'] = UserReturnResultConstant::YES_RESULT;

            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }
      
        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function captainProfileUpdate(CaptainProfileUpdateRequest $request): CaptainProfileResponse
    {
        $item = $this->captainManager->captainProfileUpdate($request);

        return $this->autoMapping->map(CaptainEntity::class, CaptainProfileResponse::class, $item);
    }

    public function getCaptainProfile($userId)
    {
        $item = $this->captainManager->getCaptainProfile($userId);

        if($item['roomId']) {
          
            $item['roomId'] = $item['roomId']->toBase32();
        }

        return $this->autoMapping->map('array', CaptainProfileResponse::class, $item);
    }

    public function getCompleteAccountStatusOfCaptainProfile(string $storeOwnerId): ?array
    {
        return $this->captainManager->getCompleteAccountStatusOfCaptainProfile($storeOwnerId);
    }

    public function storeOwnerProfileCompleteAccountStatusUpdate(CompleteAccountStatusUpdateRequest $request): CaptainEntity|string
    {
        return $this->storeOwnerProfileManager->storeOwnerProfileCompleteAccountStatusUpdate($request);
    }

    public function getStoreOwnersProfilesByStatusForAdmin(string $storeOwnerProfileStatus): array
    {
        $response = [];

        $storeOwnerProfiles = $this->storeOwnerProfileManager->getStoreOwnersProfilesByStatusForAdmin($storeOwnerProfileStatus);

        if($storeOwnerProfiles) {
            foreach($storeOwnerProfiles as $storeOwnerProfile) {
                $storeOwnerProfile['images'] = $this->getImageParams($storeOwnerProfile['images'], $this->params.$storeOwnerProfile['images'], $this->params);

                $response[] = $this->autoMapping->map('array', StoreOwnerProfileGetByAdminResponse::class, $storeOwnerProfile);
            }
        }

        return $response;
    }

    public function getStoreOwnerProfileByIdForAdmin(int $storeOwnerProfileId): ?StoreOwnerProfileByIdGetByAdminResponse
    {
        $storeOwnerProfile = $this->storeOwnerProfileManager->getStoreOwnerProfileByIdForAdmin($storeOwnerProfileId);

        if($storeOwnerProfile) {
            $storeOwnerProfile['images'] = $this->getImageParams($storeOwnerProfile['images'], $this->params.$storeOwnerProfile['images'], $this->params);
            
            if($storeOwnerProfile['roomId']) {
                $storeOwnerProfile['roomId'] = $storeOwnerProfile['roomId']->toBase32();
            }
        }

        $storeOwnerProfile['branches'] = $this->storeOwnerProfileManager->getStoreOwnerBranchesByStoreOwnerProfileIdForAdmin($storeOwnerProfileId);

        return $this->autoMapping->map('array', StoreOwnerProfileByIdGetByAdminResponse::class, $storeOwnerProfile);
    }

    public function updateStoreOwnerProfileStatusByAdmin(StoreOwnerProfileStatusUpdateByAdminRequest $request): string|StoreOwnerProfileGetByAdminResponse
    {
        $storeOwnerProfile = $this->storeOwnerProfileManager->updateStoreOwnerProfileStatusByAdmin($request);

        if($storeOwnerProfile === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        return $this->autoMapping->map(StoreOwnerProfileEntity::class, StoreOwnerProfileGetByAdminResponse::class, $storeOwnerProfile);
    }

    public function updateStoreOwnerProfileByAdmin(StoreOwnerProfileUpdateByAdminRequest $request): string|StoreOwnerProfileGetByAdminResponse
    {
        $storeOwnerProfile = $this->storeOwnerProfileManager->updateStoreOwnerProfileByAdmin($request);

        if($storeOwnerProfile === StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_NOT_EXISTS;
        }

        return $this->autoMapping->map(StoreOwnerProfileEntity::class, StoreOwnerProfileGetByAdminResponse::class, $storeOwnerProfile);
    }

    public function getImageParams($imageURL, $image, $baseURL): array
    {
        $item['imageURL'] = $imageURL;
        $item['image'] = $image;
        $item['baseURL'] = $baseURL;

        return $item;
    }
}
