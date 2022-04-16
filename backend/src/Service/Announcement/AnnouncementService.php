<?php

namespace App\Service\Announcement;

use App\AutoMapping;
use App\Constant\Announcement\AnnouncementResultConstant;
use App\Entity\AnnouncementEntity;
use App\Manager\Announcement\AnnouncementManager;
use App\Request\Announcement\AnnouncementCreateRequest;
use App\Request\Announcement\AnnouncementFilterBySupplierRequest;
use App\Request\Announcement\AnnouncementStatusUpdateRequest;
use App\Request\Announcement\AnnouncementUpdateRequest;
use App\Response\Announcement\AnnouncementCreateResponse;
use App\Response\Announcement\AnnouncementFilterBySupplierResponse;
use App\Response\Announcement\OtherAnnouncementsGetResponse;
use App\Service\FileUpload\UploadFileHelperService;

class AnnouncementService
{
    private AutoMapping $autoMapping;
    private AnnouncementManager $announcementManager;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, AnnouncementManager $announcementManager, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->announcementManager = $announcementManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
    }

    public function createAnnouncement(AnnouncementCreateRequest $request): AnnouncementCreateResponse
    {
        $announcementResult = $this->announcementManager->createAnnouncement($request);

        return $this->autoMapping->map(AnnouncementEntity::class, AnnouncementCreateResponse::class, $announcementResult);
    }

    public function updateAnnouncement(AnnouncementUpdateRequest $request): string|AnnouncementCreateResponse
    {
        $announcementResult = $this->announcementManager->updateAnnouncement($request);

        if ($announcementResult === AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST) {
            return AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST;
        }

        return $this->autoMapping->map(AnnouncementEntity::class, AnnouncementCreateResponse::class, $announcementResult);
    }

    public function updateAnnouncementStatus(AnnouncementStatusUpdateRequest $request): string|AnnouncementCreateResponse
    {
        $announcementResult = $this->announcementManager->updateAnnouncementStatus($request);

        if ($announcementResult === AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST) {
            return AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST;
        }

        return $this->autoMapping->map(AnnouncementEntity::class, AnnouncementCreateResponse::class, $announcementResult);
    }

    public function filterAnnouncementsBySupplier(AnnouncementFilterBySupplierRequest $request): array
    {
        $response = [];

        $announcements = $this->announcementManager->filterAnnouncementsBySupplier($request);

        if ($announcements) {
            foreach ($announcements as $key=>$value) {
                $response[] = $this->autoMapping->map(AnnouncementEntity::class, AnnouncementFilterBySupplierResponse::class, $value);

                $response[$key]->images = $this->customizeAnnouncementImages($response[$key]->images->toArray());
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

    public function getOtherSuppliersAnnouncementBySupplier(int $supplierId): array
    {
        $response = [];

        $announcements = $this->announcementManager->getOtherSuppliersAnnouncementBySupplier($supplierId);

        if ($announcements) {
            foreach ($announcements as $key=>$value) {
                $response[] = $this->autoMapping->map(AnnouncementEntity::class, OtherAnnouncementsGetResponse::class, $value);

                $response[$key]->images = $this->customizeAnnouncementImages($response[$key]->images->toArray());
            }
        }

        return $response;
    }
}
