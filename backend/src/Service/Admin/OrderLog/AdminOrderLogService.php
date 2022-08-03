<?php

namespace App\Service\Admin\OrderLog;

use App\AutoMapping;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Manager\OrderLog\OrderLogManager;
use App\Response\Admin\OrderLog\OrderLogByOrderIdGetForAdminResponse;
use App\Service\FileUpload\UploadFileHelperService;

class AdminOrderLogService
{
    private AutoMapping $autoMapping;
    private OrderLogManager $orderLogManager;
    private UploadFileHelperService $uploadFileHelperService;

    public function __construct(AutoMapping $autoMapping, OrderLogManager $orderLogManager, UploadFileHelperService $uploadFileHelperService)
    {
        $this->autoMapping = $autoMapping;
        $this->orderLogManager = $orderLogManager;
        $this->uploadFileHelperService = $uploadFileHelperService;
    }

    public function getOrderLogsByOrderIdForAdmin(int $orderId): array
    {
        $response = [];

        $orderLogs = $this->orderLogManager->getOrderLogsByOrderIdForAdmin($orderId);

        if (count($orderLogs) !== 0) {
            foreach ($orderLogs as $key => $value) {
                $value['userJobDescription'] = OrderLogCreatedByUserTypeConstant::USER_JOB_DESCRIPTION_ARRAY_CONST[$value['createdByUserType']];

                $value['images'] = $this->uploadFileHelperService->getImageParams($value['imagePath']);

                $response[$key] = $this->autoMapping->map('array', OrderLogByOrderIdGetForAdminResponse::class, $value);
            }
        }

        return $response;
    }
}
