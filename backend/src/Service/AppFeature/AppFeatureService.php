<?php

namespace App\Service\AppFeature;

use App\Manager\AppFeature\AppFeatureManager;

class AppFeatureService
{
    private AppFeatureManager $appFeatureManager;

    public function __construct(AppFeatureManager $appFeatureManager)
    {
        $this->appFeatureManager = $appFeatureManager;
    }

    public function getAppFeatureStatusByAppFeatureName(string $featureName): ?bool
    {
        $appFeature = $this->appFeatureManager->getAppFeatureByAppFeatureName($featureName);

        if (empty($appFeature)) {
            // return true while there is no setting for the required feature
            return true;
        }

        return $appFeature['featureStatus'];
    }
}
