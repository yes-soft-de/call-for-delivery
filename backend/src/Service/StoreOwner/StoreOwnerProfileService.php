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
use App\Request\StoreOwnerBranch\StoreOwnerBranchCreateRequest;
use App\Request\Verification\VerificationCreateRequest;
use App\Response\Admin\StoreOwner\StoreOwnerProfileByIdGetByAdminResponse;
use App\Response\Admin\StoreOwner\StoreOwnerProfileGetByAdminResponse;
use App\Response\StoreOwner\StoreOwnerProfileResponse;
use App\Entity\UserEntity;
use App\Request\User\UserRegisterRequest;
use App\Response\StoreOwnerBranch\StoreOwnerBranchResponse;
use App\Response\User\UserRegisterResponse;
use App\Manager\StoreOwner\StoreOwnerProfileManager;
use App\Service\StoreOwnerBranch\StoreOwnerBranchService;
use App\Service\Verification\VerificationService;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class StoreOwnerProfileService
{
    private $params;

    public function __construct(
        private AutoMapping $autoMapping,
        private StoreOwnerProfileManager $storeOwnerProfileManager,
        ParameterBagInterface $params,
        private VerificationService $verificationService,
        private StoreOwnerBranchService $storeOwnerBranchService
    )
    {
        $this->params = $params->get('upload_base_url') . '/';
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

    public function createStoreOwnerBranch(StoreOwnerProfileUpdateRequest $request, StoreOwnerProfileEntity $storeOwnerProfileEntity): StoreOwnerBranchResponse
    {
        $branchCreateRequest = $this->autoMapping->map(StoreOwnerProfileUpdateRequest::class,
            StoreOwnerBranchCreateRequest::class, $request);

        if (($request->getStoreOwnerName() === "0")) {
            $branchCreateRequest->setName("الرئيسي");

        } else {
            $branchCreateRequest->setName($request->getStoreOwnerName());
        }

        $branchCreateRequest->setStoreOwner($storeOwnerProfileEntity);
        $branchCreateRequest->setIsActive(true);

        if (! $request->getCity()) {
            $branchCreateRequest->setCity("");
        }

        if (! $request->getPhone()) {
            $branchCreateRequest->setBranchPhone("");
        }

        return $this->storeOwnerBranchService->createDefaultBranch($branchCreateRequest);
    }

    public function updateStoreOwnerProfileCompleteAccountStatusAfterBranchCreation($userId, string $completeAccountStatus): StoreOwnerProfileEntity|string
    {
        $updateRequest = new CompleteAccountStatusUpdateRequest();

        $updateRequest->setCompleteAccountStatus($completeAccountStatus);
        $updateRequest->setUserId($userId);

        return $this->storeOwnerProfileManager->storeOwnerProfileCompleteAccountStatusUpdate($updateRequest);
    }

    public function storeOwnerProfileUpdate(StoreOwnerProfileUpdateRequest $request): StoreOwnerProfileResponse
    {
        $item = $this->storeOwnerProfileManager->storeOwnerProfileUpdate($request);

        if ($item instanceof StoreOwnerProfileEntity) {
            // If store owner profile updates for the first time, then create a default branch for it
            if ($item->getCompleteAccountStatus() === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_PROFILE_COMPLETED) {
                // create store branch as long as profileCompleted
                $branchCreateResult = $this->createStoreOwnerBranch($request, $item);

                if ($branchCreateResult) {
                    //if ($branchCreateResult instanceof StoreOwnerBranchResponse) {
                        // update completeAccountStatus to requiredFreeSubscription
                        $completeAccountStatus = $this->getCompleteAccountStatusByStoreOwnerId($request->getUserId());

                        if ($completeAccountStatus['completeAccountStatus'] === StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_BRANCH_CREATED) {
                            $this->updateStoreOwnerProfileCompleteAccountStatusAfterBranchCreation($request->getUserId(),
                                StoreProfileConstant::COMPLETE_ACCOUNT_STATUS_BEFORE_FREE_SUBSCRIPTION_CONST);
                        }
                    //}
                }
            }
        }

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
