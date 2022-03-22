<?php

namespace App\Manager\Admin\Package;

use App\AutoMapping;
use App\Constant\Package\PackageCategoryConstant;
use App\Entity\PackageCategoryEntity;
use App\Repository\PackageCategoryEntityRepository;
use App\Request\Admin\Package\PackageCategoryUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminPackageCategoryManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private PackageCategoryEntityRepository $packageCategoryEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, PackageCategoryEntityRepository $packageCategoryEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->packageCategoryEntityRepository = $packageCategoryEntityRepository;
    }

    public function updatePackageCategory(PackageCategoryUpdateRequest $request): string|PackageCategoryEntity
    {
        $entity = $this->packageCategoryEntityRepository->find($request->getId());

        if (! $entity) {
            return PackageCategoryConstant::PACKAGE_CATEGORY_NOT_EXIST;

        } else {
            $entity = $this->autoMapping->mapToObject(PackageCategoryUpdateRequest::class, PackageCategoryEntity::class, $request, $entity);

            $this->entityManager->flush();

            return $entity;
        }
    }

    public function getAllPackagesCategories(): ?array
    {
        return $this->packageCategoryEntityRepository->getAllPackagesCategories();
    }
}
