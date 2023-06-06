<?php

namespace App\Manager\Admin\AppFeature;

use App\AutoMapping;
use App\Constant\AppFeature\AppFeatureResultConstant;
use App\Entity\AppFeatureEntity;
use App\Repository\AppFeatureEntityRepository;
use App\Request\Admin\AppFeature\AppFeatureCreateRequest;
use App\Request\Admin\AppFeature\AppFeatureStatusUpdateBySuperAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminAppFeatureManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private AppFeatureEntityRepository $appFeatureEntityRepository
    )
    {
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

    public function fetchAppFeatureByNameForAdmin(string $appFeatureName): ?AppFeatureEntity
    {
        return $this->appFeatureEntityRepository->findOneBy(['featureName' => $appFeatureName]);
    }

    public function updateAppFeatureStatusByAdmin(AppFeatureStatusUpdateBySuperAdminRequest $request): int|AppFeatureEntity
    {
        $appFeatureEntity = $this->appFeatureEntityRepository->findOneBy(['id' => $request->getId()]);

        if (! $appFeatureEntity) {
            return AppFeatureResultConstant::APP_FEATURE_NOT_FOUND_CONST;
        }

        $appFeatureEntity = $this->autoMapping->mapToObject(AppFeatureStatusUpdateBySuperAdminRequest::class,
            AppFeatureEntity::class, $request, $appFeatureEntity);

        $this->entityManager->flush();

        return $appFeatureEntity;
    }
}
