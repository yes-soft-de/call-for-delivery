<?php

namespace App\Manager\Package;

use App\AutoMapping;
use App\Entity\PackageCategoryEntity;
use App\Repository\PackageCategoryEntityRepository;
use App\Request\Package\PackageCategoryCreateRequest;
use App\Request\Package\PackageCategoryUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\NonUniqueResultException;

class PackageCategoryManager
{
    public function __construct(private AutoMapping $autoMapping, private EntityManagerInterface $entityManager, private PackageCategoryEntityRepository $packageCategoryRepository)
    {
    }

    /**
     * @param PackageCategoryCreateRequest $request
     * @return mixed
     */
    public function createPackageCategory(PackageCategoryCreateRequest $request): mixed
    {
        $packageCategoryEntity = $this->autoMapping->map(PackageCategoryCreateRequest::class, PackageCategoryEntity::class, $request);

        $this->entityManager->persist($packageCategoryEntity);
        $this->entityManager->flush();

        return $packageCategoryEntity;
    }

    public function updatePackageCategory(PackageCategoryUpdateRequest $request)
    {
        $entity = $this->packageCategoryRepository->find($request->getId());

        if ($entity) {

            $entity = $this->autoMapping->mapToObject(PackageCategoryUpdateRequest::class, PackageCategoryEntity::class, $request, $entity);

            $this->entityManager->flush();

            return $entity;
        }
    }

    /**
     * @param $id
     * @return PackageCategoryEntity|null
     */
    public function getPackageCategoryById($id): ?PackageCategoryEntity
    {
        return $this->packageCategoryRepository->find($id);
    }





    public function getActivePackages(): ?array
    {
        return $this->packageRepository->getActivePackages();
    }

    public function getAllPackages(): ?array
    {
        return $this->packageRepository->getAllPackages();
    }

    public function getPackage($id)
    {
        return $this->packageRepository->find($id);
    }
}
