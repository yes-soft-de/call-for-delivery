<?php

namespace App\Service\BidOrder;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Entity\BidOrderEntity;
use App\Entity\PriceOfferEntity;
use App\Manager\BidOrder\BidOrderManager;
use App\Request\BidOrder\BidOrderCreateRequest;
use App\Request\BidOrder\BidOrderFilterBySupplierRequest;
use App\Response\BidOrder\BidOrderByIdForSupplierGetResponse;
use App\Response\BidOrder\BidOrderCreateResponse;
use App\Response\BidOrder\BidOrderFilterBySupplierResponse;
use App\Response\PriceOffer\PriceOfferForSupplierGetResponse;
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

//    public function createBidOrder(BidOrderCreateRequest $request): string|BidOrderCreateResponse
//    {
//        $bidOrderResult = $this->bidOrderManager->createBidOrder($request);
//
//        if ($bidOrderResult === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
//            return StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS;
//        }
//
//        return $this->autoMapping->map(BidOrderEntity::class, BidOrderCreateResponse::class, $bidOrderResult);
//    }

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

        $bidOrder = $this->bidOrderManager->getBidOrderByIdForSupplier($bidOrderId);

        if ($bidOrder) {
            $response = $this->autoMapping->map(BidOrderEntity::class, BidOrderByIdForSupplierGetResponse::class, $bidOrder);

            if ($response) {
                // get only prices offers of the supplier which made for the bid order
                $response->priceOfferEntities = $this->filterAngGetPricesOffersBySupplierId($response->priceOfferEntities->toArray(), $supplierId);
                // get each image of the order images as an object contain image URL, base URL, and full image URL
                $response->images = $this->customizeBidOrderImages($response->images->toArray());
            }
        }

        return $response;
    }

    public function customizeBidOrderImages(array $imagesArray): ?array
    {
        $response = [];

        if (! empty($imagesArray)) {
            foreach ($imagesArray as $image) {
                $response[] = $this->uploadFileHelperService->getImageParams($image->getImagePath());
            }

            return $response;

        } else {
            return null;
        }
    }

    public function filterAngGetPricesOffersBySupplierId(array $pricesOffersEntities, int $supplierId): ?array
    {
        $response = [];

        if (! empty($pricesOffersEntities)) {
            foreach ($pricesOffersEntities as $pricesOfferEntity) {
                if ($pricesOfferEntity->getSupplierProfile()->getUser()->getId() === $supplierId) {
                    $response[] = $this->autoMapping->map(PriceOfferEntity::class, PriceOfferForSupplierGetResponse::class, $pricesOfferEntity);
                }
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
            // if the price offer status filter is set, then we have to filter the orders here in the Service layer
            if ($request->getPriceOfferStatus()) {
                $orders = $this->filterBidOrdersAccordingToLastPriceOfferStatus($orders, $request->getPriceOfferStatus());
            }

            foreach ($orders as $order) {

                $response[] = $this->autoMapping->map("array", BidOrderFilterBySupplierResponse::class, $order);
            }
        }

        return $response;
    }

    // This function filter the orders according to the last offer status of each order
    public function filterBidOrdersAccordingToLastPriceOfferStatus(array $bidOrders, string $priceOfferStatus): array
    {
        $response = [];

        foreach ($bidOrders as $bidOrder) {
            $pricesOffer = $this->bidOrderManager->getLastPriceOfferByBidOrderId($bidOrder['id']);

            if (! empty($pricesOffer)) {
                if ($pricesOffer['priceOfferStatus'] === $priceOfferStatus) {
                    $response[] = $bidOrder;
                }
            }
        }

        return $response;
    }
}
