<?php

namespace App\Service\Admin\ExternallyDeliveredOrder;

use App\AutoMapping;
use App\Constant\AppFeature\AppFeatureResultConstant;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Constant\HTTP\HttpResponseConstant;
use App\Constant\Order\OrderResultConstant;
use App\Entity\ExternallyDeliveredOrderEntity;
use App\Request\Admin\ExternallyDeliveredOrder\ExternallyDeliveredOrderCreateByAdminRequest;
use App\Response\Admin\ExternallyDeliveredOrder\ExternallyDeliveredOrderCreateByAdminResponse;
use App\Service\ExternallyDeliveredOrderHandle\ExternallyDeliveredOrderHandleService;

class AdminExternallyDeliveredOrderService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private ExternallyDeliveredOrderHandleService $externallyDeliveredOrderHandleService
    )
    {
    }

    public function createExternallyDeliveredOrderByAdmin(ExternallyDeliveredOrderCreateByAdminRequest $request): int|string|ExternallyDeliveredOrderCreateByAdminResponse
    {
        $externallyDeliveredOrder = $this->externallyDeliveredOrderHandleService->createExternallyDeliveredOrderByAdmin($request);

        if (($externallyDeliveredOrder === AppFeatureResultConstant::APP_FEATURE_NOT_FOUND_CONST)
            || ($externallyDeliveredOrder === AppFeatureResultConstant::APP_FEATURE_NOT_ACTIVATED_CONST)
            || ($externallyDeliveredOrder === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST)
            || ($externallyDeliveredOrder === OrderResultConstant::ORDER_NOT_FOUND_RESULT)
            || ($externallyDeliveredOrder === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_IS_NOT_REGISTERED_CONST)
            || ($externallyDeliveredOrder === HttpResponseConstant::INVALID_CREDENTIALS_RESULT_CONST)
            || ($externallyDeliveredOrder === HttpResponseConstant::INVALID_INPUT_RESULT_CODE_CONST)){
            return $externallyDeliveredOrder;
        }

        return $this->autoMapping->map(ExternallyDeliveredOrderEntity::class, ExternallyDeliveredOrderCreateByAdminResponse::class,
            $externallyDeliveredOrder);
    }
}
