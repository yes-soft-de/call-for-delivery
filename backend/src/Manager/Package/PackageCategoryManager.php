<?php

namespace App\Manager\Package;

use App\AutoMapping;
use App\Entity\PackageCategoryEntity;
use App\Repository\PackageCategoryEntityRepository;
use App\Request\Admin\Package\PackageCategoryCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class PackageCategoryManager
{
    public function __construct(private AutoMapping $autoMapping, private EntityManagerInterface $entityManager, private PackageCategoryEntityRepository $packageCategoryRepository)
    {
    }

    /**
     * @param PackageCategoryCreateRequest $request
     * @return PackageCategoryEntity
     */
    public function createPackageCategory(PackageCategoryCreateRequest $request): PackageCategoryEntity
    {
        $packageCategoryEntity = $this->autoMapping->map(PackageCategoryCreateRequest::class, PackageCategoryEntity::class, $request);

        $this->entityManager->persist($packageCategoryEntity);
        $this->entityManager->flush();

        return $packageCategoryEntity;
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
