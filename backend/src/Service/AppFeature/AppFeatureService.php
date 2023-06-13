<?php

namespace App\Service\AppFeature;

use App\Manager\AppFeature\AppFeatureManager;

class AppFeatureService
{
    public function __construct(
        private AppFeatureManager $appFeatureManager
    )
    {
    }

    public function getAppFeatureStatusByAppFeatureName(string $featureName): ?bool
    {
        $appFeature = $this->appFeatureManager->getAppFeatureStatusByAppFeatureName($featureName);

        if (empty($appFeature)) {
            // return true while there is no setting for the required feature
            return true;
        }

        return $appFeature['featureStatus'];
    }
}
