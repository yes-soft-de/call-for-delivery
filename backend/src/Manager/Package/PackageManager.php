<?php

namespace App\Manager\Package;

use App\Entity\PackageEntity;
use App\Repository\PackageEntityRepository;

class PackageManager
{
    private PackageEntityRepository $packageRepository;

    public function __construct(PackageEntityRepository $packageRepository)
    {
        $this->packageRepository = $packageRepository;
    }

    public function getActivePackages(): ?array
    {
        return $this->packageRepository->getActivePackages();
    }

    public function getPackageById(int $id): ?array
    {
        return $this->packageRepository->getPackageById($id);
    }

    public function getPackage($id)
    {
        return $this->packageRepository->find($id);
    }

    public function getAllPackagesCategoriesAndPackagesForStore(int $packageCategory): ?array
    {
        return $this->packageRepository->getAllPackagesCategoriesAndPackagesForStore($packageCategory);
    }
    
    public function getPackageActiveById($id)
    {
        return $this->packageRepository->getPackageActiveById($id);
    }

    public function getPackageEntityById(int $id): ?PackageEntity
    {
        return $this->packageRepository->findOneBy(['id' => $id]);
    }

}
