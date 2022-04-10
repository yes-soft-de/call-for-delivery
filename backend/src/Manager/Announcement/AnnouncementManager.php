<?php

namespace App\Manager\Announcement;

use App\AutoMapping;
use App\Constant\Announcement\AnnouncementStatusConstant;
use App\Entity\AnnouncementEntity;
use App\Manager\Image\ImageManager;
use App\Manager\Supplier\SupplierProfileManager;
use App\Request\Announcement\AnnouncementCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AnnouncementManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private SupplierProfileManager $supplierProfileManager;
    private ImageManager $imageManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, SupplierProfileManager $supplierProfileManager, ImageManager $imageManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->supplierProfileManager = $supplierProfileManager;
        $this->imageManager = $imageManager;
    }

    public function createAnnouncement(AnnouncementCreateRequest $request): AnnouncementEntity
    {
        $request->setSupplier($this->supplierProfileManager->getSupplierProfileEntityBySupplierId($request->getSupplier()));

        $announcementEntity = $this->autoMapping->map(AnnouncementCreateRequest::class, AnnouncementEntity::class, $request);

        $announcementEntity->setStatus(AnnouncementStatusConstant::ACTIVE_ANNOUNCEMENT_STATUS);

        $this->entityManager->persist($announcementEntity);
        $this->entityManager->flush();

        if (! empty($request->getImagesArray())) {
//            $announcementEntity->setImages($this->createAnnouncementImages($request->getImages(), $announcementEntity));
            $this->createAnnouncementImages($request->getImagesArray(), $announcementEntity);
        }

        return $announcementEntity;
    }

    public function createAnnouncementImages(array $images, AnnouncementEntity $announcementEntity): array
    {
        return $this->imageManager->createAnnouncementImages($images, $announcementEntity);
    }
}
