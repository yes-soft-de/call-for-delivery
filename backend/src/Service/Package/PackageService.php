<?php

namespace App\Service\Package;

use App\AutoMapping;
use App\Entity\PackageEntity;
use App\Manager\Package\PackageManager;
use App\Request\Package\PackageCreateRequest;
use App\Response\Package\PackageResponse;
use App\Response\Package\PackageActiveResponse;

class PackageService
{
    private $autoMapping;
    private $packageManager;

    public function __construct(AutoMapping $autoMapping, PackageManager $packageManager)
    {
        $this->autoMapping = $autoMapping;
        $this->packageManager = $packageManager;
    }

    public function createPackage(PackageCreateRequest $request): PackageResponse
    {
        $result = $this->packageManager->createPackage($request);

        return $this->autoMapping->map(PackageEntity::class, PackageResponse::class, $result);
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

    public function getAllPackages(): array
    {
        $response = [];

        $items = $this->packageManager->getAllPackages();

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map('array', PackageResponse::class, $item);
        }

        return $response;
    }

    public function getPackageById($id)
    {
       $item = $this->packageManager->getPackageById($id);

       return $this->autoMapping->map("array", PackageResponse::class, $item);
    }
//TODO not completed
    // public function update($request)
    // {
    //     $result = $this->packageManager->update($request);

    //     return $this->autoMapping->map(PackageEntity::class, PackageResponse::class, $result);
    // }
}
