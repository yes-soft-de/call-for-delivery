<?php

namespace App\Service\PriceOffer;

use App\AutoMapping;
use App\Manager\PriceOffer\PriceOfferManager;
use App\Request\PriceOffer\PriceOfferCreateRequest;
use App\Response\PriceOffer\PriceOfferByBidOrderIdGetForStoreOwnerResponse;

class PriceOfferService
{
    private AutoMapping $autoMapping;
    private PriceOfferManager $priceOfferManager;

    public function __construct(AutoMapping $autoMapping, PriceOfferManager $priceOfferManager)
    {
        $this->autoMapping = $autoMapping;
        $this->priceOfferManager = $priceOfferManager;
    }

    public function createPriceOffer(PriceOfferCreateRequest $request)
    {
        $this->priceOfferManager->createPriceOffer($request);
    }

    public function getPriceOffersByBidOrderIdForStoreOwner(int $bidOrderId): array
    {
        $response = [];

        $priceOffers = $this->priceOfferManager->getPriceOffersByBidOrderIdForStoreOwner($bidOrderId);

        foreach ($priceOffers as $priceOffer) {
            $response[] = $this->autoMapping->map("array", PriceOfferByBidOrderIdGetForStoreOwnerResponse::class, $priceOffer);
        }

        return $response;
    }
}
