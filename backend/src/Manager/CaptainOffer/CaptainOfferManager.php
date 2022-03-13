<?php

namespace App\Manager\CaptainOffer;

use App\Repository\CaptainOfferEntityRepository;

class CaptainOfferManager
{
    private CaptainOfferEntityRepository $captainOfferEntityRepository;

    public function __construct( CaptainOfferEntityRepository $captainOfferEntityRepository)
    {
        $this->captainOfferEntityRepository = $captainOfferEntityRepository;
    }

    public function getCaptainOffers(): ?array
    {
        return $this->captainOfferEntityRepository->findAll();
    }
}
