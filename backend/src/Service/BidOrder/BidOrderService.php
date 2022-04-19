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

    public function getBidOrderByIdForSupplier(int $id)
    {
        $bidOrder = $this->bidOrderManager->getBidOrderByIdForSupplier($id);

        $response = $this->autoMapping->map(BidOrderEntity::class, BidOrderByIdForSupplierGetResponse::class, $bidOrder);

        if ($response) {
            $response->images = $this->customizeBidOrderImages($response->images->toArray());
        }

        return $response;
    }

    public function customizeBidOrderImages(array $imageEntitiesArray): ?array
    {
        $response = [];

        if (! empty($imageEntitiesArray)) {
            foreach ($imageEntitiesArray as $imageEntity) {
                $response[] = $this->uploadFileHelperService->getImageParams($imageEntity->getImagePath());
            }

            return $response;

        } else {
            return null;
        }
    }
}
