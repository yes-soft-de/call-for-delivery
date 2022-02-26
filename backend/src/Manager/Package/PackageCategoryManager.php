<?php

namespace App\Manager\Package;

use App\AutoMapping;
use App\Entity\PackageCategoryEntity;
use App\Repository\PackageCategoryEntityRepository;
use App\Request\Package\PackageCategoryCreateRequest;
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

    public function getActivePackages(): ?array
    {
        return $this->packageRepository->getActivePackages();
    }

    public function getAllPackages(): ?array
    {
        return $this->packageRepository->getAllPackages();
    }

    /**
     * @param $id
     * @return mixed
     * @throws NonUniqueResultException
     */
    public function getPackageById($id): mixed
    {
        return $this->packageRepository->getPackageById($id);
    }

    public function getPackage($id)
    {
        return $this->packageRepository->find($id);
    }

     public function updatePackage(PackageUpdateStateRequest $request)
     {

         $entity = $this->packageRepository->find($request->getId());

         if ($entity) {

             $entity = $this->autoMapping->mapToObject(PackageUpdateStateRequest::class, PackageEntity::class, $request, $entity);

             $this->entityManager->flush();

             return $entity;
         }

     }
}
