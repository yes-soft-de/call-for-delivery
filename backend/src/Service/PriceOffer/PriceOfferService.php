<?php

namespace App\Service\PriceOffer;

use App\AutoMapping;
use App\Entity\DeliveryCarEntity;
use App\Entity\PriceOfferEntity;
use App\Manager\PriceOffer\PriceOfferManager;
use App\Request\PriceOffer\PriceOfferCreateRequest;
use App\Request\PriceOffer\PriceOfferStatusUpdateRequest;
use App\Response\DeliveryCar\DeliveryCarForStoreOwnerGetResponse;
use App\Response\PriceOffer\PriceOfferByBidOrderIdGetForStoreOwnerResponse;
use App\Response\PriceOffer\PriceOfferDeleteResponse;
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

    public function getPriceOffersByBidOrderIdForStoreOwner(int $bidDetailsId): array
    {
        $response = [];

        $priceOffers = $this->priceOfferManager->getPriceOffersByBidOrderIdForStoreOwner($bidDetailsId);

        foreach ($priceOffers as $key=>$value) {
            $response[$key] = $this->autoMapping->map("array", PriceOfferByBidOrderIdGetForStoreOwnerResponse::class, $value);

            // this condition can be removed later when old data is replaced by new one
            if ($response[$key]->transportationCount !== null && $response[$key]->deliveryCost !== null) {
                // Calculate the total delivery cost of a price offer
                // Total Delivery Cost = the delivery cost of one transportation of a specific car X transportation count
                $response[$key]->totalDeliveryCost = round($response[$key]->transportationCount * $response[$key]->deliveryCost, 2);
            }
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

    public function deletePendingPriceOfferById(int $id): ?PriceOfferDeleteResponse
    {
        $priceOfferResult = $this->priceOfferManager->deletePendingPriceOfferById($id);

        return $this->autoMapping->map(PriceOfferEntity::class, PriceOfferDeleteResponse::class, $priceOfferResult);
    }

    public function deleteAllPricesOffers(): PriceOfferDeleteResponse
    {
        $pricesOffers = $this->priceOfferManager->deleteAllPricesOffers();

        return $this->autoMapping->map("array", PriceOfferDeleteResponse::class, $pricesOffers);
    }
}
