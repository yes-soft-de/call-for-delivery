<?php

namespace App\Service\Admin\OrderLog;

use App\AutoMapping;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Manager\OrderLog\OrderLogManager;
use App\Response\Admin\OrderLog\OrderLogByOrderIdGetForAdminResponse;
use App\Service\FileUpload\UploadFileHelperService;

class AdminOrderLogService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private OrderLogManager $orderLogManager,
        private UploadFileHelperService $uploadFileHelperService
    )
    {
    }

    public function getOrderLogsByOrderIdForAdmin(int $orderId, ?string $timeZone = null): array
    {
        if (($timeZone) && ($timeZone !== "")) {
            $timeZone = str_replace("-", "/", $timeZone);
        }

        $response = [];

        $orderLogs = $this->orderLogManager->getOrderLogsByOrderIdForAdmin($orderId);

        if (count($orderLogs) !== 0) {
            foreach ($orderLogs as $key => $value) {
                $value['userJobDescription'] = OrderLogCreatedByUserTypeConstant::USER_JOB_DESCRIPTION_ARRAY_CONST[$value['createdByUserType']];

                $value['images'] = $this->uploadFileHelperService->getImageParams($value['imagePath']);

                $response[$key] = $this->autoMapping->map('array', OrderLogByOrderIdGetForAdminResponse::class, $value);

                if ($response[$key]->createdAt) {
                    $response[$key]->createdAt->setTimeZone(new \DateTimeZone($timeZone ? : 'Asia/Riyadh'));
                }
            }
        }

        return $response;
    }
}
