<?php

namespace App\Service\Package;

use App\AutoMapping;
use App\Manager\Package\PackageManager;
use App\Response\Package\PackageResponse;
use App\Response\Package\PackageActiveResponse;

class PackageService
{
    private AutoMapping $autoMapping;
    private PackageManager $packageManager;

    public function __construct(AutoMapping $autoMapping, PackageManager $packageManager)
    {
        $this->autoMapping = $autoMapping;
        $this->packageManager = $packageManager;
    }

    public function getActivePackages(): array
    {
        $response = [];

        $items = $this->packageManager->getActivePackages();
        
        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', PackageActiveResponse::class, $item);
        }

        return $response;
    }

    public function getPackageById(int $id): ?PackageResponse
    {
       $item = $this->packageManager->getPackageById($id);

       return $this->autoMapping->map("array", PackageResponse::class, $item);
    }

    /**
     * @param $packageCategory
     * @return array|null
     */
    public function getAllPackagesCategoriesAndPackagesForStore($packageCategory): ?array
    {
        return $this->packageManager->getAllPackagesCategoriesAndPackagesForStore($packageCategory);
    }

    public function getAllPackagesByCategoryId(int $packageCategoryId): ?array
    {
        $response = [];

        $packages = $this->packageManager->getAllPackagesCategoriesAndPackagesForStore($packageCategoryId);

        foreach ($packages as $package) {
            $response[] = $this->autoMapping->map('array', PackageResponse::class, $package);
        }

        return $response;
    }
}
