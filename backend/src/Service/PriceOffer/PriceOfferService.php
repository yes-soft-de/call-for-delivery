<?php

namespace App\Service\PriceOffer;

use App\AutoMapping;
use App\Entity\PriceOfferEntity;
use App\Manager\PriceOffer\PriceOfferManager;
use App\Request\PriceOffer\PriceOfferCreateRequest;
use App\Request\PriceOffer\PriceOfferStatusUpdateRequest;
use App\Response\PriceOffer\PriceOfferByBidOrderIdGetForStoreOwnerResponse;
use App\Response\PriceOffer\PriceOfferUpdateResponse;

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

    public function updatePriceOfferStatusByStoreOwner(PriceOfferStatusUpdateRequest $request): ?PriceOfferUpdateResponse
    {
        $priceOfferResult = $this->priceOfferManager->updatePriceOfferStatusByStoreOwner($request);

        return $this->autoMapping->map(PriceOfferEntity::class, PriceOfferUpdateResponse::class, $priceOfferResult);
    }

    public function updatePriceOfferStatusBySupplier(PriceOfferStatusUpdateRequest $request): ?PriceOfferUpdateResponse
    {
        $priceOfferResult = $this->priceOfferManager->updatePriceOfferStatusBySupplier($request);

        return $this->autoMapping->map(PriceOfferEntity::class, PriceOfferUpdateResponse::class, $priceOfferResult);
    }
}
