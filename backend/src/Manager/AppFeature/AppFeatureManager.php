<?php

namespace App\Manager\AppFeature;

use App\Entity\AppFeatureEntity;
use App\Repository\AppFeatureEntityRepository;

class AppFeatureManager
{
    public function __construct(
        private AppFeatureEntityRepository $appFeatureEntityRepository
    )
    {
    }

    public function getAppFeatureStatusByAppFeatureName(string $featureName): ?array
    {
        return $this->appFeatureEntityRepository->getAppFeatureStatusByAppFeatureName($featureName);
    }

    public function getAppFeatureEntityByAppFeatureName(string $featureName): ?AppFeatureEntity
    {
        return $this->appFeatureEntityRepository->findOneBy(['featureName' => $featureName]);
    }
}
