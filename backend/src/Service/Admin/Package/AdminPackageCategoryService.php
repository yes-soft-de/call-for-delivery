<?php

namespace App\Service\Admin\Package;

use App\AutoMapping;
use App\Constant\Package\PackageCategoryConstant;
use App\Entity\PackageCategoryEntity;
use App\Manager\Admin\Package\AdminPackageCategoryManager;
use App\Request\Admin\Package\PackageCategoryCreateByAdminRequest;
use App\Request\Admin\Package\PackageCategoryStatusUpdateByAdminRequest;
use App\Response\Admin\Package\PackageAndCategoryForAdminGetResponse;
use App\Response\Admin\Package\PackageCategoryCreateByAdminResponse;
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

    public function createPackageCategoryByAdmin(PackageCategoryCreateByAdminRequest $request): PackageCategoryCreateByAdminResponse
    {
        $packageCategoryResult = $this->adminPackageCategoryManager->createPackageCategoryByAdmin($request);

        return $this->autoMapping->map(PackageCategoryEntity::class, PackageCategoryCreateByAdminResponse::class, $packageCategoryResult);
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

    public function updateAllPackagesCategoriesStatus(int $status): array
    {
        $response = [];

        $packagesCategoriesEntities = $this->adminPackageCategoryManager->updateAllPackagesCategoriesStatus($status);

        if (count($packagesCategoriesEntities) > 0) {
            foreach ($packagesCategoriesEntities as $packageCategoryEntity) {
                $response[] = $this->autoMapping->map(PackageCategoryEntity::class, PackageCategoryGetResponse::class, $packageCategoryEntity);
            }
        }

        return $response;
    }

    public function updatePackageCategoryStatusById(PackageCategoryStatusUpdateByAdminRequest $request): ?PackageCategoryGetResponse
    {
        $packageCategoryEntity = $this->adminPackageCategoryManager->updatePackageCategoryStatusById($request);

        if (! $packageCategoryEntity) {
            return $packageCategoryEntity;
        }

        return $this->autoMapping->map(PackageCategoryEntity::class, PackageCategoryGetResponse::class, $packageCategoryEntity);
    }
}
