<?php

namespace App\Service\Admin\Package;

use App\AutoMapping;
use App\Constant\Package\PackageCategoryConstant;
use App\Entity\PackageCategoryEntity;
use App\Manager\Admin\Package\AdminPackageCategoryManager;
use App\Request\Admin\Package\PackageCategoryCreateRequest;
use App\Response\Admin\Package\PackageAndCategoryForAdminGetResponse;
use App\Response\Admin\Package\PackageCategoryCreateResponse;
use App\Response\Admin\Package\PackageCategoryGetResponse;

class AdminPackageCategoryService
{
    private AutoMapping $autoMapping;
    private AdminPackageCategoryManager $adminPackageCategoryManager;
    private AdminPackageService $adminPackageService;

    public function __construct(AutoMapping $autoMapping, AdminPackageCategoryManager $adminPackageCategoryManager, AdminPackageService $adminPackageService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminPackageCategoryManager = $adminPackageCategoryManager;
        $this->adminPackageService = $adminPackageService;
    }

    public function createPackageCategory(PackageCategoryCreateRequest $request): PackageCategoryCreateResponse
    {
        $packageCategory = $this->adminPackageCategoryManager->createPackageCategory($request);

        return $this->autoMapping->map(PackageCategoryEntity::class, PackageCategoryCreateResponse::class, $packageCategory);
    }

    public function updatePackageCategory($request): string|PackageCategoryGetResponse
    {
        $packageCategory = $this->adminPackageCategoryManager->updatePackageCategory($request);

        if($packageCategory === PackageCategoryConstant::PACKAGE_CATEGORY_NOT_EXIST) {
            return PackageCategoryConstant::PACKAGE_CATEGORY_NOT_EXIST;

        } else {
            return $this->autoMapping->map(PackageCategoryEntity::class, PackageCategoryGetResponse::class, $packageCategory);
        }
    }

    public function getAllPackagesCategories(): ?array
    {
        $response = [];

        $packageCategories = $this->adminPackageCategoryManager->getAllPackagesCategories();

        foreach ($packageCategories as $packageCategory) {

            $packageCategory['packages'] = $this->adminPackageService->getPackagesByCategoryId($packageCategory['id']);

            $response[] = $this->autoMapping->map("array", PackageAndCategoryForAdminGetResponse::class, $packageCategory);
        }

        return $response;
    }
}
