<?php

namespace App\Manager\Admin\AdminAnnouncementImage;

use App\AutoMapping;
use App\Entity\AdminAnnouncementImageEntity;
use App\Repository\AdminAnnouncementImageEntityRepository;
use App\Request\Admin\AdminAnnouncementImage\AdminAnnouncementImageCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminAnnouncementImageManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private AdminAnnouncementImageEntityRepository $adminAnnouncementImageEntityRepository
    )
    {
    }

    /**
     * Creates the image/s of the admin notification to user
     */
    public function createAdminAnnouncementImage(AdminAnnouncementImageCreateRequest $request): AdminAnnouncementImageEntity
    {
        $adminAnnouncementImageEntity = $this->autoMapping->map(AdminAnnouncementImageCreateRequest::class,
            AdminAnnouncementImageEntity::class, $request);

        $this->entityManager->persist($adminAnnouncementImageEntity);
        $this->entityManager->flush();

        return $adminAnnouncementImageEntity;
    }

    /**
     * Deletes the image/s of a specific admin notification to user - if exist
     */
    public function deleteAdminAnnouncementImageByAdminNotificationToUserId(int $adminNotificationToUserId): array
    {
        $images = $this->adminAnnouncementImageEntityRepository->findBy(['AdminNotificationToUser' => $adminNotificationToUserId]);

        if ($images) {
            if (count($images) > 0) {
                foreach ($images as $adminAnnouncementImageEntity) {
                    $this->entityManager->remove($adminAnnouncementImageEntity);
                    $this->entityManager->flush();
                }
            }
        }

        return $images;
    }
}
