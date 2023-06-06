<?php

namespace App\Service\Admin\ExternalDeliveryCompany;

use App\AutoMapping;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Entity\ExternalDeliveryCompanyEntity;
use App\Manager\Admin\ExternalDeliveryCompany\AdminExternalDeliveryCompanyManager;
use App\Request\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyCreateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyDeleteByIdRequest;
use App\Request\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyStatusUpdateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyUpdateByAdminRequest;
use App\Response\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyCreateByAdminResponse;
use App\Response\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyDeleteResponse;
use App\Response\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyFetchResponse;
use App\Response\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyStatusUpdateByAdminResponse;
use App\Response\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyUpdateByAdminResponse;
use App\Service\Admin\ExternalDeliveryCompanyCriteria\AdminExternalDeliveryCompanyCriteriaService;
use App\Service\Admin\ExternallyDeliveredOrder\AdminExternallyDeliveredOrderGetService;

class AdminExternalDeliveryCompanyService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminExternalDeliveryCompanyManager $adminExternalDeliveryCompanyManager,
        private AdminExternalDeliveryCompanyCriteriaService $adminExternalDeliveryCompanyCriteriaService,
        private AdminExternallyDeliveredOrderGetService $adminExternallyDeliveredOrderGetService
    )
    {
    }

    public function createExternalDeliveryCompany(ExternalDeliveryCompanyCreateByAdminRequest $request): ExternalDeliveryCompanyCreateByAdminResponse
    {
        $externalDeliveryCompany = $this->adminExternalDeliveryCompanyManager->createExternalDeliveryCompany($request);

        return $this->autoMapping->map(ExternalDeliveryCompanyEntity::class, ExternalDeliveryCompanyCreateByAdminResponse::class,
            $externalDeliveryCompany);
    }

    public function updateExternalDeliveryCompanyStatus(ExternalDeliveryCompanyStatusUpdateByAdminRequest $request): int|ExternalDeliveryCompanyStatusUpdateByAdminResponse
    {
        $externalDeliveryCompany = $this->adminExternalDeliveryCompanyManager->updateExternalDeliveryCompanyStatus($request);

        if ($externalDeliveryCompany === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST;
        }

        return $this->autoMapping->map(ExternalDeliveryCompanyEntity::class, ExternalDeliveryCompanyStatusUpdateByAdminResponse::class,
            $externalDeliveryCompany);
    }

    public function updateExternalDeliveryCompany(ExternalDeliveryCompanyUpdateByAdminRequest $request): int|ExternalDeliveryCompanyUpdateByAdminResponse
    {
        $externalDeliveryCompany = $this->adminExternalDeliveryCompanyManager->updateExternalDeliveryCompany($request);

        if ($externalDeliveryCompany === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST;
        }

        return $this->autoMapping->map(ExternalDeliveryCompanyEntity::class, ExternalDeliveryCompanyUpdateByAdminResponse::class,
            $externalDeliveryCompany);
    }

    public function fetchAllExternalDeliveryCompanies(): array
    {
        $response = [];

        $externalDeliveryCompanies = $this->adminExternalDeliveryCompanyManager->fetchAllExternalDeliveryCompanies();

        if (count($externalDeliveryCompanies) > 0) {
            foreach ($externalDeliveryCompanies as $externalDeliveryCompany) {
                $response[] = $this->autoMapping->map(ExternalDeliveryCompanyEntity::class, ExternalDeliveryCompanyFetchResponse::class,
                    $externalDeliveryCompany);
            }
        }

        return $response;
    }

    /**
     * deletes External Delivery Company Criteria by external company id
     */
    public function deleteExternalDeliveryCompanyCriteriaByExternalCompanyId(int $externalDeliveryCompanyId)
    {
        $this->adminExternalDeliveryCompanyCriteriaService->deleteExternalDeliveryCompanyCriteriaByExternalCompanyId($externalDeliveryCompanyId);
    }

    public function getExternallyDeliveredOrdersByExternalDeliveryCompanyId(int $externallyDeliveryCompanyId): array
    {
        return $this->adminExternallyDeliveredOrderGetService->getExternallyDeliveredOrdersByExternalDeliveryCompanyId($externallyDeliveryCompanyId);
    }

    /**
     * deletes External Delivery Company by external company id
     */
    public function deleteExternalDeliveryCompanyById(ExternalDeliveryCompanyDeleteByIdRequest $request): int|ExternalDeliveryCompanyDeleteResponse
    {
        // First, check if there are orders already had been sent to the company
        $externallyDeliveredOrders = $this->getExternallyDeliveredOrdersByExternalDeliveryCompanyId($request->getId());

        if (count($externallyDeliveredOrders) > 0) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_HAS_ORDERS_CONST;
        }

        // As long as there are no orders, then we can move forward in the deleting process
        // delete company criteria
        $this->deleteExternalDeliveryCompanyCriteriaByExternalCompanyId($request->getId());

        // Now we can continue deleting the external delivery company
        $externalDeliveryCompany = $this->adminExternalDeliveryCompanyManager->deleteExternalDeliveryCompanyById($request);

        if ($externalDeliveryCompany === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST;
        }

        return $this->autoMapping->map(ExternalDeliveryCompanyEntity::class, ExternalDeliveryCompanyDeleteResponse::class,
            $externalDeliveryCompany);
    }
}
