<?php

namespace App\Service\Admin\AppFeature;

use App\AutoMapping;
use App\Entity\AppFeatureEntity;
use App\Manager\Admin\AppFeature\AdminAppFeatureManager;
use App\Request\Admin\AppFeature\AppFeatureCreateRequest;
use App\Request\Admin\AppFeature\AppFeatureStatusUpdateBySuperAdminRequest;
use App\Response\Admin\AppFeature\AppFeatureForAdminGetResponse;

class AdminAppFeatureService
{
    private AutoMapping $autoMapping;
    private AdminAppFeatureManager $adminAppFeatureManager;

    public function __construct(AutoMapping $autoMapping, AdminAppFeatureManager $adminAppFeatureManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminAppFeatureManager = $adminAppFeatureManager;
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
}
