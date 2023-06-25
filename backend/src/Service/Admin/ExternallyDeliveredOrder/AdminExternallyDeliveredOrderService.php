<?php

namespace App\Service\Admin\ExternallyDeliveredOrder;

use App\AutoMapping;
use App\Constant\AppFeature\AppFeatureResultConstant;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Constant\HTTP\HttpResponseConstant;
use App\Constant\Order\OrderResultConstant;
use App\Constant\OrderLog\OrderLogActionTypeConstant;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Entity\OrderEntity;
use App\Request\Admin\ExternallyDeliveredOrder\ExternallyDeliveredOrderCreateByAdminRequest;
use App\Response\Admin\ExternallyDeliveredOrder\ExternallyDeliveredOrderCreateByAdminResponse;
use App\Service\ExternallyDeliveredOrderHandle\ExternallyDeliveredOrderHandleService;
use App\Service\OrderLog\OrderLogService;

class AdminExternallyDeliveredOrderService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private ExternallyDeliveredOrderHandleService $externallyDeliveredOrderHandleService,
        private OrderLogService $orderLogService
    )
    {
    }

    public function createExternallyDeliveredOrderByAdmin(ExternallyDeliveredOrderCreateByAdminRequest $request, int $adminUserId): int|string|ExternallyDeliveredOrderCreateByAdminResponse
    {
        $externallyDeliveredOrder = $this->externallyDeliveredOrderHandleService->createExternallyDeliveredOrderByAdmin($request);

        if (($externallyDeliveredOrder === AppFeatureResultConstant::APP_FEATURE_NOT_ACTIVATED_CONST)
            || ($externallyDeliveredOrder === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST)
            || ($externallyDeliveredOrder === OrderResultConstant::ORDER_NOT_FOUND_RESULT)
            || ($externallyDeliveredOrder === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_IS_NOT_REGISTERED_CONST)
            || ($externallyDeliveredOrder === HttpResponseConstant::INVALID_CREDENTIALS_RESULT_CONST)
            || ($externallyDeliveredOrder === HttpResponseConstant::INVALID_INPUT_RESULT_CODE_CONST)
            || ($externallyDeliveredOrder === OrderResultConstant::ORDER_STATE_IS_NOT_PENDING_CONST)){
            return $externallyDeliveredOrder;
        }

        // save log of the action on order
        $this->createOrderLogMessageViaOrderEntityAndByAdmin($externallyDeliveredOrder->getOrderId(), $adminUserId,
            OrderLogActionTypeConstant::SENDING_NORMAL_ORDER_EXTERNALLY_BY_ADMIN_CONST,
            ['externalCompanyName' => $externallyDeliveredOrder->getExternalDeliveryCompany()->getCompanyName()]);

        return $this->autoMapping->map(ExternallyDeliveredOrderEntity::class, ExternallyDeliveredOrderCreateByAdminResponse::class,
            $externallyDeliveredOrder);
    }

    public function createOrderLogMessageViaOrderEntityAndByAdmin(OrderEntity $orderEntity, int $userId, int $action, array $details)
    {
        // save log of the action on order
        $this->orderLogService->createOrderLogMessage($orderEntity, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
            $action, $details, null, null);
    }
}
