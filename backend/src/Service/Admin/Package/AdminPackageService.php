<?php

namespace App\Service\Admin\Package;

use App\AutoMapping;
use App\Constant\Package\PackageConstant;
use App\Entity\PackageEntity;
use App\Manager\Admin\Package\AdminPackageManager;
use App\Request\Admin\Package\PackageCreateRequest;
use App\Request\Admin\Package\PackageStatusUpdateRequest;
use App\Request\Admin\Package\PackageUpdateRequest;
use App\Response\Admin\Package\PackageCreateResponse;
use App\Response\Admin\Package\PackageGetResponse;

class AdminPackageService
{
    private AutoMapping $autoMapping;
    private AdminPackageManager $adminPackageManager;

    public function __construct(AutoMapping $autoMapping, AdminPackageManager $adminPackageManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminPackageManager = $adminPackageManager;
    }

    public function createPackage(PackageCreateRequest $request): PackageCreateResponse
    {
        $result = $this->adminPackageManager->createPackage($request);

        return $this->autoMapping->map(PackageEntity::class, PackageCreateResponse::class, $result);
    }

    public function updatePackage(PackageUpdateRequest $request): string|PackageGetResponse
    {
        $packageResult = $this->adminPackageManager->updatePackage($request);

        if($packageResult === PackageConstant::PACKAGE_NOT_EXIST) {
            return $packageResult;

        } else {
            return $this->autoMapping->map(PackageEntity::class, PackageGetResponse::class, $packageResult);
        }
    }

    public function updatePackageStatus(PackageStatusUpdateRequest $request): string|PackageGetResponse
    {
        $packageResult = $this->adminPackageManager->updatePackageStatus($request);

        if($packageResult === PackageConstant::PACKAGE_NOT_EXIST) {
            return $packageResult;

        } else {
            return $this->autoMapping->map(PackageEntity::class, PackageGetResponse::class, $packageResult);
        }
    }

    public function getAllPackages(): array
    {
        $response = [];

        $items = $this->adminPackageManager->getAllPackages();

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', PackageGetResponse::class, $item);
        }

        return $response;
    }

    public function getPackagesByCategoryId(int $packageCategory): ?array
    {
        $response = [];

        $items = $this->adminPackageManager->getPackagesByCategoryId($packageCategory);

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', PackageGetResponse::class, $item);
        }

        return $response;
    }
}
