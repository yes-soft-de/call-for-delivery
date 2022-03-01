<?php

namespace App\Service\Package;

use App\AutoMapping;
use App\Constant\Package\PackageConstant;
use App\Entity\PackageEntity;
use App\Manager\Package\PackageManager;
use App\Request\Package\PackageCreateRequest;
use App\Response\Package\PackageResponse;
use App\Response\Package\PackageActiveResponse;
use Doctrine\ORM\NonUniqueResultException;

class PackageService
{
    private $autoMapping;
    private $packageManager;

    public function __construct(AutoMapping $autoMapping, PackageManager $packageManager)
    {
        $this->autoMapping = $autoMapping;
        $this->packageManager = $packageManager;
    }

    /**
     * @param PackageCreateRequest $request
     * @return PackageResponse
     */
    public function createPackage(PackageCreateRequest $request): PackageResponse
    {
        $result = $this->packageManager->createPackage($request);

        return $this->autoMapping->map(PackageEntity::class, PackageResponse::class, $result);
    }

    /**
     * @return array
     */
    public function getActivePackages(): array
    {
        $response = [];

        $items = $this->packageManager->getActivePackages();
        
        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', PackageActiveResponse::class, $item);
        }

        return $response;
    }

    public function getAllPackages(): array
    {
        $response = [];

        $items = $this->packageManager->getAllPackages();

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', PackageResponse::class, $item);
        }

        return $response;
    }

    /**
     * @param $id
     * @return array|mixed|null
     * @throws NonUniqueResultException
     */
    public function getPackageById($id)
    {
       $item = $this->packageManager->getPackageById($id);

       return $this->autoMapping->map("array", PackageResponse::class, $item);
    }

    public function updatePackage($request): string|PackageResponse
     {
         $packageResult = $this->packageManager->updatePackage($request);

         if($packageResult === PackageConstant::PACKAGE_NOT_EXIST) {
             return $packageResult;
         }

         return $this->autoMapping->map(PackageEntity::class, PackageResponse::class, $packageResult);
     }

    public function updatePackageStatus($request): string|PackageResponse
    {
        $packageResult = $this->packageManager->updatePackageStatus($request);

        if($packageResult === PackageConstant::PACKAGE_NOT_EXIST) {
            return $packageResult;
        }

        return $this->autoMapping->map(PackageEntity::class, PackageResponse::class, $packageResult);
    }
     
    /**
     * @param $packageCategory
     * @return array|null
     */
    public function getPackagesByCategoryIdForAdmin($packageCategory): ?array
    {
        return $this->packageManager->getPackagesByCategoryIdForAdmin($packageCategory);
    }

    /**
     * @param $packageCategory
     * @return array|null
     */
    public function getAllPackagesCategoriesAndPackagesForStore($packageCategory): ?array
    {
        return $this->packageManager->getAllPackagesCategoriesAndPackagesForStore($packageCategory);
    }

    
    /**
     * @param $packageCategory
     * @return array|null
     */
    public function getAllPackagesByCategoryId($packageCategoryId): ?array
    {
        $response = [];

        $packages = $this->packageManager->getAllPackagesCategoriesAndPackagesForStore($packageCategoryId);

        foreach ($packages as $package) {
            $response[] = $this->autoMapping->map('array', PackageResponse::class, $package);
        }

        return $response;
    }
}
