<?php

namespace App\Manager\Announcement;

use App\AutoMapping;
use App\Constant\Announcement\AnnouncementResultConstant;
use App\Constant\Announcement\AnnouncementStatusConstant;
use App\Entity\AnnouncementEntity;
use App\Manager\Image\ImageManager;
use App\Manager\Supplier\SupplierProfileManager;
use App\Repository\AnnouncementEntityRepository;
use App\Request\Announcement\AnnouncementCreateRequest;
use App\Request\Announcement\AnnouncementFilterBySupplierRequest;
use App\Request\Announcement\AnnouncementStatusUpdateRequest;
use App\Request\Announcement\AnnouncementUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AnnouncementManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private SupplierProfileManager $supplierProfileManager;
    private ImageManager $imageManager;
    private AnnouncementEntityRepository $announcementEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, SupplierProfileManager $supplierProfileManager, ImageManager $imageManager,
                                AnnouncementEntityRepository $announcementEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->supplierProfileManager = $supplierProfileManager;
        $this->imageManager = $imageManager;
        $this->announcementEntityRepository = $announcementEntityRepository;
    }

    public function createAnnouncement(AnnouncementCreateRequest $request): AnnouncementEntity
    {
        $request->setSupplier($this->supplierProfileManager->getSupplierProfileEntityBySupplierId($request->getSupplier()));

        $announcementEntity = $this->autoMapping->map(AnnouncementCreateRequest::class, AnnouncementEntity::class, $request);

        $announcementEntity->setStatus(AnnouncementStatusConstant::ACTIVE_ANNOUNCEMENT_STATUS);

        $this->entityManager->persist($announcementEntity);
        $this->entityManager->flush();

        if (! empty($request->getImagesArray())) {
            $this->createAnnouncementImages($request->getImagesArray(), $announcementEntity);
        }

        return $announcementEntity;
    }

    public function createAnnouncementImages(array $images, AnnouncementEntity $announcementEntity): array
    {
        return $this->imageManager->createAnnouncementImages($images, $announcementEntity);
    }

    public function updateAnnouncement(AnnouncementUpdateRequest $request): string|AnnouncementEntity
    {
        $announcementEntity = $this->announcementEntityRepository->find($request->getId());

        if (! $announcementEntity) {
            return AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST;
        }

        if (! empty($request->getImages())) {
            $request->setImages($this->createAnnouncementImages($request->getImages(), $announcementEntity));
        }

        $announcementEntity = $this->autoMapping->mapToObject(AnnouncementUpdateRequest::class, AnnouncementEntity::class, $request, $announcementEntity);

        $this->entityManager->flush();

        return $announcementEntity;
    }

    public function createOrUpdateAnnouncementImages(array $images, AnnouncementEntity $announcementEntity): array
    {
        return $this->imageManager->createOrUpdateAnnouncementImages($images, $announcementEntity);
    }

    public function updateAnnouncementStatus(AnnouncementStatusUpdateRequest $request): string|AnnouncementEntity
    {
        $announcementEntity = $this->announcementEntityRepository->find($request->getId());

        if (! $announcementEntity) {
            return AnnouncementResultConstant::ANNOUNCEMENT_NOT_EXIST;
        }

        $announcementEntity = $this->autoMapping->mapToObject(AnnouncementStatusUpdateRequest::class, AnnouncementEntity::class, $request, $announcementEntity);

        $this->entityManager->flush();

        return $announcementEntity;
    }

    public function getAnnouncementEntityById(int $announcementId): ?AnnouncementEntity
    {
        return $this->announcementEntityRepository->find($announcementId);
    }

    public function filterAnnouncementsBySupplier(AnnouncementFilterBySupplierRequest $request): array
    {
        return $this->announcementEntityRepository->filterAnnouncementsBySupplier($request);
    }

    /**
     * for display other announcements for the supplier
     */
    public function getOtherSuppliersAnnouncementBySupplier(int $supplierId): array
    {
        return $this->announcementEntityRepository->getOtherSuppliersAnnouncementBySupplier($supplierId);
    }
}
