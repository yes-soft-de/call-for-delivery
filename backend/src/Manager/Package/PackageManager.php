<?php

namespace App\Manager\Package;

use App\AutoMapping;
use App\Entity\PackageEntity;
use App\Manager\Package\PackageCategoryManager;
use App\Repository\PackageEntityRepository;
use App\Request\Package\PackageCreateRequest;
use App\Request\Package\PackageUpdateStateRequest;
use Doctrine\ORM\EntityManagerInterface;
use Doctrine\ORM\NonUniqueResultException;

class PackageManager
{
    private $autoMapping;
    private $entityManager;
    private $packageRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, PackageEntityRepository $packageRepository, private PackageCategoryManager $packageCategoryManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->packageRepository = $packageRepository;
    }

    /**
     * @param PackageCreateRequest $request
     * @return mixed
     */
    public function createPackage(PackageCreateRequest $request): mixed
    {
        
        $packageCategory = $this->packageCategoryManager->getPackageCategoryById($request->getPackageCategory());
        $request->setPackageCategory($packageCategory);

        $packageEntity = $this->autoMapping->map(PackageCreateRequest::class, PackageEntity::class, $request);

        $this->entityManager->persist($packageEntity);
        $this->entityManager->flush();

        return $packageEntity;
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
     
    /**
     * @param $packageCategory
     * @return array|null
     */
    public function getPackagesByCategoryIdForAdmin($packageCategory): ?array
    {
        return $this->packageRepository->getPackagesByCategoryIdForAdmin($packageCategory);
    }

    /**
     * @param $packageCategory
     * @return array|null
     */
    public function getAllPackagesCategoriesAndPackagesForStore($packageCategory): ?array
    {
        return $this->packageRepository->getAllPackagesCategoriesAndPackagesForStore($packageCategory);
    }
}
