<?php

namespace App\Service\Admin\Order;

use App\AutoMapping;
use App\Manager\Admin\Order\AdminOrderManager;
use App\Request\Admin\Order\CaptainNotArrivedOrderFilterByAdminRequest;
use App\Request\Admin\Order\OrderFilterByAdminRequest;
use App\Response\Admin\Order\BidOrderGetForAdminResponse;
use App\Response\Admin\Order\CaptainNotArrivedOrderFilterResponse;
use App\Response\Admin\Order\OrderByIdGetForAdminResponse;
use App\Response\Admin\Order\OrderGetForAdminResponse;
use App\Service\FileUpload\UploadFileHelperService;
use App\Service\OrderLogs\OrderLogsService;

class AdminOrderService
{
    private AutoMapping $autoMapping;
    private AdminOrderManager $adminOrderManager;
    private UploadFileHelperService $uploadFileHelperService;
    private OrderLogsService $orderLogsService;

    public function __construct(AutoMapping $autoMapping, AdminOrderManager $adminStoreOwnerManager, UploadFileHelperService $uploadFileHelperService, OrderLogsService $orderLogsService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminOrderManager = $adminStoreOwnerManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
        $this->orderLogsService = $orderLogsService;
    }

    public function getOrdersByStateForAdmin(string $orderStatus): int
    {
        return $this->adminOrderManager->getOrdersByStateForAdmin($orderStatus);
    }

    public function getAllOrdersCountForAdmin(): int
    {
        return $this->adminOrderManager->getAllOrdersCountForAdmin();
    }

    public function filterStoreOrdersByAdmin(OrderFilterByAdminRequest $request): ?array
    {
        $response = [];

        $orders = $this->adminOrderManager->filterStoreOrdersByAdmin($request);

        foreach ($orders as $order) {
            $order['images'] = $this->uploadFileHelperService->getImageParams($order['images']);

            $response[] = $this->autoMapping->map("array", OrderGetForAdminResponse::class, $order);
        }

        return $response;
    }

    public function getSpecificOrderByIdForAdmin(int $id)
    {
        $order = $this->adminOrderManager->getSpecificOrderByIdForAdmin($id);

        if ($order) {
            $order['orderImage'] = $this->uploadFileHelperService->getImageParams($order['orderImage']);

            if (empty($order['location'])) {
                $order['location'] = null;
            }
          
            $order['orderLogs'] = $this->orderLogsService->getOrderLogsByOrderIdForAdmin($id);
        }

        return $this->autoMapping->map("array", OrderByIdGetForAdminResponse::class, $order);
    }

    // This function filters only orders in which the captain does not arrive the store yet
    public function filterCaptainNotArrivedOrdersByAdmin(CaptainNotArrivedOrderFilterByAdminRequest $request): array
    {
        $response = [];

        $orders = $this->adminOrderManager->filterCaptainNotArrivedOrdersByAdmin($request);

        foreach ($orders as $order) {
            $response[] = $this->autoMapping->map("array", CaptainNotArrivedOrderFilterResponse::class, $order);
        }

        return $response;
    }

    public function filterStoreBidOrdersByAdmin(OrderFilterByAdminRequest $request): ?array
    {
        $response = [];

        $orders = $this->adminOrderManager->filterStoreBidOrdersByAdmin($request);

        foreach ($orders as $key=>$value) {
            $response[$key] = $this->autoMapping->map("array", BidOrderGetForAdminResponse::class, $value);

            if ($value['bidOrderDetails']) {
                // get bid details info
                $response[$key]->bidDetailsId = $value['bidOrderDetails']->getId();
                $response[$key]->openToPriceOffer = $value['bidOrderDetails']->getOpenToPriceOffer();

                // get branch info
                $response[$key]->storeOwnerBranchId = $value['bidOrderDetails']->getBranch()->getId();
                $response[$key]->storeOwnerBranchName = $value['bidOrderDetails']->getBranch()->getName();
                $response[$key]->storeOwnerBranchPhone = $value['bidOrderDetails']->getBranch()->getBranchPhone();

                // get store info
                $response[$key]->storeOwnerProfileId = $value['bidOrderDetails']->getBranch()->getStoreOwner()->getId();
                $response[$key]->storeOwnerId = $value['bidOrderDetails']->getBranch()->getStoreOwner()->getStoreOwnerId();
                $response[$key]->storeOwnerName = $value['bidOrderDetails']->getBranch()->getStoreOwner()->getStoreOwnerName();
                $response[$key]->storeOwnerPhone = $value['bidOrderDetails']->getBranch()->getStoreOwner()->getPhone();
            }
        }

        return $response;
    }
}
