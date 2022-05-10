<?php

namespace App\Manager\Admin\AppFeature;

use App\AutoMapping;
use App\Entity\AppFeatureEntity;
use App\Repository\AppFeatureEntityRepository;
use App\Request\Admin\AppFeature\AppFeatureCreateRequest;
use App\Request\Admin\AppFeature\AppFeatureStatusUpdateBySuperAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminAppFeatureManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private AppFeatureEntityRepository $appFeatureEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, AppFeatureEntityRepository $appFeatureEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->appFeatureEntityRepository = $appFeatureEntityRepository;
    }

    public function createAppFeatureBySuperAdmin(AppFeatureCreateRequest $request): AppFeatureEntity
    {
        $appFeatureEntity = $this->autoMapping->map(AppFeatureCreateRequest::class, AppFeatureEntity::class, $request);

        $this->entityManager->persist($appFeatureEntity);
        $this->entityManager->flush();

        return $appFeatureEntity;
    }

    public function getAllAppFeatures(): array
    {
        return $this->appFeatureEntityRepository->findAll();
    }

    public function updateAppFeatureStatusBySuperAdmin(AppFeatureStatusUpdateBySuperAdminRequest $request): ?AppFeatureEntity
    {
        $appFeatureEntity = $this->appFeatureEntityRepository->find($request->getId());

        if (! $appFeatureEntity) {
            return $appFeatureEntity;
        }

        $appFeatureEntity = $this->autoMapping->mapToObject(AppFeatureStatusUpdateBySuperAdminRequest::class, AppFeatureEntity::class, $request,
            $appFeatureEntity);

        $this->entityManager->flush();

        return  $appFeatureEntity;
    }
}
