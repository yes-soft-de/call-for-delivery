<?php

namespace App\Service\Package;

use App\AutoMapping;
use App\Entity\PackageCategoryEntity;
use App\Manager\Package\PackageCategoryManager;
use App\Service\Package\PackageService;
use App\Request\Package\PackageCategoryCreateRequest;
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
        $packageCategory = $this->packageManager->createPackageCategory($request);

        return $this->autoMapping->map(PackageCategoryEntity::class, PackageCategoryResponse::class, $packageCategory);
    }
    
    public function updatePackageCategory($request): PackageCategoryResponse
    {
        $result = $this->packageCategoryManager->updatePackageCategory($request);

        return $this->autoMapping->map(PackageCategoryEntity::class, PackageCategoryResponse::class, $result);
    }

    /**
     * @param $id
     * @return PackageCategoryResponse|null
     */
    public function getPackageCategoryById($id): ?PackageCategoryResponse 
    {
       $packageCategory = $this->packageCategoryManager->getPackageCategoryById($id);

       return $this->autoMapping->map(PackageCategoryEntity::class, PackageCategoryResponse::class, $packageCategory);
    }

    /**
     * @return array|null
     */
    public function getAllPackagesCategoriesAndPackages(): ?array
    {
        $response = [];

        $packageCategories = $this->packageCategoryManager->getAllPackagesCategories();

        foreach ($packageCategories as $packageCategory) {

            $packageCategory['package'] = $this->packageService->getPackagesByCategoryId($packageCategory['id']);

            $response[] = $this->autoMapping->map("array", PackageCategoriesAndPackagesResponse::class, $packageCategory);
        }

        return $response;
    }
}
