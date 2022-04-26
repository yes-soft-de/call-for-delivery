<?php

namespace App\Service\Eraser;

use App\Manager\Eraser\EraserManager;

class EraserService
{
    private EraserManager $eraserManager;

    public function __construct(EraserManager $eraserManager)
    {
        $this->eraserManager = $eraserManager;
    }

    // delete all bid orders in BidOrderEntity, and their images and prices offers
    public function deleteAllBidOrdersImagesAndBidOrdersAndPricesOffers(): string
    {
        return $this->eraserManager->deleteAllBidOrdersImagesAndBidOrdersAndPricesOffers();
    }
}
