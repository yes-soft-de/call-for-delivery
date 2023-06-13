<?php

namespace App\Manager\Admin\AnnouncementImage;

use App\AutoMapping;
use App\Entity\AnnouncementImageEntity;
use App\Repository\AnnouncementImageEntityRepository;
use App\Request\Admin\AnnouncementImage\AnnouncementImageCreateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminAnnouncementImageManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private AnnouncementImageEntityRepository $announcementImageEntityRepository
    )
    {
    }

    /**
     * Creates the image/s of the admin notification to user
     */
    public function createAnnouncementImageByAdmin(AnnouncementImageCreateByAdminRequest $request): AnnouncementImageEntity
    {
        $announcementImageEntity = $this->autoMapping->map(AnnouncementImageCreateByAdminRequest::class,
            AnnouncementImageEntity::class, $request);

        $this->entityManager->persist($announcementImageEntity);
        $this->entityManager->flush();

        return $announcementImageEntity;
    }

    /**
     * Deletes the image/s of a specific admin notification to user - if exist
     */
    public function deleteAnnouncementImageByAdminNotificationToUserId(int $adminNotificationToUserId): array
    {
        $images = $this->announcementImageEntityRepository->findBy(['AdminNotificationToUser' => $adminNotificationToUserId]);

        if ($images) {
            if (count($images) > 0) {
                foreach ($images as $announcementImageEntity) {
                    $this->entityManager->remove($announcementImageEntity);
                    $this->entityManager->flush();
                }
            }
        }

        return $images;
    }

    /**
     * Get AdminAnnouncementImageEntity by id or null
     */
    public function getAnnouncementImageByIdForAdmin(int $id): ?AnnouncementImageEntity
    {
        return $this->announcementImageEntityRepository->findOneBy(['id' => $id]);
    }

    public function deleteAnnouncementImageById(int $id): ?AnnouncementImageEntity
    {
        $announcementImageEntity = $this->announcementImageEntityRepository->findOneBy(['id' => $id]);

        if ($announcementImageEntity) {
            $this->entityManager->remove($announcementImageEntity);
            $this->entityManager->flush();
        }

        return $announcementImageEntity;
    }
}
