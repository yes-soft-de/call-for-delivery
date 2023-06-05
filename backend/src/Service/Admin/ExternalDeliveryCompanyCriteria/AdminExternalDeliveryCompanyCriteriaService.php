<?php

namespace App\Service\Admin\ExternalDeliveryCompanyCriteria;

use App\AutoMapping;
use App\Constant\Admin\AdminProfileConstant;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaResultConstant;
use App\Entity\AdminProfileEntity;
use App\Entity\ExternalDeliveryCompanyCriteriaEntity;
use App\Entity\ExternalDeliveryCompanyEntity;
use App\Manager\Admin\ExternalDeliveryCompanyCriteria\AdminExternalDeliveryCompanyCriteriaManager;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaCreateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaDeleteByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaStatusUpdateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaUpdateByAdminRequest;
use App\Response\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaCreateByAdminResponse;
use App\Response\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaDeleteResponse;
use App\Response\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaUpdateByAdminResponse;
use App\Response\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyGetByExternalCompanyForAdminResponse;
use App\Service\Admin\AdminProfile\AdminProfileGetService;
use App\Service\Admin\ExternalDeliveryCompany\AdminExternalDeliveryCompanyGetService;

class AdminExternalDeliveryCompanyCriteriaService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminExternalDeliveryCompanyCriteriaManager $adminExternalDeliveryCompanyCriteriaManager,
        private AdminExternalDeliveryCompanyGetService $adminExternalDeliveryCompanyGetService,
        private AdminProfileGetService $adminProfileGetService
    )
    {
    }

    public function getExternalDeliveryCompanyEntityById(int $id): int|ExternalDeliveryCompanyEntity
    {
        return $this->adminExternalDeliveryCompanyGetService->getExternalDeliveryCompanyEntityById($id);
    }

    /**
     * Get admin profile entity if exists
     */
    public function getAdminProfileEntityByAdminUserId(int $adminUserId): AdminProfileEntity|string
    {
        return $this->adminProfileGetService->getAdminProfileEntityByAdminUserId($adminUserId);
    }

    /**
     * creates External Delivery Company Criteria
     */
    public function createExternalDeliveryCompanyCriteria(ExternalDeliveryCompanyCriteriaCreateByAdminRequest $request): int|ExternalDeliveryCompanyCriteriaCreateByAdminResponse
    {
        // First, check if external delivery company is exist
        $externalDeliveryCompanyEntity = $this->getExternalDeliveryCompanyEntityById($request->getExternalDeliveryCompany());

        if ($externalDeliveryCompanyEntity === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST;
        }

        $request->setExternalDeliveryCompany($externalDeliveryCompanyEntity);

        // Now continue creating the required company criteria
        $externalDeliveryCompanyCriteria = $this->adminExternalDeliveryCompanyCriteriaManager->createExternalDeliveryCompanyCriteria($request);

        return $this->autoMapping->map(ExternalDeliveryCompanyCriteriaEntity::class, ExternalDeliveryCompanyCriteriaCreateByAdminResponse::class,
            $externalDeliveryCompanyCriteria);
    }

    /**
     * updates External Delivery Company Criteria
     */
    public function updateExternalDeliveryCompanyCriteria(ExternalDeliveryCompanyCriteriaUpdateByAdminRequest $request, int $adminUserId): int|ExternalDeliveryCompanyCriteriaUpdateByAdminResponse
    {
        // First, get and set admin profile id
        $adminProfileEntity = $this->getAdminProfileEntityByAdminUserId($adminUserId);

        if ($adminProfileEntity === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;
        }

        $request->setUpdatedBy($adminProfileEntity);
        // Now continue updating the criteria
        $externalDeliveryCompanyCriteria = $this->adminExternalDeliveryCompanyCriteriaManager->updateExternalDeliveryCompanyCriteria($request);

        if ($externalDeliveryCompanyCriteria === ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST) {
            return ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST;
        }

        return $this->autoMapping->map(ExternalDeliveryCompanyCriteriaEntity::class, ExternalDeliveryCompanyCriteriaUpdateByAdminResponse::class,
            $externalDeliveryCompanyCriteria);
    }

    /**
     * updates the status External Delivery Company Criteria
     */
    public function updateExternalDeliveryCompanyCriteriaStatus(ExternalDeliveryCompanyCriteriaStatusUpdateByAdminRequest $request, int $adminUserId): int|ExternalDeliveryCompanyCriteriaUpdateByAdminResponse
    {
        // First, get and set admin profile id
        $adminProfileEntity = $this->getAdminProfileEntityByAdminUserId($adminUserId);

        if ($adminProfileEntity === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;
        }

        $request->setUpdatedBy($adminProfileEntity);
        // Now continue updating the criteria
        $externalDeliveryCompanyCriteria = $this->adminExternalDeliveryCompanyCriteriaManager->updateExternalDeliveryCompanyCriteriaStatus($request);

        if ($externalDeliveryCompanyCriteria === ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST) {
            return ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST;
        }

        return $this->autoMapping->map(ExternalDeliveryCompanyCriteriaEntity::class, ExternalDeliveryCompanyCriteriaUpdateByAdminResponse::class,
            $externalDeliveryCompanyCriteria);
    }

    /**
     * Fetch all External Delivery Company Criteria of a specific company
     */
    public function getExternalDeliveryCompanyCriteriaByExternalDeliveryCompanyId(int $externalDeliveryCompanyId): array
    {
        $response = [];

        $allExternalDeliveryCompanyCriteria = $this->adminExternalDeliveryCompanyCriteriaManager->fetchExternalDeliveryCompanyCriteriaByExternalDeliveryCompanyId($externalDeliveryCompanyId);

        if (count($allExternalDeliveryCompanyCriteria) > 0) {
            foreach ($allExternalDeliveryCompanyCriteria as $key => $value) {
                $response[$key] = $this->autoMapping->map(ExternalDeliveryCompanyCriteriaEntity::class,
                    ExternalDeliveryCompanyGetByExternalCompanyForAdminResponse::class, $value);
                // get and set admin name who update the criteria, if exist
                $adminProfile = $value->getUpdatedBy();

                if ($adminProfile) {
                    $response[$key]->updatedByAdminName = $adminProfile->getName();

                } else {
                    $response[$key]->updatedByAdminName = null;
                }
            }
        }

        return $response;
    }

    /**
     * deletes External Delivery Company Criteria by id
     */
    public function deleteExternalDeliveryCompanyCriteriaById(ExternalDeliveryCompanyCriteriaDeleteByAdminRequest $request): int|ExternalDeliveryCompanyCriteriaDeleteResponse
    {
        $externalDeliveryCompanyCriteria = $this->adminExternalDeliveryCompanyCriteriaManager->deleteExternalDeliveryCompanyCriteriaById($request);

        if ($externalDeliveryCompanyCriteria === ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST) {
            return ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST;
        }

        return $this->autoMapping->map(ExternalDeliveryCompanyCriteriaEntity::class, ExternalDeliveryCompanyCriteriaDeleteResponse::class,
            $externalDeliveryCompanyCriteria);
    }

    /**
     * deletes External Delivery Company Criteria by external company id
     */
    public function deleteExternalDeliveryCompanyCriteriaByExternalCompanyId(int $externalDeliveryCompanyId): array
    {
        return $this->adminExternalDeliveryCompanyCriteriaManager->deleteExternalDeliveryCompanyCriteriaByExternalCompanyId($externalDeliveryCompanyId);
    }
}
