<?php

namespace App\Service\Admin\StreetLine;

use App\AutoMapping;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyIdentityConstant;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Constant\ExternalDeliveryCompany\StreetLine\StreetLineCompanyConstant;
use App\Constant\ExternallyDeliveredOrder\ExternallyDeliveredOrderConstant;
use App\Constant\HTTP\HttpResponseConstant;
use App\Constant\OrderLog\OrderLogActionTypeConstant;
use App\Constant\OrderLog\OrderLogCreatedByUserTypeConstant;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Entity\OrderEntity;
use App\Request\Admin\StreetLine\OrderInStreetLineCancelByAdminRequest;
use App\Response\Admin\StreetLine\OrderInStreetLineCancelByAdminResponse;
use App\Service\Admin\ExternallyDeliveredOrder\AdminExternallyDeliveredOrderGetService;
use App\Service\ExternallyDeliveredOrderHandle\ExternallyDeliveredOrderHandleService;
use App\Service\OrderLog\OrderLogService;

class AdminStreetLineOrderService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminExternallyDeliveredOrderGetService $adminExternallyDeliveredOrderGetService,
        private ExternallyDeliveredOrderHandleService $externallyDeliveredOrderHandleService,
        private OrderLogService $orderLogService
    )
    {
    }

    /**
     * Cancel order in the external company platform, and according to the returned response do the required
     */
    public function handleCancellingExternalOrderInExternalDeliveryCompanyPlatform(int $externalDeliveryCompanyId, int $externalOrderId): ExternallyDeliveredOrderEntity|array|int|string
    {
        return $this->externallyDeliveredOrderHandleService->handleCancellingExternalOrderInExternalDeliveryCompanyPlatform($externalDeliveryCompanyId,
            $externalOrderId);
    }

    public function getPendingExternalOrderByOrderIdAndExternalDeliveryCompanyId(int $orderId, int $externalDeliveryCompanyId): ExternallyDeliveredOrderEntity|int
    {
        return $this->adminExternallyDeliveredOrderGetService->getPendingExternalOrderByOrderIdAndExternalDeliveryCompanyId($orderId,
            $externalDeliveryCompanyId);
    }

    public function cancelOrderInStreetLineCompanyByAdmin(OrderInStreetLineCancelByAdminRequest $request, int $adminUserId): string|int|OrderInStreetLineCancelByAdminResponse
    {
        // 1 Get external order id of the order id
        $externalOrder = $this->getPendingExternalOrderByOrderIdAndExternalDeliveryCompanyId($request->getOrderId(),
            ExternalDeliveryCompanyIdentityConstant::STREET_LINE_COMPANY_CONST);

        if ($externalOrder === ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST) {
            return ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST;
        }
        // 2 Cancel the order in the required company
        $cancelOrderResult = $this->handleCancellingExternalOrderInExternalDeliveryCompanyPlatform(ExternalDeliveryCompanyIdentityConstant::STREET_LINE_COMPANY_CONST,
            $externalOrder->getExternalOrderId());

        if (($cancelOrderResult === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_IS_NOT_REGISTERED_CONST)
            || ($cancelOrderResult === HttpResponseConstant::INVALID_CREDENTIALS_RESULT_CONST)
            || ($cancelOrderResult === HttpResponseConstant::INVALID_INPUT_RESULT_CODE_CONST)
            || ($cancelOrderResult === HttpResponseConstant::METHOD_NOT_ALLOWED_RESULT_CONST)
            || ($cancelOrderResult === StreetLineCompanyConstant::RESPONSE_MESSAGE_INVALID_ORDER_VALUE_CONST)
            || ($cancelOrderResult === HttpResponseConstant::UNRECOGNIZED_RESPONSE_CONST)
            || ($cancelOrderResult === ExternallyDeliveredOrderConstant::EXTERNALLY_DELIVERED_ORDER_NOT_EXIST_CONST)) {
            return $cancelOrderResult;
        }

        // save log of the action on order
        $this->createOrderLogMessageViaOrderEntityAndByAdmin($cancelOrderResult->getOrderId(), $adminUserId,
            OrderLogActionTypeConstant::ORDER_CANCELLED_ONLY_IN_STREETLINE_BY_ADMIN_ACTION_CONST,
            ['externalCompanyName' => $cancelOrderResult->getExternalDeliveryCompany()->getCompanyName()]);

        return $this->autoMapping->map(ExternallyDeliveredOrderEntity::class, OrderInStreetLineCancelByAdminResponse::class,
            $cancelOrderResult);
    }

    /**
     *  save log of the action on order
     */
    public function createOrderLogMessageViaOrderEntityAndByAdmin(OrderEntity $orderEntity, int $userId, int $action, array $details)
    {
        $this->orderLogService->createOrderLogMessage($orderEntity, $userId, OrderLogCreatedByUserTypeConstant::ADMIN_USER_TYPE_CONST,
            $action, $details, null, null);
    }
}
