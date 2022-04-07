<?php

namespace App\Service\Admin\SupplierCategory;

use App\AutoMapping;
use App\Constant\Image\ImageEntityTypeConstant;
use App\Constant\Image\ImageUseAsConstant;
use App\Entity\SupplierCategoryEntity;
use App\Manager\Admin\SupplierCategory\AdminSupplierCategoryManager;
use App\Request\Admin\SupplierCategory\SupplierCategoryCreateByAdminRequest;
use App\Request\Image\ImageCreateRequest;
use App\Response\Admin\SupplierCategory\SupplierCategoryCreateByAdminResponse;
use App\Service\Image\ImageService;

class AdminSupplierCategoryService
{
    private AutoMapping $autoMapping;
    private AdminSupplierCategoryManager $adminSupplierCategoryManager;
    private ImageService $imageService;

    public function __construct(AutoMapping $autoMapping, AdminSupplierCategoryManager $adminSupplierCategoryManager, ImageService $imageService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminSupplierCategoryManager = $adminSupplierCategoryManager;
        $this->imageService = $imageService;
    }

    public function createSupplierCategoryByAdmin(SupplierCategoryCreateByAdminRequest $request): SupplierCategoryCreateByAdminResponse
    {
        $supplierCategoryResult = $this->adminSupplierCategoryManager->createSupplierCategoryByAdmin($request);

        if ($request->getImage() !== null && $request->getImage() !== "") {
            $this->createSupplierCategoryImage($request->getImage(), $supplierCategoryResult->getId());
        }

        return $this->autoMapping->map(SupplierCategoryEntity::class, SupplierCategoryCreateByAdminResponse::class, $supplierCategoryResult);
    }

    public function createSupplierCategoryImage(string $imagePath, int $itemId): void
    {
        $imageCreateRequest = new ImageCreateRequest();

        $imageCreateRequest->setImagePath($imagePath);
        $imageCreateRequest->setItemId($itemId);
        $imageCreateRequest->setEntityType(ImageEntityTypeConstant::ENTITY_TYPE_SUPPLIER_CATEGORY);
        $imageCreateRequest->setUsedAs(ImageUseAsConstant::IMAGE_USE_AS_SUPPLIER_CATEGORY);

        $this->imageService->create($imageCreateRequest);
    }
}
