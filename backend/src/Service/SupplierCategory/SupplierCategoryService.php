<?php

namespace App\Service\SupplierCategory;

use App\AutoMapping;
use App\Manager\SupplierCategory\SupplierCategoryManager;
use App\Response\SupplierCategory\SupplierCategoryForStoreOwnerGetResponse;
use App\Response\SupplierCategory\SupplierCategoryGetResponse;
use App\Service\FileUpload\UploadFileHelperService;

class SupplierCategoryService
{
    private AutoMapping $autoMapping;
    private SupplierCategoryManager $supplierCategoryManager;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, SupplierCategoryManager $supplierCategoryManager, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->supplierCategoryManager = $supplierCategoryManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
    }

    public function getAllActiveSupplierCategories(): array
    {
        $response = [];

        $supplierCategories = $this->supplierCategoryManager->getAllActiveSupplierCategories();

        if (! empty($supplierCategories)) {
            foreach ($supplierCategories as $supplierCategory) {
                $supplierCategory['image'] = $this->uploadFileHelperService->getImageParams($supplierCategory['image']);

                $response[] = $this->autoMapping->map("array", SupplierCategoryGetResponse::class, $supplierCategory);
            }
        }

        return $response;
    }

    public function getAllActiveSupplierCategoriesForStoreOwner(): array
    {
        $response = [];

        $supplierCategories = $this->supplierCategoryManager->getAllActiveSupplierCategoriesForStoreOwner();

        if (! empty($supplierCategories)) {
            foreach ($supplierCategories as $supplierCategory) {
                $supplierCategory['image'] = $this->uploadFileHelperService->getImageParams($supplierCategory['image']);

                $response[] = $this->autoMapping->map("array", SupplierCategoryForStoreOwnerGetResponse::class, $supplierCategory);
            }
        }

        return $response;
    }
}