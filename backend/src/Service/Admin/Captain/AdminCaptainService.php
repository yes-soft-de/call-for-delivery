<?php

namespace App\Service\Admin\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Entity\CaptainEntity;
use App\Entity\ImageEntity;
use App\Manager\Admin\Captain\AdminCaptainManager;
use App\Request\Admin\Captain\CaptainProfileStatusUpdateByAdminRequest;
use App\Request\Admin\Captain\CaptainProfileUpdateByAdminRequest;
use App\Request\Image\ImageCreateRequest;
use App\Request\Image\ImageUpdateRequest;
use App\Response\Admin\Captain\CaptainProfileGetForAdminResponse;
use App\Service\FileUpload\UploadFileHelperService;
use App\Service\Image\ImageService;

class AdminCaptainService
{
    private AutoMapping $autoMapping;
    private AdminCaptainManager $adminCaptainManager;
    private UploadFileHelperService $uploadFileHelperService;
    private ImageService $imageService;

    public function __construct(AutoMapping $autoMapping, AdminCaptainManager $adminCaptainManager, UploadFileHelperService $uploadFileHelperService, ImageService $imageService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminCaptainManager = $adminCaptainManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
        $this->imageService = $imageService;
    }

    public function getCaptainsProfilesByStatusForAdmin(string $captainProfileStatus): array
    {
        $response = [];

        $captainsProfiles = $this->adminCaptainManager->getCaptainsProfilesByStatusForAdmin($captainProfileStatus);

        foreach ($captainsProfiles as $captainProfile) {
            $captainProfile['images'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfile['id'], ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);

            $captainProfile['drivingLicence'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfile['id'], ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_DRIVE_LICENSE_IMAGE);

            $captainProfile['mechanicLicense'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfile['id'], ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_MECHANIC_LICENSE_IMAGE);

            $captainProfile['identity'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfile['id'], ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_IDENTITY_IMAGE);

            if (empty($captainProfile['location'])) {
                $captainProfile['location'] = null;
            }

            $response[] = $this->autoMapping->map('array', CaptainProfileGetForAdminResponse::class, $captainProfile);
        }

        return $response;
    }

    public function getCaptainProfileByIdForAdmin(int $captainProfileId): ?CaptainProfileGetForAdminResponse
    {
        $captainProfile = $this->adminCaptainManager->getCaptainProfileByIdForAdmin($captainProfileId);

        if ($captainProfile) {
            $captainProfile['images'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfileId, ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);

            $captainProfile['drivingLicence'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfileId, ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_DRIVE_LICENSE_IMAGE);

            $captainProfile['mechanicLicense'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfileId, ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_MECHANIC_LICENSE_IMAGE);

            $captainProfile['identity'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captainProfileId, ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_IDENTITY_IMAGE);

            if($captainProfile['roomId']) {
                $captainProfile['roomId'] = $captainProfile['roomId']->toBase32();
            }

            if (empty($captainProfile['location'])) {
                $captainProfile['location'] = null;
            }
        }

        return $this->autoMapping->map('array', CaptainProfileGetForAdminResponse::class, $captainProfile);
    }

    public function updateCaptainProfileStatusByAdmin(CaptainProfileStatusUpdateByAdminRequest $request): string|CaptainProfileGetForAdminResponse
    {
        $captainProfile = $this->adminCaptainManager->updateCaptainProfileStatusByAdmin($request);

        if ($captainProfile === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;

        } else {
            return $this->autoMapping->map(CaptainEntity::class, CaptainProfileGetForAdminResponse::class, $captainProfile);
        }
    }

    public function updateCaptainProfileByAdmin(CaptainProfileUpdateByAdminRequest $request): string|CaptainProfileGetForAdminResponse
    {
        $captainProfile = $this->adminCaptainManager->updateCaptainProfileByAdmin($request);

        if ($captainProfile === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;

        } else {
            // update captain images
            $this->updateCaptainImagesByAdmin($request);

            return $this->autoMapping->map(CaptainEntity::class, CaptainProfileGetForAdminResponse::class, $captainProfile);
        }
    }

    public function updateCaptainImagesByAdmin(CaptainProfileUpdateByAdminRequest $request)
    {
        if ($request->getImages()) {
            // Check, if there previous image, then update it. Otherwise, create a new one
            $profileImage = $this->imageService->getImageByItemIdAndEntityTypeAndImageAim($request->getId(), ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);

            if (! $profileImage) {
                // No previous image was found, then create a new one
                $this->createCaptainImage($request->getImages(), $request->getId(), ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);

            } else {
                // There is already an image, then update it
                $this->updateCaptainImage($request->getImages(), $profileImage);
            }
        }

        if ($request->getDrivingLicence()) {
            // Check, if there previous image, then update it. Otherwise, create a new one
            $driverLicenceImage = $this->imageService->getImageByItemIdAndEntityTypeAndImageAim($request->getId(), ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_DRIVE_LICENSE_IMAGE);

            if (! $driverLicenceImage) {
                // No previous image was found, then create a new one
                $this->createCaptainImage($request->getDrivingLicence(), $request->getId(), ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_DRIVE_LICENSE_IMAGE);

            } else {
                // There is already an image, then update it
                $this->updateCaptainImage($request->getImages(), $driverLicenceImage);
            }
        }

        if ($request->getIdentity()) {
            // Check, if there previous image, then update it. Otherwise, create a new one
            $identityImage = $this->imageService->getImageByItemIdAndEntityTypeAndImageAim($request->getId(), ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_IDENTITY_IMAGE);

            if (! $identityImage) {
                // No previous image was found, then create a new one
                $this->createCaptainImage($request->getIdentity(), $request->getId(), ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_IDENTITY_IMAGE);

            } else {
                // There is already an image, then update it
                $this->updateCaptainImage($request->getImages(), $identityImage);
            }
        }

        if ($request->getMechanicLicense()) {
            // Check, if there previous image, then update it. Otherwise, create a new one
            $mechanicalLicenceImage = $this->imageService->getImageByItemIdAndEntityTypeAndImageAim($request->getId(), ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_MECHANIC_LICENSE_IMAGE);

            if (! $mechanicalLicenceImage) {
                // No previous image was found, then create a new one
                $this->createCaptainImage($request->getMechanicLicense(), $request->getId(), ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_MECHANIC_LICENSE_IMAGE);

            } else {
                // There is already an image, then update it
                $this->updateCaptainImage($request->getImages(), $mechanicalLicenceImage);
            }
        }
    }

    public function createCaptainImage(string $imagePath, int $itemId, int $entityType, int $usedAs)
    {
        $imageCreateRequest = new ImageCreateRequest();

        $imageCreateRequest->setImagePath($imagePath);
        $imageCreateRequest->setItemId($itemId);
        $imageCreateRequest->setEntityType($entityType);
        $imageCreateRequest->setUsedAs($usedAs);

        $this->imageService->create($imageCreateRequest);
    }

    public function updateCaptainImage(string $newImagePath, ImageEntity $existedImageEntity)
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
