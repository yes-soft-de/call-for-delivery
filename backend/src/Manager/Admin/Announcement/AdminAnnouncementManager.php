<?php

namespace App\Manager\Admin\Announcement;

use App\AutoMapping;
use App\Constant\Announcement\AnnouncementResultConstant;
use App\Entity\AnnouncementEntity;
use App\Repository\AnnouncementEntityRepository;
use App\Request\Admin\Announcement\AnnouncementAdministrationStatusUpdateRequest;
use App\Request\Admin\Announcement\AnnouncementFilterByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminAnnouncementManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private AnnouncementEntityRepository $announcementEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, AnnouncementEntityRepository $announcementEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->announcementEntityRepository = $announcementEntityRepository;
    }

    public function updateAnnouncementAdministrationStatus(AnnouncementAdministrationStatusUpdateRequest $request): string|AnnouncementEntity
    {
        $announcementEntity = $this->announcementEntityRepository->find($request->getId());

        if (! $announcementEntity) {
            return AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST;
        }

        $announcementEntity = $this->autoMapping->mapToObject(AnnouncementAdministrationStatusUpdateRequest::class, AnnouncementEntity::class,
            $request, $announcementEntity);

        $this->entityManager->flush();

        return $announcementEntity;
    }

    public function filterAnnouncementsByAdmin(AnnouncementFilterByAdminRequest $request): array
    {
        return $this->announcementEntityRepository->filterAnnouncementsByAdmin($request);
    }
}
