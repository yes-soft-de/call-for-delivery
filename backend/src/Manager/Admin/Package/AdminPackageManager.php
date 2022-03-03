<?php

namespace App\Manager\Admin\Package;

use App\AutoMapping;
use App\Constant\Package\PackageConstant;
use App\Entity\PackageEntity;
use App\Manager\Package\PackageCategoryManager;
use App\Repository\PackageCategoryEntityRepository;
use App\Repository\PackageEntityRepository;
use App\Request\Admin\Package\PackageCreateRequest;
use App\Request\Admin\Package\PackageStatusUpdateRequest;
use App\Request\Admin\Package\PackageUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminPackageManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private PackageCategoryManager $packageCategoryManager;
    private PackageEntityRepository $packageEntityRepository;
    private PackageCategoryEntityRepository $packageCategoryEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, PackageCategoryManager $packageCategoryManager, PackageEntityRepository $packageEntityRepository,
     PackageCategoryEntityRepository $packageCategoryEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->packageCategoryManager = $packageCategoryManager;
        $this->packageEntityRepository = $packageEntityRepository;
        $this->packageCategoryEntityRepository = $packageCategoryEntityRepository;
    }

    public function createPackage(PackageCreateRequest $request): PackageEntity
    {
        $packageCategory = $this->packageCategoryManager->getPackageCategoryById($request->getPackageCategory());

        $request->setPackageCategory($packageCategory);

        $packageEntity = $this->autoMapping->map(PackageCreateRequest::class, PackageEntity::class, $request);

        $this->entityManager->persist($packageEntity);
        $this->entityManager->flush();

        return $packageEntity;
    }

    public function updatePackage(PackageUpdateRequest $request): string|PackageEntity
    {
        $entity = $this->packageEntityRepository->find($request->getId());

        if (! $entity) {
            return PackageConstant::PACKAGE_NOT_EXIST;

        } else {
            $entity = $this->autoMapping->mapToObject(PackageUpdateRequest::class, PackageEntity::class, $request, $entity);

            $this->entityManager->flush();

            return $entity;
        }
    }

    public function updatePackageStatus(PackageStatusUpdateRequest $request): string|PackageEntity
    {
        $entity = $this->packageEntityRepository->find($request->getId());

        if (! $entity) {
            return PackageConstant::PACKAGE_NOT_EXIST;

        } else {
            $entity = $this->autoMapping->mapToObject(PackageStatusUpdateRequest::class, PackageEntity::class, $request, $entity);

            $this->entityManager->flush();

            return $entity;
        }
    }

    public function getAllPackages(): ?array
    {
        return $this->packageEntityRepository->getAllPackages();
    }

    public function getPackagesByCategoryId(int $packageCategory): ?array
    {
        return $this->packageEntityRepository->getPackagesByCategoryIdForAdmin($packageCategory);
    }
}
