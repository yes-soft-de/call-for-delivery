<?php

namespace App\Manager\CaptainOffer;

use App\Repository\CaptainOfferEntityRepository;
use App\Entity\CaptainOfferEntity;

class CaptainOfferManager
{
    private CaptainOfferEntityRepository $captainOfferEntityRepository;

    public function __construct( CaptainOfferEntityRepository $captainOfferEntityRepository)
    {
        $this->captainOfferEntityRepository = $captainOfferEntityRepository;
    }

    public function getCaptainOffers(): ?array
    {
        return $this->captainOfferEntityRepository->getCaptainOffers();
    }

    public function getCaptainOfferById($id): ?CaptainOfferEntity
    {
        return $this->captainOfferEntityRepository->find($id);
    }
}
