<?php

namespace App\Service\AppFeature;

use App\Constant\AppFeature\AppFeatureResultConstant;
use App\Manager\AppFeature\AppFeatureManager;

class AppFeatureGetService
{
    public function __construct(
        private AppFeatureManager $appFeatureManager
    )
    {
    }

    /**
     * Checks if the feature of sending order to external party is activated or not
     */
    public function getAppFeatureStatusByAppFeatureName(string $featureName): bool|int
    {
        $appFeatureEntity = $this->appFeatureManager->getAppFeatureEntityByAppFeatureName($featureName);

        if (! $appFeatureEntity) {
            return AppFeatureResultConstant::APP_FEATURE_NOT_FOUND_CONST;
        }

        return $appFeatureEntity->getFeatureStatus();
    }
}
