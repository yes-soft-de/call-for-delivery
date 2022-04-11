<?php

namespace App\Service\Announcement;

use App\AutoMapping;
use App\Constant\Announcement\AnnouncementResultConstant;
use App\Entity\AnnouncementEntity;
use App\Manager\Announcement\AnnouncementManager;
use App\Request\Announcement\AnnouncementCreateRequest;
use App\Request\Announcement\AnnouncementStatusUpdateRequest;
use App\Request\Announcement\AnnouncementUpdateRequest;
use App\Response\Announcement\AnnouncementCreateResponse;

class AnnouncementService
{
    private AutoMapping $autoMapping;
    private AnnouncementManager $announcementManager;

    public function __construct(AutoMapping $autoMapping, AnnouncementManager $announcementManager)
    {
        $this->autoMapping = $autoMapping;
        $this->announcementManager = $announcementManager;
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
}
