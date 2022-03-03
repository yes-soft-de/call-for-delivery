<?php

namespace App\Service\Package;

use App\AutoMapping;
use App\Entity\PackageCategoryEntity;
use App\Manager\Package\PackageCategoryManager;
use App\Response\Package\PackageCategoryResponse;
use App\Response\Package\PackageCategoriesAndPackagesResponse;

class PackageCategoryService
{
    private AutoMapping $autoMapping;
    private PackageCategoryManager $packageCategoryManager;
    private PackageService $packageService;

    public function __construct(AutoMapping $autoMapping, PackageCategoryManager $packageCategoryManager, PackageService $packageService)
    {
        $this->autoMapping = $autoMapping;
        $this->packageCategoryManager = $packageCategoryManager;
        $this->packageService = $packageService;
    }

    public function getPackageCategoryById(int $id): ?PackageCategoryResponse
    {
       $packageCategory = $this->packageCategoryManager->getPackageCategoryById($id);
      
       return $this->autoMapping->map(PackageCategoryEntity::class, PackageCategoryResponse::class, $packageCategory);
    }

    public function getAllPackagesCategoriesAndPackagesForStore(): ?array
    {
        $response = [];

        $packageCategories = $this->packageCategoryManager->getAllPackagesCategories();

        foreach ($packageCategories as $packageCategory) {

            $packageCategory['packages'] = $this->packageService->getAllPackagesCategoriesAndPackagesForStore($packageCategory['id']);

            $response[] = $this->autoMapping->map("array", PackageCategoriesAndPackagesResponse::class, $packageCategory);
        }

        return $response;
    }
}
