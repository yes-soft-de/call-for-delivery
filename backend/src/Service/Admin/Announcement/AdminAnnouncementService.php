<?php

namespace App\Service\Admin\Announcement;

use App\AutoMapping;
use App\Constant\Announcement\AnnouncementResultConstant;
use App\Entity\AnnouncementEntity;
use App\Manager\Admin\Announcement\AdminAnnouncementManager;
use App\Request\Admin\Announcement\AnnouncementAdministrationStatusUpdateRequest;
use App\Response\Admin\Announcement\AnnouncementUpdateByAdminResponse;

class AdminAnnouncementService
{
    private AutoMapping $autoMapping;
    private AdminAnnouncementManager $adminAnnouncementManager;

    public function __construct(AutoMapping $autoMapping, AdminAnnouncementManager $adminAnnouncementManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminAnnouncementManager = $adminAnnouncementManager;
    }

    public function updateAnnouncementAdministrationStatus(AnnouncementAdministrationStatusUpdateRequest $request): string|AnnouncementUpdateByAdminResponse
    {
        $announcementResult = $this->adminAnnouncementManager->updateAnnouncementAdministrationStatus($request);

        if ($announcementResult === AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST) {
            return AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST;
        }

        return $this->autoMapping->map(AnnouncementEntity::class, AnnouncementUpdateByAdminResponse::class, $announcementResult);
    }
}
