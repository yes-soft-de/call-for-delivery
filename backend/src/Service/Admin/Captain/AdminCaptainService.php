<?php

namespace App\Service\Admin\Captain;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Entity\CaptainEntity;
use App\Entity\CaptainFinancialDuesEntity;
use App\Entity\ImageEntity;
use App\Manager\Admin\Captain\AdminCaptainManager;
use App\Request\Admin\Account\CompleteAccountStatusUpdateByAdminRequest;
use App\Request\Admin\Captain\CaptainProfileStatusUpdateByAdminRequest;
use App\Request\Admin\Captain\CaptainProfileUpdateByAdminRequest;
use App\Request\Admin\Captain\DeleteCaptainAccountAndProfileByAdminRequest;
use App\Request\Admin\Report\CaptainWithDeliveredOrdersDuringSpecificTimeFilterByAdminRequest;
use App\Request\Image\ImageCreateRequest;
use App\Request\Image\ImageUpdateRequest;
use App\Response\Admin\Captain\CaptainProfileGetForAdminResponse;
use App\Response\Admin\Captain\DeleteCaptainAccountAndProfileByAdminResponse;
use App\Service\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDetailGetService;
use App\Service\CaptainFinancialSystem\CaptainFinancialDuesService;
use App\Service\Eraser\CaptainEraserService;
use App\Service\FileUpload\UploadFileHelperService;
use App\Service\Image\ImageService;
use App\Response\Admin\Captain\ReadyCaptainsAndCountOfTheirCurrentOrdersResponse;
use App\Service\Admin\Order\AdminOrderService;

class AdminCaptainService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminCaptainManager $adminCaptainManager,
        private UploadFileHelperService $uploadFileHelperService,
        private ImageService $imageService,
        private AdminCaptainFinancialSystemDetailGetService $adminCaptainFinancialSystemDetailGetService,
        private AdminOrderService $adminOrderService,
        private CaptainEraserService $captainEraserService,
        private CaptainFinancialDuesService $captainFinancialDuesService
    )
    {
    }

    public function getCaptainsProfilesByStatusForAdmin(string $captainProfileStatus): array
    {
        $response = [];

        $captainsProfiles = $this->adminCaptainManager->getCaptainsProfilesByStatusForAdmin($captainProfileStatus);

        if (! empty($captainsProfiles)) {
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
        }

        return $response;
    }

    public function getCaptainProfileByIdForAdmin(int $captainProfileId): ?CaptainProfileGetForAdminResponse
    {
        $captainProfile = $this->adminCaptainManager->getCaptainProfileByIdForAdmin($captainProfileId);

        if ($captainProfile) {
            
            $captainProfile['images'] = $this->uploadFileHelperService->getImageParams($captainProfile['profileImage']);
            $captainProfile['mechanicLicense'] = $this->uploadFileHelperService->getImageParams($captainProfile['mechanicLicense']);
            $captainProfile['identity'] = $this->uploadFileHelperService->getImageParams($captainProfile['identity']);
            $captainProfile['drivingLicence'] = $this->uploadFileHelperService->getImageParams($captainProfile['drivingLicence']);
 
            if($captainProfile['roomId']) {
                $captainProfile['roomId'] = $captainProfile['roomId']->toBase32();
            }

            if (empty($captainProfile['location'])) {
                $captainProfile['location'] = null;
            }

            // $captainProfile['financialCaptainSystemDetails'] = $this->adminCaptainFinancialSystemDetailService->getLatestFinancialCaptainSystemDetails($captainProfileId);
            $captainProfile['financialCaptainSystemDetails'] = $this->adminCaptainFinancialSystemDetailGetService->getLatestFinancialCaptainSystemDetails($captainProfileId);
        }
        
        return $this->autoMapping->map('array', CaptainProfileGetForAdminResponse::class, $captainProfile);
    }

    public function updateCaptainProfileStatusByAdmin(CaptainProfileStatusUpdateByAdminRequest $request): string|CaptainProfileGetForAdminResponse
    {
        $captainProfile = $this->adminCaptainManager->updateCaptainProfileStatusByAdmin($request);

        if ($captainProfile === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;

        } else {
            // If captain profile activated, then create a new captain financial cycle, if does not exist
            if ($request->getStatus() === CaptainConstant::CAPTAIN_ACTIVE) {
                $this->createCaptainFinancialDueByAdminIfNotAnActiveOneExist($captainProfile->getId());
            }

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
                $this->updateCaptainImage($request->getDrivingLicence(), $driverLicenceImage);
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
                $this->updateCaptainImage($request->getIdentity(), $identityImage);
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
                $this->updateCaptainImage($request->getMechanicLicense(), $mechanicalLicenceImage);
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

    public function getCaptainsCountByStatusForAdmin(string $status): int
    {
        return $this->adminCaptainManager->getCaptainsCountByStatusForAdmin($status);
    }

    public function getReadyCaptainsAndCountOfTheirCurrentOrders(): array
    {
        $response = [];

        $captains = $this->adminCaptainManager->getReadyCaptainsAndCountOfTheirCurrentOrders();

        foreach($captains as $captain) {
            $captain['images'] = $this->imageService->getOneImageByItemIdAndEntityTypeAndImageAim($captain['id'], ImageEntityTypeConstant::ENTITY_TYPE_CAPTAIN_PROFILE, ImageUseAsConstant::IMAGE_USE_AS_PROFILE_IMAGE);
            $captain['countOngoingOrders'] = $this->adminOrderService->getOrdersOngoingCountByCaptainIdForAdmin($captain['id']);
            $response[] = $this->autoMapping->map("array", ReadyCaptainsAndCountOfTheirCurrentOrdersResponse::class, $captain);

        }

        return $response;
    }

    public function deleteCaptainAccountAndProfileByAdmin(DeleteCaptainAccountAndProfileByAdminRequest $request): string|DeleteCaptainAccountAndProfileByAdminResponse
    {
        return $this->captainEraserService->deleteCaptainAccountAndProfileByAdmin($request);
    }

    public function getLastThreeActiveCaptainsProfilesForAdmin(): array
    {
        $captainsProfiles = $this->adminCaptainManager->getLastThreeActiveCaptainsProfilesForAdmin();

        if (! empty($captainsProfiles)) {
            foreach ($captainsProfiles as $key => $value) {
                $captainsProfiles[$key]['images'] = $this->uploadFileHelperService->getImageParams($value['images']);
            }
        }

        return $captainsProfiles;
    }

    public function getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByAdmin(): array
    {
        return $this->adminCaptainManager->getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByAdmin();
    }

    public function getCaptainsRatingsForAdmin(): array
    {
        return $this->adminCaptainManager->getCaptainsRatingsForAdmin();
    }

    public function getCaptainsWhoDeliveredOrdersDuringSpecificTime(CaptainWithDeliveredOrdersDuringSpecificTimeFilterByAdminRequest $request): array
    {
        return $this->adminCaptainManager->getCaptainsWhoDeliveredOrdersDuringSpecificTime($request);
    }

    // FOR DEBUG ISSUES
//    public function getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByTester(?string $customizedTimezone): array
//    {
//        return $this->adminCaptainManager->getActiveCaptainsWithDeliveredOrdersCountInCurrentFinancialCycleByTester($customizedTimezone);
//    }

    public function getCaptainProfileEntityByIdForAdmin(int $captainProfileId): ?CaptainEntity
    {
        return $this->adminCaptainManager->getCaptainProfileById($captainProfileId);
    }

    public function updateCaptainProfileCompleteAccountStatusByAdmin(CompleteAccountStatusUpdateByAdminRequest $request): CaptainEntity|string
    {
        return $this->adminCaptainManager->updateCaptainProfileCompleteAccountStatusByAdmin($request);
    }

    public function createCaptainFinancialDueByAdminIfNotAnActiveOneExist(int $captainProfileId): CaptainFinancialDuesEntity
    {
        return $this->captainFinancialDuesService->createCaptainFinancialDueByAdminIfNotAnActiveOneExist($captainProfileId);
    }
}
