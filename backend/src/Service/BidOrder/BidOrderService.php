<?php

namespace App\Service\BidOrder;

use App\AutoMapping;
use App\Constant\StoreOwner\StoreProfileConstant;
use App\Entity\BidOrderEntity;
use App\Manager\BidOrder\BidOrderManager;
use App\Request\BidOrder\BidOrderCreateRequest;
use App\Request\BidOrder\BidOrderFilterBySupplierRequest;
use App\Response\BidOrder\BidOrderCreateResponse;
use App\Response\BidOrder\BidOrderFilterBySupplierResponse;

class BidOrderService
{
    private AutoMapping $autoMapping;
    private BidOrderManager $bidOrderManager;

    public function __construct(AutoMapping $autoMapping, BidOrderManager $bidOrderManager)
    {
        $this->autoMapping = $autoMapping;
        $this->bidOrderManager = $bidOrderManager;
    }

    public function createBidOrder(BidOrderCreateRequest $request): string|BidOrderCreateResponse
    {
        $bidOrderResult = $this->bidOrderManager->createBidOrder($request);

        if ($bidOrderResult === StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS) {
            return StoreProfileConstant::STORE_OWNER_PROFILE_INACTIVE_STATUS;
        }

        return $this->autoMapping->map(BidOrderEntity::class, BidOrderCreateResponse::class, $bidOrderResult);
    }

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
}
