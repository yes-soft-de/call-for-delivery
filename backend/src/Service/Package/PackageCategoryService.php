<?php

namespace App\Service\Package;

use App\AutoMapping;
use App\Entity\PackageCategoryEntity;
use App\Manager\Package\PackageCategoryManager;
use App\Request\Admin\Package\PackageCategoryCreateRequest;
use App\Response\Package\PackageCategoryResponse;
use App\Response\Package\PackageCategoriesAndPackagesResponse;

class PackageCategoryService
{
    public function __construct(private AutoMapping $autoMapping, private PackageCategoryManager $packageCategoryManager, private PackageService $packageService)
    {
    }

    /**
     * @param PackageCategoryCreateRequest $request
     * @return PackageCategoryResponse
     */
    public function createPackageCategory(PackageCategoryCreateRequest $request): PackageCategoryResponse
    {
        $packageCategory = $this->packageCategoryManager->createPackageCategory($request);

        return $this->autoMapping->map(PackageCategoryEntity::class, PackageCategoryResponse::class, $packageCategory);
    }

    /**
     * @param $request
     * @return PackageCategoryResponse|null
     */
    public function updatePackageCategory($request): ?PackageCategoryResponse
    {
        $result = $this->packageCategoryManager->updatePackageCategory($request);

        return $this->autoMapping->map(PackageCategoryEntity::class, PackageCategoryResponse::class, $result);
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
