<?php

namespace App\Manager\Package;

use App\AutoMapping;
use App\Entity\PackageCategoryEntity;
use App\Repository\PackageCategoryEntityRepository;
use Doctrine\ORM\EntityManagerInterface;

class PackageCategoryManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private PackageCategoryEntityRepository $packageCategoryRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, PackageCategoryEntityRepository $packageCategoryRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->packageCategoryRepository = $packageCategoryRepository;
    }

    public function getPackageCategoryById(int $id): ?PackageCategoryEntity
    {
        return $this->packageCategoryRepository->find($id);
    }

    public function getAllActivePackagesCategories(): ?array
    {
         return $this->packageCategoryRepository->getAllActivePackagesCategories();
    }
}
