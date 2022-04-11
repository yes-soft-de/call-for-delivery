<?php

namespace App\Manager\Admin\SupplierProfile;

use App\AutoMapping;
use App\Constant\Supplier\SupplierProfileConstant;
use App\Entity\SupplierProfileEntity;
use App\Manager\Admin\SupplierCategory\AdminSupplierCategoryManager;
use App\Manager\Image\ImageManager;
use App\Repository\SupplierProfileEntityRepository;
use App\Request\Admin\SupplierProfile\SupplierProfileFilterByAdminRequest;
use App\Request\Admin\SupplierProfile\SupplierProfileStatusUpdateByAdminRequest;
use App\Request\Admin\SupplierProfile\SupplierProfileUpdateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminSupplierProfileManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private AdminSupplierCategoryManager $adminSupplierCategoryManager;
    private ImageManager $imageManager;
    private SupplierProfileEntityRepository $supplierProfileEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, AdminSupplierCategoryManager $adminSupplierCategoryManager, ImageManager $imageManager,
                                SupplierProfileEntityRepository $supplierProfileEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->adminSupplierCategoryManager = $adminSupplierCategoryManager;
        $this->imageManager = $imageManager;
        $this->supplierProfileEntityRepository = $supplierProfileEntityRepository;
    }

    public function updateSupplierProfileStatusByAdmin(SupplierProfileStatusUpdateByAdminRequest $request): string|SupplierProfileEntity
    {
        $supplierProfileEntity = $this->supplierProfileEntityRepository->find($request->getId());

        if (! $supplierProfileEntity) {
            return SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST;
        }

        $supplierProfileEntity = $this->autoMapping->mapToObject(SupplierProfileStatusUpdateByAdminRequest::class, SupplierProfileEntity::class,
            $request, $supplierProfileEntity);

        $this->entityManager->flush();

        return $supplierProfileEntity;
    }

    public function filterSupplierProfileByAdmin(SupplierProfileFilterByAdminRequest $request): array
    {
        return $this->supplierProfileEntityRepository->filterSupplierProfileByAdmin($request);
    }

    public function updateSupplierProfileByAdmin(SupplierProfileUpdateByAdminRequest $request): string|SupplierProfileEntity
    {
        $supplierProfileEntity = $this->supplierProfileEntityRepository->find($request->getId());

        if (! $supplierProfileEntity) {
            return SupplierProfileConstant::SUPPLIER_PROFILE_NOT_EXIST;
        }

        $request->setSupplierCategory($this->adminSupplierCategoryManager->getSupplierCategoryEntityByCategoryId($request->getSupplierCategory()));

        if (! empty($request->getImages())) {
            $request->setImages($this->createOrUpdateSupplierProfileImage($request->getImages(), $supplierProfileEntity));
        }

        $supplierProfileEntity = $this->autoMapping->mapToObject(SupplierProfileUpdateByAdminRequest::class, SupplierProfileEntity::class,
            $request, $supplierProfileEntity);

        $this->entityManager->flush();

        return $supplierProfileEntity;
    }

    public function createOrUpdateSupplierProfileImage(array $images, SupplierProfileEntity $supplierProfileEntity): array
    {
        return $this->imageManager->createOrUpdateSupplierProfileImages($images, $supplierProfileEntity);
    }
}
