<?php

namespace App\Service\StoreOwner;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\StoreOwnerProfileEntity;
use App\Request\Account\CompleteAccountStatusUpdateRequest;
use App\Request\Admin\StoreOwner\StoreOwnerProfileStatusUpdateByAdminRequest;
use App\Request\Admin\StoreOwner\StoreOwnerProfileUpdateByAdminRequest;
use App\Request\StoreOwner\StoreOwnerProfileUpdateRequest;
use App\Request\Verification\VerificationCreateRequest;
use App\Response\Admin\StoreOwner\StoreOwnerProfileByIdGetByAdminResponse;
use App\Response\Admin\StoreOwner\StoreOwnerProfileGetByAdminResponse;
use App\Response\StoreOwner\StoreOwnerProfileResponse;
use App\Entity\UserEntity;
use App\Request\User\UserRegisterRequest;
use App\Response\User\UserRegisterResponse;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Service\Verification\VerificationService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class StoreOwnerProfileService
{
    private AutoMapping $autoMapping;
    private $params;
    private StoreOwnerProfileManager $storeOwnerProfileManager;
    private VerificationService $verificationService;

    public function __construct(AutoMapping $autoMapping, StoreOwnerProfileManager $storeOwnerProfileManager, ParameterBagInterface $params, VerificationService $verificationService)
    {
        $this->params = $params->get('upload_base_url') . '/';
        $this->autoMapping = $autoMapping;
        $this->storeOwnerProfileManager = $storeOwnerProfileManager;
        $this->verificationService = $verificationService;
    }

    public function storeOwnerRegister(UserRegisterRequest $request): UserRegisterResponse
    {
        $userRegister = $this->storeOwnerProfileManager->storeOwnerRegister($request);

        if ($userRegister === UserReturnResultConstant::USER_IS_FOUND_RESULT) {
            $user['found'] = UserReturnResultConstant::YES_RESULT;
            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }

        // create verification code for the user
        $this->createVerificationCodeForStoreOwner($userRegister);
      
        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function createVerificationCodeForStoreOwner(UserEntity $userEntity)
    {
        $verificationCodeRequest = new VerificationCreateRequest();

        $verificationCodeRequest->setUser($userEntity);

        $this->verificationService->createVerificationCode($verificationCodeRequest);
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

    public function getCompleteAccountStatusByStoreOwnerId(string $storeOwnerId): ?array
    {
        return $this->storeOwnerProfileManager->getCompleteAccountStatusByStoreOwnerId($storeOwnerId);
    }

    public function storeOwnerProfileCompleteAccountStatusUpdate(CompleteAccountStatusUpdateRequest $request): StoreOwnerProfileEntity|string
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
    
    public function checkStoreStatus($userId): string
    {
        $storeProfile = $this->storeOwnerProfileManager->getStoreOwnerProfileByStoreId($userId);
       
        return $storeProfile->getStatus();
    }

    public function getStoreByUserId($userId): ?StoreOwnerProfileEntity
    {
       return $this->storeOwnerProfileManager->getStoreByUserId($userId);
    }

    public function getStoreOwnerProfileEntityByIdForAdmin(int $id): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileManager->getStoreOwnerProfileEntityByIdForAdmin($id);
    }

    public function deleteStoreOwnerProfileByStoreOwnerId(int $storeOwnerId): ?StoreOwnerProfileEntity
    {
        return $this->storeOwnerProfileManager->deleteStoreOwnerProfileByStoreOwnerId($storeOwnerId);
    }
}
