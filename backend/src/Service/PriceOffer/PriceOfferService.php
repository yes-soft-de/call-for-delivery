<?php

namespace App\Service\PriceOffer;

use App\Manager\PriceOffer\PriceOfferManager;
use App\Request\PriceOffer\PriceOfferCreateRequest;

class PriceOfferService
{
    private PriceOfferManager $priceOfferManager;

    public function __construct(PriceOfferManager $priceOfferManager)
    {
        $this->priceOfferManager = $priceOfferManager;
    }

    public function createPriceOffer(PriceOfferCreateRequest $request)
    {
        $this->priceOfferManager->createPriceOffer($request);
    }
}
