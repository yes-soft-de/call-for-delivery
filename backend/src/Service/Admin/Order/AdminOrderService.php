<?php

namespace App\Service\Admin\Order;

use App\AutoMapping;
use App\Manager\Admin\Order\AdminOrderManager;
use App\Request\Admin\Order\OrderFilterByAdminRequest;
use App\Response\Admin\Order\OrderGetForAdminResponse;
use App\Service\FileUpload\UploadFileHelperService;

class AdminOrderService
{
    private AutoMapping $autoMapping;
    private AdminOrderManager $adminOrderManager;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, AdminOrderManager $adminStoreOwnerManager, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->adminOrderManager = $adminStoreOwnerManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
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
}
