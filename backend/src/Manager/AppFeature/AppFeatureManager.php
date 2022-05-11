<?php

namespace App\Manager\AppFeature;

use App\Entity\AppFeatureEntity;
use App\Repository\AppFeatureEntityRepository;

class AppFeatureManager
{
    private AppFeatureEntityRepository $appFeatureEntityRepository;

    public function __construct(AppFeatureEntityRepository $appFeatureEntityRepository)
    {
        $this->appFeatureEntityRepository = $appFeatureEntityRepository;
    }

    public function getAppFeatureByAppFeatureName(string $featureName): ?array
    {
        return $this->appFeatureEntityRepository->getAppFeatureStatusByAppFeatureName($featureName);
    }
}
