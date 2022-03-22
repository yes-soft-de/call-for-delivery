<?php

namespace App\Service\Rate;

use App\AutoMapping;
use App\Entity\RateEntity;
use App\Manager\Rate\RatingManager;
use App\Request\Rate\RatingCreateRequest;
use App\Response\Rate\RatingResponse;

class RatingService
{
    private AutoMapping $autoMapping;
    private RatingManager $ratingManager;

    public function __construct(AutoMapping $autoMapping, RatingManager $ratingManager)
    {
        $this->autoMapping = $autoMapping;
        $this->ratingManager = $ratingManager;
    }

    public function createRating(RatingCreateRequest $request): ?RatingResponse
    {
        $rating = $this->ratingManager->createRating($request);

        return $this->autoMapping->map(RateEntity::class, RatingResponse::class, $rating);
    }

    public function getAverageRating($rated): ?float
    {
        return $this->ratingManager->getAverageRating($rated);
    }
}
