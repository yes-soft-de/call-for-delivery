<?php

namespace App\Service\Admin\Rate;

use App\AutoMapping;
use App\Manager\Admin\Rate\AdminRateManager;
use App\Response\Admin\Rate\RatingsForCaptainGetByAdminResponse;

class AdminRateService
{
    private AutoMapping $autoMapping;
    private AdminRateManager $adminRateManager;

    public function __construct(AutoMapping $autoMapping, AdminRateManager $adminRateManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminRateManager = $adminRateManager;
    }

    public function getAllRatingsByCaptainProfileIdForAdmin(int $captainProfileId): array
    {
        $response = [];

        $ratingsResult = $this->adminRateManager->getAllRatingsByCaptainProfileIdForAdmin($captainProfileId);

        if (count($ratingsResult)) {
            foreach ($ratingsResult as $singleRatingInfo) {
                $response[] = $this->autoMapping->map('array', RatingsForCaptainGetByAdminResponse::class, $singleRatingInfo);
            }
        }

        return $response;
    }
}
