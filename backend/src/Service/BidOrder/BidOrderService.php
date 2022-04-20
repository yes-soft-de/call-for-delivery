<?php

namespace App\Service\BidOrder;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Entity\BidOrderEntity;
use App\Manager\BidOrder\BidOrderManager;
use App\Request\BidOrder\BidOrderCreateRequest;
use App\Request\BidOrder\BidOrderFilterBySupplierRequest;
use App\Response\BidOrder\BidOrderByIdForSupplierGetResponse;
use App\Response\BidOrder\BidOrderCreateResponse;
use App\Response\BidOrder\BidOrderFilterBySupplierResponse;
use App\Service\FileUpload\UploadFileHelperService;

class BidOrderService
{
    private AutoMapping $autoMapping;
    private BidOrderManager $bidOrderManager;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, BidOrderManager $bidOrderManager, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->bidOrderManager = $bidOrderManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
    }

    public function createBidOrder(BidOrderCreateRequest $request): string|BidOrderCreateResponse
    {
        $bidOrderResult = $this->bidOrderManager->createBidOrder($request);

        if ($bidOrderResult === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS;
        }

        return $this->autoMapping->map(BidOrderEntity::class, BidOrderCreateResponse::class, $bidOrderResult);
    }

    // This function filter bid orders which the supplier had not provide a price offer for any one of them yet.
    public function filterBidOrdersBySupplier(BidOrderFilterBySupplierRequest $request): array
    {
        $response = [];

        $orders = $this->bidOrderManager->filterBidOrdersBySupplier($request);

        if ($orders) {
            foreach ($orders as $order) {
                $response[] = $this->autoMapping->map("array", BidOrderFilterBySupplierResponse::class, $order);
            }
        }

        return $response;
    }

    public function getBidOrderByIdForSupplier(int $bidOrderId, int $supplierId): BidOrderByIdForSupplierGetResponse|array
    {
        $response = [];

        $bidOrder = $this->bidOrderManager->getBidOrderByIdForSupplier($bidOrderId, $supplierId);

        if ($bidOrder) {
            $response = $this->autoMapping->map("array", BidOrderByIdForSupplierGetResponse::class, $bidOrder);

            if ($response) {
                $response->images = $this->customizeBidOrderImages($response->images);
            }
        }

        return $response;
    }

    public function customizeBidOrderImages(array $imagesArray): ?array
    {
        $response = [];

        if (! empty($imagesArray)) {
            foreach ($imagesArray as $image) {
                $response[] = $this->uploadFileHelperService->getImageParams($image);
            }

            return $response;

        } else {
            return null;
        }
    }

    // This function filter bid orders which have price offers made by the supplier (who request the filter).
    public function filterBidOrdersThatHavePriceOffersBySupplier(BidOrderFilterBySupplierRequest $request): array
    {
        $response = [];

        $orders = $this->bidOrderManager->filterBidOrdersThatHavePriceOffersBySupplier($request);

        if ($orders) {
            foreach ($orders as $order) {
                $response[] = $this->autoMapping->map("array", BidOrderFilterBySupplierResponse::class, $order);
            }
        }

        return $response;
    }
}
