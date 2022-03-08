<?php

namespace App\Service\StoreOwner;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Request\StoreOwner\StoreOwnerCompleteAccountStatusUpdateRequest;
use App\Request\StoreOwner\StoreOwnerProfileStatusUpdateByAdminRequest;
use App\Request\StoreOwner\StoreOwnerProfileUpdateByAdminRequest;
use App\Request\StoreOwner\StoreOwnerProfileUpdateRequest;
use App\Response\StoreOwner\StoreOwnerCompleteAccountStatusGetResponse;
use App\Response\StoreOwner\StoreOwnerCompleteAccountStatusUpdateResponse;
use App\Response\StoreOwner\StoreOwnerProfileByIdGetByAdminResponse;
use App\Response\StoreOwner\StoreOwnerProfileGetByAdminResponse;
use App\Response\StoreOwner\StoreOwnerProfileResponse;
use App\Entity\UserEntity;
use App\Request\User\UserRegisterRequest;
use App\Response\User\UserRegisterResponse;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class StoreOwnerProfileService
{
    private $autoMapping;
    private $params;
    private $storeOwnerProfileManager;

    public function __construct(AutoMapping $autoMapping, StoreOwnerProfileManager $storeOwnerProfileManager, ParameterBagInterface $params)
    {
        $this->params = $params->get('upload_base_url') . '/';
        $this->autoMapping = $autoMapping;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
    }

    public function storeOwnerRegister(UserRegisterRequest $request): UserRegisterResponse
    {
        $userRegister = $this->storeOwnerProfileManager->storeOwnerRegister($request);

        if ($userRegister === UserReturnResultConstant::USER_IS_FOUND_RESULT) {
            $user['found'] = UserReturnResultConstant::YES_RESULT;
            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }
      
        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function storeOwnerProfileUpdate(StoreOwnerProfileUpdateRequest $request): StoreOwnerProfileResponse
    {
        $item = $this->storeOwnerProfileManager->storeOwnerProfileUpdate($request);

        return $this->autoMapping->map(StoreOwnerProfileEntity::class, StoreOwnerProfileResponse::class, $item);
    }

    public function getStoreOwnerProfile($userId)
    {
        $item = $this->storeOwnerProfileManager->getStoreProfileByStoreId($userId);

        if($item)
        {
            $item['images'] = $this->getImageParams($item['images'], $this->params.$item['images'], $this->params);
        }

        if($item['roomId']) {
            $item['roomId'] = $item['roomId']->toBase32();
        }

        return $this->autoMapping->map('array', StoreOwnerProfileResponse::class, $item);
    }

    public function getCompleteAccountStatusByStoreOwnerId(string $storeOwnerId): StoreOwnerCompleteAccountStatusGetResponse
    {
        $completeAccountStatusResult = $this->storeOwnerProfileManager->getCompleteAccountStatusByStoreOwnerId($storeOwnerId);

        return $this->autoMapping->map('array', StoreOwnerCompleteAccountStatusGetResponse::class, $completeAccountStatusResult);
    }

    public function storeOwnerProfileCompleteAccountStatusUpdate(StoreOwnerCompleteAccountStatusUpdateRequest $request): StoreOwnerCompleteAccountStatusUpdateResponse|string
    {
        $storeOwnerProfileResult = $this->storeOwnerProfileManager->storeOwnerProfileCompleteAccountStatusUpdate($request);

        if($storeOwnerProfileResult === StoreProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS) {
            return StoreProfileConstant::WRONG_COMPLETE_ACCOUNT_STATUS;
        }

        return $this->autoMapping->map(StoreOwnerProfileEntity::class, StoreOwnerCompleteAccountStatusUpdateResponse::class, $storeOwnerProfileResult);
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
