<?php

namespace App\Service\Admin\OrderDistanceConflict;

use App\AutoMapping;
use App\Constant\Admin\AdminProfileConstant;
use App\Constant\OrderDistanceConflict\OrderDistanceConflictResultConstant;
use App\Entity\OrderDistanceConflictEntity;
use App\Manager\Admin\OrderDistanceConflict\AdminOrderDistanceConflictManager;
use App\Request\Admin\OrderDistanceConflict\OrderDistanceConflictFilterByAdminRequest;
use App\Request\Admin\OrderDistanceConflict\OrderDistanceConflictRefuseByAdminRequest;
use App\Request\Admin\OrderDistanceConflict\OrderDistanceConflictUpdateByAdminRequest;
use App\Response\Admin\OrderDistanceConflict\OrderDistanceConflictFilterByAdminResponse;
use App\Response\Admin\OrderDistanceConflict\OrderDistanceConflictUpdateByAdminResponse;
use App\Service\Admin\AdminProfile\AdminProfileGetService;

class AdminOrderDistanceConflictService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminProfileGetService $adminProfileGetService,
        private AdminOrderDistanceConflictManager $adminOrderDistanceConflictManager
    )
    {
    }

    /**
     * Get admin profile id if admin profile exists
     */
    public function getAdminProfileIdByAdminUserId(int $adminUserId): int|string
    {
        return $this->adminProfileGetService->getAdminProfileIdByAdminUserId($adminUserId);
    }

    /**
     * Updates order distance conflict by admin after either new destination is used or a distance is added
     */
    public function updateOrderDistanceConflictByAdmin(OrderDistanceConflictUpdateByAdminRequest $request): OrderDistanceConflictUpdateByAdminResponse|int
    {
        $orderDistanceConflictEntity = $this->adminOrderDistanceConflictManager->updateOrderDistanceConflictByAdmin($request);

        if ($orderDistanceConflictEntity === OrderDistanceConflictResultConstant::ORDER_DISTANCE_CONFLICT_NOT_EXIST_CONST) {
            return OrderDistanceConflictResultConstant::ORDER_DISTANCE_CONFLICT_NOT_EXIST_CONST;
        }

        return $this->autoMapping->map(OrderDistanceConflictEntity::class, OrderDistanceConflictUpdateByAdminResponse::class,
            $orderDistanceConflictEntity);
    }

    /**
     * Updates order distance conflict by refusing it by admin
     */
    public function refuseOrderDistanceConflictByAdmin(OrderDistanceConflictRefuseByAdminRequest $request, int $adminUserId): OrderDistanceConflictUpdateByAdminResponse|int|string
    {
        // First, get and set admin profile id
        $adminProfileId = $this->getAdminProfileIdByAdminUserId($adminUserId);

        if ($adminProfileId === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;
        }

        $request->setConflictResolvedBy($adminProfileId);

        $orderDistanceConflictEntity = $this->adminOrderDistanceConflictManager->refuseOrderDistanceConflictByAdmin($request);

        if ($orderDistanceConflictEntity === OrderDistanceConflictResultConstant::ORDER_DISTANCE_CONFLICT_NOT_EXIST_CONST) {
            return OrderDistanceConflictResultConstant::ORDER_DISTANCE_CONFLICT_NOT_EXIST_CONST;
        }

        return $this->autoMapping->map(OrderDistanceConflictEntity::class, OrderDistanceConflictUpdateByAdminResponse::class,
            $orderDistanceConflictEntity);
    }

    /**
     * Filters orders distance conflicts by admin
     */
    public function filterOrderDistanceConflictByAdmin(OrderDistanceConflictFilterByAdminRequest $request): array
    {
        $response = [];

        $ordersDistanceConflicts = $this->adminOrderDistanceConflictManager->filterOrderDistanceConflictByAdmin($request);

        if (count($ordersDistanceConflicts) > 0) {
            foreach ($ordersDistanceConflicts as $key => $value) {
                $response[$key] = $this->autoMapping->map(OrderDistanceConflictEntity::class, OrderDistanceConflictFilterByAdminResponse::class,
                    $value);
                // set order id in the returned response
                $response[$key]->orderId = $value->getOrderId()->getId();
                // set store info in the returned response
                $response[$key]->storeOwnerName = $value->getOrderId()->getStoreOwner()->getStoreOwnerName();
                $response[$key]->storeOwnerProfileId = $value->getOrderId()->getStoreOwner()->getId();
                // set captain info in the returned response
                $captain = $value->getOrderId()->getCaptainId();

                if ($captain) {
                    $response[$key]->captainName = $captain->getCaptainName();
                    $response[$key]->captainProfileId = $captain->getId();
                }
                // set store's branch name
                $storeOrderDetails = $value->getOrderId()->getStoreOrderDetailsEntity();

                if ($storeOrderDetails) {
                    $response[$key]->storeBranchName = $storeOrderDetails->getBranch()->getName();
                }
            }
        }

        return $response;
    }
}
