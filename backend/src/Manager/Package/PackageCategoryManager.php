<?php

namespace App\Manager\Package;

use App\AutoMapping;
use App\Entity\PackageCategoryEntity;
use App\Repository\PackageCategoryEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class PackageCategoryManager
{
    private PackageCategoryEntityRepository $packageCategoryRepository;

    public function __construct(PackageCategoryEntityRepository $packageCategoryRepository)
    {
        $this->packageCategoryRepository = $packageCategoryRepository;
    }

    public function getPackageCategoryById(int $id): ?PackageCategoryEntity
    {
        return $this->packageCategoryRepository->find($id);
    }

    public function getAllPackagesCategories(): ?array
    {
         return $this->packageCategoryRepository->getAllPackagesCategories();
    }
}
