<?php

namespace App\Service\Order;

use App\Constant\PriceOffer\PriceOfferStatusConstant;
use App\Entity\BidDetailsEntity;
use App\Service\StoreOwner\StoreFinancialService;

// Service for managing bid order financial operations
class BidOrderFinancialService
{
    private StoreFinancialService $storeFinancialService;

    public function __construct(StoreFinancialService $storeFinancialService)
    {
        $this->storeFinancialService = $storeFinancialService;
    }

    /**
     * Get total delivery cost of a bid order for store owner
     * Total delivery cost = transportationCount * deliveryCost of a car + store profit margin
     */
    public function getBidOrderTotalDeliveryCostForStoreOwnerByBidDetailsId(BidDetailsEntity $bidDetailsEntity, int $storeOwnerId): float
    {
        $result = 0.0;

        // Get store profit margin (either private or common margin)
        $storeProfitMargin = $this->storeFinancialService->getStoreProfitMarginForStoreOwner($storeOwnerId);

        // Now, get the delivery cost of the confirmed price offer
        $pricesOffers = $bidDetailsEntity->getPriceOfferEntities()->toArray();

        if (! empty($pricesOffers)) {
            foreach ($pricesOffers as $priceOffer) {
                if ($priceOffer->getPriceOfferStatus() === PriceOfferStatusConstant::PRICE_OFFER_CONFIRMED_STATUS) {
                    $result = $priceOffer->getDeliveryCar()->getDeliveryCost() * $priceOffer->getTransportationCount() + $storeProfitMargin;

                    return round($result, 2);
                }
            }
        }

        return $result;
    }
}
