<?php

namespace App\Service\Package;

use App\AutoMapping;
use App\Entity\PackageCategoryEntity;
use App\Manager\Package\PackageCategoryManager;
use App\Request\Package\PackageCategoryCreateRequest;
use App\Response\Package\PackageCategoryResponse;
use Doctrine\ORM\NonUniqueResultException;

class PackageCategoryService
{
    public function __construct(private AutoMapping $autoMapping, private PackageCategoryManager $packageManager)
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

     public function updatePackage($request): PackageResponse
     {
         $result = $this->packageManager->updatePackage($request);

         return $this->autoMapping->map(PackageEntity::class, PackageResponse::class, $result);
     }
}
