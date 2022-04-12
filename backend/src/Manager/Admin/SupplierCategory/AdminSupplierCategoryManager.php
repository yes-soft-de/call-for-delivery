<?php

namespace App\Manager\Admin\SupplierCategory;

use App\AutoMapping;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Constant\SupplierCategory\SupplierCategoryResultConstant;
use App\Entity\SupplierCategoryEntity;
use App\Manager\Image\ImageManager;
use App\Repository\SupplierCategoryEntityRepository;
use App\Request\Admin\SupplierCategory\SupplierCategoryCreateByAdminRequest;
use App\Request\Admin\SupplierCategory\SupplierCategoryStatusUpdateByAdminRequest;
use App\Request\Admin\SupplierCategory\SupplierCategoryUpdateByAdminRequest;
use App\Request\Image\ImageCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminSupplierCategoryManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private ImageManager $imageManager;
    private SupplierCategoryEntityRepository $supplierCategoryEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ImageManager $imageManager, SupplierCategoryEntityRepository $supplierCategoryEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->imageManager = $imageManager;
        $this->supplierCategoryEntityRepository = $supplierCategoryEntityRepository;
    }

    public function createSupplierCategoryByAdmin(SupplierCategoryCreateByAdminRequest $request): SupplierCategoryEntity
    {
        $supplierCategoryEntity = $this->autoMapping->map(SupplierCategoryCreateByAdminRequest::class, SupplierCategoryEntity::class, $request);

        $this->entityManager->persist($supplierCategoryEntity);
        $this->entityManager->flush();

        if ($request->getImage() !== null && $request->getImage() !== "") {
            $this->createSupplierCategoryImage($request->getImage(), $supplierCategoryEntity->getId());
        }

        return $supplierCategoryEntity;
    }

    public function updateSupplierCategoryByAdmin(SupplierCategoryUpdateByAdminRequest $request): string|SupplierCategoryEntity
    {
        $supplierCategoryEntity = $this->supplierCategoryEntityRepository->find($request->getId());

        if (! $supplierCategoryEntity) {
            return SupplierCategoryResultConstant::SUPPLIER_CATEGORY_NOT_EXIST;

        } else {
            $supplierCategoryEntity = $this->autoMapping->mapToObject(SupplierCategoryUpdateByAdminRequest::class, SupplierCategoryEntity::class,
                $request, $supplierCategoryEntity);

            if ($request->getImage() !== null && $request->getImage() !== "") {
                $this->createOrUpdateSupplierCategoryImage($request->getImage(), $supplierCategoryEntity->getId());
            }

            $this->entityManager->flush();

            return $supplierCategoryEntity;
        }
    }

    public function updateSupplierCategoryStatusByAdmin(SupplierCategoryStatusUpdateByAdminRequest $request): string|SupplierCategoryEntity
    {
        $supplierCategoryEntity = $this->supplierCategoryEntityRepository->find($request->getId());

        if (! $supplierCategoryEntity) {
            return SupplierCategoryResultConstant::SUPPLIER_CATEGORY_NOT_EXIST;

        } else {
            $supplierCategoryEntity = $this->autoMapping->mapToObject(SupplierCategoryStatusUpdateByAdminRequest::class, SupplierCategoryEntity::class,
                $request, $supplierCategoryEntity);

            $this->entityManager->flush();

            return $supplierCategoryEntity;
        }
    }

    public function createSupplierCategoryImage(string $imagePath, int $itemId): void
    {
        $imageCreateRequest = new ImageCreateRequest();

        $imageCreateRequest->setImagePath($imagePath);
        $imageCreateRequest->setItemId($itemId);
        $imageCreateRequest->setEntityType(ImageEntityTypeConstant::ENTITY_TYPE_SUPPLIER_CATEGORY);
        $imageCreateRequest->setUsedAs(ImageUseAsConstant::IMAGE_USE_AS_SUPPLIER_CATEGORY);

        $this->imageManager->create($imageCreateRequest);
    }

    public function createOrUpdateSupplierCategoryImage(string $imagePath, int $itemId)
    {
        $this->imageManager->createImageOrUpdate($imagePath, $itemId, ImageEntityTypeConstant::ENTITY_TYPE_SUPPLIER_CATEGORY, ImageUseAsConstant::IMAGE_USE_AS_SUPPLIER_CATEGORY);
    }

    public function getAllSupplierCategoriesForAdmin(): array
    {
        return $this->supplierCategoryEntityRepository->getAllSupplierCategoriesForAdmin();
    }

    public function getSupplierCategoryEntityByCategoryId(int $supplierCategoryId): ?SupplierCategoryEntity
    {
        return $this->supplierCategoryEntityRepository->find($supplierCategoryId);
    }
}
