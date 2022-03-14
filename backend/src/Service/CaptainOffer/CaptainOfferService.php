<?php

namespace App\Service\CaptainOffer;

use App\AutoMapping;
use App\Entity\CaptainOfferEntity;
use App\Manager\CaptainOffer\CaptainOfferManager;
use App\Response\CaptainOffer\CaptainOfferResponse;

class CaptainOfferService
{
    private AutoMapping $autoMapping;
    private CaptainOfferManager $captainOfferManager;

    public function __construct(AutoMapping $autoMapping, captainOfferManager $captainOfferManager)
    {
        $this->autoMapping = $autoMapping;
        $this->captainOfferManager = $captainOfferManager;
    }

    public function getCaptainOffers(): ?array
    {
        $response = [];

        $captainOffers = $this->captainOfferManager->getCaptainOffers();

        foreach ($captainOffers as $captainOffer) {

            $response[] = $this->autoMapping->map(CaptainOfferEntity::class, CaptainOfferResponse::class, $captainOffer);
        }

        return $response;
    }
}
