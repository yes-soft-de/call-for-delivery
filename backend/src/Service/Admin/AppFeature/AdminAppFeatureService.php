<?php

namespace App\Service\Admin\AppFeature;

use App\AutoMapping;
use App\Constant\AppFeature\AppFeatureResultConstant;
use App\Entity\AppFeatureEntity;
use App\Manager\Admin\AppFeature\AdminAppFeatureManager;
use App\Request\Admin\AppFeature\AppFeatureCreateRequest;
use App\Request\Admin\AppFeature\AppFeatureStatusUpdateBySuperAdminRequest;
use App\Response\Admin\AppFeature\AppFeatureForAdminGetResponse;

class AdminAppFeatureService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminAppFeatureManager $adminAppFeatureManager
    )
    {
    }

    public function createAppFeatureBySuperAdmin(AppFeatureCreateRequest $request): AppFeatureForAdminGetResponse
    {
        $appFeatureEntity = $this->adminAppFeatureManager->createAppFeatureBySuperAdmin($request);

        return $this->autoMapping->map(AppFeatureEntity::class, AppFeatureForAdminGetResponse::class, $appFeatureEntity);
    }

    public function getAllAppFeatures(): array
    {
        $response = [];

        $appFeatures = $this->adminAppFeatureManager->getAllAppFeatures();

        foreach ($appFeatures as $feature) {
            $response[] = $this->autoMapping->map(AppFeatureEntity::class, AppFeatureForAdminGetResponse::class, $feature);
        }

        return $response;
    }

    public function updateAppFeatureStatusBySuperAdmin(AppFeatureStatusUpdateBySuperAdminRequest $request): ?AppFeatureForAdminGetResponse
    {
        $appFeatureResult = $this->adminAppFeatureManager->updateAppFeatureStatusBySuperAdmin($request);

        return $this->autoMapping->map(AppFeatureEntity::class, AppFeatureForAdminGetResponse::class, $appFeatureResult);
    }

    public function fetchAppFeatureByNameForAdmin(string $appFeatureName): int|AppFeatureForAdminGetResponse
    {
        $appFeatureEntity = $this->adminAppFeatureManager->fetchAppFeatureByNameForAdmin($appFeatureName);

        if (! $appFeatureEntity) {
            return AppFeatureResultConstant::APP_FEATURE_NOT_FOUND_CONST;
        }

        return $this->autoMapping->map(AppFeatureEntity::class, AppFeatureForAdminGetResponse::class, $appFeatureEntity);
    }

    public function updateAppFeatureStatusByAdmin(AppFeatureStatusUpdateBySuperAdminRequest $request): int|AppFeatureForAdminGetResponse
    {
        $appFeatureEntity = $this->adminAppFeatureManager->updateAppFeatureStatusByAdmin($request);

        if ($appFeatureEntity === AppFeatureResultConstant::APP_FEATURE_NOT_FOUND_CONST) {
            return AppFeatureResultConstant::APP_FEATURE_NOT_FOUND_CONST;
        }

        return $this->autoMapping->map(AppFeatureEntity::class, AppFeatureForAdminGetResponse::class, $appFeatureEntity);
    }
}
