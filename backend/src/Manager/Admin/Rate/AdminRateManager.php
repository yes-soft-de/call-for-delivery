<?php

namespace App\Manager\Admin\Rate;

use App\Repository\RateEntityRepository;

class AdminRateManager
{
    private RateEntityRepository $rateEntityRepository;

    public function __construct(RateEntityRepository $rateEntityRepository)
    {
        $this->rateEntityRepository = $rateEntityRepository;
    }

    public function getAllRatingsByCaptainProfileIdForAdmin(int $captainProfileId): array
    {
        return $this->rateEntityRepository->getAllRatingsByCaptainProfileIdForAdmin($captainProfileId);
    }
}
