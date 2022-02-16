<?php

namespace App\Manager\Package;

use App\AutoMapping;
use App\Entity\PackageEntity;
use App\Repository\PackageEntityRepository;
use App\Request\Package\PackageCreateRequest;
use App\Request\Package\PackageUpdateStateRequest;
use Doctrine\ORM\EntityManagerInterface;

class PackageManager
{
    private $autoMapping;
    private $entityManager;
    private $packageRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, PackageEntityRepository $packageRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->packageRepository = $packageRepository;
    }

    public function createPackage(PackageCreateRequest $request): mixed
    {
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

    public function getPackageById($id)
    {
        return $this->packageRepository->getPackageById($id);
    }

    public function getPackage($id)
    {
        return $this->packageRepository->find($id);
    }
//TODO not completed
    // public function update(PackageUpdateStateRequest $request)
    // {
    //     $entity = $this->packageRepository->find($request->getId());

    //     if (!$entity) {
    //         return null;
    //     }
    //     $entity = $this->autoMapping->mapToObject(PackageUpdateStateRequest::class, PackageEntity::class, $request, $entity);

    //     $this->entityManager->flush();

    //     return $entity;
    // }
}
