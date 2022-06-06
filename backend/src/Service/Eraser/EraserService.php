<?php

namespace App\Service\Eraser;

use App\Manager\Eraser\EraserManager;
use App\Request\Eraser\DeleteCaptainAccountAndProfileBySuperAdminRequest;
use App\Response\Eraser\DeleteCaptainAccountAndProfileBySuperAdminResponse;

class EraserService
{
    private EraserManager $eraserManager;
    private CaptainEraserService $captainEraserService;

    public function __construct(EraserManager $eraserManager, CaptainEraserService $captainEraserService)
    {
        $this->eraserManager = $eraserManager;
        $this->captainEraserService = $captainEraserService;
    }

    // delete all bid orders in BidOrderEntity, and their images and prices offers
    public function deleteAllBidOrdersImagesAndBidOrdersAndPricesOffers(): string
    {
        return $this->eraserManager->deleteAllBidOrdersImagesAndBidOrdersAndPricesOffers();
    }

    public function deleteCaptainAccountAndProfileBySuperAdmin(DeleteCaptainAccountAndProfileBySuperAdminRequest $request): string|DeleteCaptainAccountAndProfileBySuperAdminResponse
    {
        return $this->captainEraserService->deleteCaptainAccountAndProfileBySuperAdmin($request);
    }
}
