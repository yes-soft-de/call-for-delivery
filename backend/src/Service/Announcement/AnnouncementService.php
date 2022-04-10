<?php

namespace App\Service\Announcement;

use App\AutoMapping;
use App\Entity\AnnouncementEntity;
use App\Manager\Announcement\AnnouncementManager;
use App\Request\Announcement\AnnouncementCreateRequest;
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
}
