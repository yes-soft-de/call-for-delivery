<?php

namespace App\Service\Admin\Announcement;

use App\AutoMapping;
use App\Constant\Announcement\AnnouncementResultConstant;
use App\Entity\AnnouncementEntity;
use App\Entity\SupplierProfileEntity;
use App\Manager\Admin\Announcement\AdminAnnouncementManager;
use App\Request\Admin\Announcement\AnnouncementAdministrationStatusUpdateRequest;
use App\Request\Admin\Announcement\AnnouncementFilterByAdminRequest;
use App\Response\Admin\Announcement\AnnouncementGetByAdminResponse;
use App\Response\Admin\Announcement\AnnouncementUpdateByAdminResponse;
use App\Service\FileUpload\UploadFileHelperService;

class AdminAnnouncementService
{
    private AutoMapping $autoMapping;
    private AdminAnnouncementManager $adminAnnouncementManager;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, AdminAnnouncementManager $adminAnnouncementManager, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminAnnouncementManager = $adminAnnouncementManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
    }

    public function updateAnnouncementAdministrationStatus(AnnouncementAdministrationStatusUpdateRequest $request): string|AnnouncementUpdateByAdminResponse
    {
        $announcementResult = $this->adminAnnouncementManager->updateAnnouncementAdministrationStatus($request);

        if ($announcementResult === AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST) {
            return AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST;
        }

        return $this->autoMapping->map(AnnouncementEntity::class, AnnouncementUpdateByAdminResponse::class, $announcementResult);
    }

    public function filterAnnouncementsByAdmin(AnnouncementFilterByAdminRequest $request): array
    {
        $response = [];

        $announcements = $this->adminAnnouncementManager->filterAnnouncementsByAdmin($request);

        if ($announcements) {
            foreach ($announcements as $key=>$value) {
                $response[] = $this->autoMapping->map(AnnouncementEntity::class, AnnouncementGetByAdminResponse::class, $value);

                $response[$key]->images = $this->customizeAnnouncementImages($response[$key]->images->toArray());

                $response[$key]->supplier = $this->getSpecificSupplierFields($response[$key]->supplier);
            }
        }

        return $response;
    }

    public function customizeAnnouncementImages(array $imageEntitiesArray): ?array
    {
        $response = [];

        if (! empty($imageEntitiesArray)) {
            foreach ($imageEntitiesArray as $imageEntity) {
                $response[] = $this->uploadFileHelperService->getImageParams($imageEntity->getImagePath());
            }

            return $response;

        } else {
            return null;
        }
    }

    public function getSpecificSupplierFields(SupplierProfileEntity $supplierProfileEntity): array
    {
        $response = [];

        $response['id'] = $supplierProfileEntity->getId();
        $response['supplierName'] = $supplierProfileEntity->getSupplierName();

        return $response;
    }
}
