<?php

namespace App\Service\Admin;

use App\AutoMapping;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Constant\User\UserReturnResultConstant;
use App\Entity\AdminProfileEntity;
use App\Entity\ImageEntity;
use App\Entity\UserEntity;
use App\Manager\Admin\AdminManager;
use App\Request\Admin\AdminProfileUpdateRequest;
use App\Request\Admin\AdminRegisterRequest;
use App\Request\Image\ImageCreateRequest;
use App\Request\Image\ImageUpdateRequest;
use App\Response\Admin\AdminProfileGetResponse;
use App\Response\User\UserRegisterResponse;
use App\Service\FileUpload\UploadFileHelperService;
use App\Service\Image\ImageService;

class AdminService implements AdminServiceInterface
{
    private AutoMapping $autoMapping;
    private AdminManager $adminManager;
    private ImageService $imageService;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, AdminManager $adminManager, ImageService $imageService, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminManager = $adminManager;
        $this->imageService = $imageService;
        $this->uploadFileHelperService = $uploadFileHelperService;
    }

    public function adminRegister(AdminRegisterRequest $request): UserRegisterResponse
    {
        $userRegister = $this->adminManager->adminRegister($request);

        if($userRegister === UserReturnResultConstant::USER_IS_FOUND_RESULT) {
            $user['found'] = UserReturnResultConstant::YES_RESULT;

            return $this->autoMapping->map("array", UserRegisterResponse::class, $user);
        }

        return $this->autoMapping->map(UserEntity::class, UserRegisterResponse::class, $userRegister);
    }

    public function getAdminProfileByAdminUserId(int $adminUserId): ?AdminProfileGetResponse
    {
        $adminProfile = $this->adminManager->getAdminProfileWithImageByAdminUserId($adminUserId);

        if ($adminProfile) {
            $adminProfile['image'] = $this->uploadFileHelperService->getImageParams($adminProfile['imagePath']);
        }

        return $this->autoMapping->map('array', AdminProfileGetResponse::class, $adminProfile);
    }

    public function updateAdminProfile(AdminProfileUpdateRequest $request): AdminProfileGetResponse
    {
        $adminProfile = $this->adminManager->updateAdminProfile($request);

        $this->handleAdminProfileImage($request->getAdminUserId(), $request->getImage());

        return $this->autoMapping->map(AdminProfileEntity::class, AdminProfileGetResponse::class, $adminProfile);
    }

    public function handleAdminProfileImage(int $adminProfileId, string|null $adminImage)
    {
        if ($adminImage) {
            // Check, if there previous image, then update it. Otherwise, create a new one
            $profileImage = $this->imageService->getImageByItemIdAndEntityTypeAndImageAim($adminProfileId, ImageEntityTypeConstant::ENTITY_TYPE_ADMIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);

            if (! $profileImage) {
                // No previous image was found, then create a new one
                $this->createAdminImage($adminImage, $adminProfileId, ImageEntityTypeConstant::ENTITY_TYPE_ADMIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);

            } else {
                // There is already an image, then update it
                $this->updateAdminImage($adminImage, $profileImage);
            }
        }
    }

    public function createAdminImage(string $imagePath, int $itemId, int $entityType, int $usedAs)
    {
        $imageCreateRequest = new ImageCreateRequest();

        $imageCreateRequest->setImagePath($imagePath);
        $imageCreateRequest->setItemId($itemId);
        $imageCreateRequest->setEntityType($entityType);
        $imageCreateRequest->setUsedAs($usedAs);

        $this->imageService->create($imageCreateRequest);
    }

    public function updateAdminImage(string $newImagePath, ImageEntity $existedImageEntity)
    {
        $imageUpdateRequest = new ImageUpdateRequest();

        $imageUpdateRequest->setId($existedImageEntity->getId());
        $imageUpdateRequest->setItemId($existedImageEntity->getItemId());
        $imageUpdateRequest->setEntityType($existedImageEntity->getEntityType());
        $imageUpdateRequest->setUsedAs($existedImageEntity->getUsedAs());
        $imageUpdateRequest->setImagePath($newImagePath);

        $this->imageService->update($imageUpdateRequest);
    }
}
