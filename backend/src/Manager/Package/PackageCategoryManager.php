<?php

namespace App\Manager\Package;

use App\AutoMapping;
use App\Entity\PackageCategoryEntity;
use App\Repository\PackageCategoryEntityRepository;
use App\Request\Package\PackageCategoryCreateRequest;
use App\Request\Package\PackageCategoryUpdateRequest;
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

    /**
     * @param PackageCategoryUpdateRequest $request
     * @return PackageCategoryEntity|null
     */
    public function updatePackageCategory(PackageCategoryUpdateRequest $request): ?PackageCategoryEntity
    {
        $entity = $this->packageCategoryRepository->find($request->getId());

        if ($entity) {

            $entity = $this->autoMapping->mapToObject(PackageCategoryUpdateRequest::class, PackageCategoryEntity::class, $request, $entity);

            $this->entityManager->flush();
        }
     
        return $entity;
    }

    /**
     * @param $id
     * @return PackageCategoryEntity|null
     */
    public function getPackageCategoryById($id): ?PackageCategoryEntity
    {
        return $this->packageCategoryRepository->find($id);
    }

     /**
     * @return array|null
     */
    public function getAllPackagesCategories(): ?array
     {
        $packageCategories = $this->packageCategoryRepository->getAllPackagesCategories();

        return $packageCategories;
    }
}
