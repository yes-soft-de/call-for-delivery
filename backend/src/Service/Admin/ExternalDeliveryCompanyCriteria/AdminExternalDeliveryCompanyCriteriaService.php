<?php

namespace App\Service\Admin\ExternalDeliveryCompanyCriteria;

use App\AutoMapping;
use App\Constant\Admin\AdminProfileConstant;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaIsDistanceConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaIsSpecificDateConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaResultConstant;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaStatusConstant;
use App\Entity\AdminProfileEntity;
use App\Entity\ExternalDeliveryCompanyCriteriaEntity;
use App\Entity\ExternalDeliveryCompanyEntity;
use App\Manager\Admin\ExternalDeliveryCompanyCriteria\AdminExternalDeliveryCompanyCriteriaManager;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaCreateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaDeleteByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaStatusUpdateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaUpdateByAdminRequest;
use App\Response\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaAlreadyExistResponse;
use App\Response\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaCreateByAdminResponse;
use App\Response\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaDeleteResponse;
use App\Response\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaUpdateByAdminResponse;
use App\Response\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyGetByExternalCompanyForAdminResponse;
use App\Service\Admin\AdminProfile\AdminProfileGetService;
use App\Service\Admin\ExternalDeliveryCompany\AdminExternalDeliveryCompanyGetService;
use App\Service\Admin\StoreOwnerBranch\AdminStoreOwnerBranchGetService;
use DateTimeInterface;

class AdminExternalDeliveryCompanyCriteriaService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private AdminExternalDeliveryCompanyCriteriaManager $adminExternalDeliveryCompanyCriteriaManager,
        private AdminExternalDeliveryCompanyGetService $adminExternalDeliveryCompanyGetService,
        private AdminProfileGetService $adminProfileGetService,
        private AdminStoreOwnerBranchGetService $adminStoreOwnerBranchGetService
    )
    {
    }

    public function getStoreBranchesNamesByIdArray(array $branchesId): array
    {
        return $this->adminStoreOwnerBranchGetService->getStoreBranchesNamesByIdArray($branchesId);
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
    public function createExternalDeliveryCompanyCriteria(ExternalDeliveryCompanyCriteriaCreateByAdminRequest $request): int|ExternalDeliveryCompanyCriteriaCreateByAdminResponse|array
    {
        // First, check if external delivery company is exist
        $externalDeliveryCompanyEntity = $this->getExternalDeliveryCompanyEntityById($request->getExternalDeliveryCompany());

        if ($externalDeliveryCompanyEntity === ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST;
        }

        $request->setExternalDeliveryCompany($externalDeliveryCompanyEntity);
        // Convert from and to dates from string to DateTime before persisting to the database
        if (($request->getFromDate()) && ($request->getFromDate() !== "")) {
            $request->setFromDate(new \DateTime($request->getFromDate()));

        } else {
            $request->setFromDate(null);
        }

        if (($request->getToDate()) && ($request->getToDate() !== "")) {
            $request->setToDate(new \DateTime($request->getToDate()));

        } else {
            $request->setToDate(null);
        }

        // Make sure there are no similar criteria for another company
        $criteriaExist = $this->isThereSimilarCriteriaForDifferentCompany($request->getExternalDeliveryCompany()->getId(),
            $request->isSpecificDate(), $request->getIsDistance(), $request->getPayment(), $request->isFromAllStores(),
            $request->getCashLimit(), $request->getFromDistance(), $request->getToDistance(), $request->getFromDate(),
            $request->getToDate());

        // Now continue creating the required company criteria
        $externalDeliveryCompanyCriteria = $this->adminExternalDeliveryCompanyCriteriaManager->createExternalDeliveryCompanyCriteria($request);

        if (is_array($criteriaExist)) {
            $response = [];

            foreach ($criteriaExist as $criteria) {
                $response[] = $this->autoMapping->map('array', ExternalDeliveryCompanyCriteriaAlreadyExistResponse::class,
                    $criteria);
            }

            return $response;
        }

        return $this->autoMapping->map(ExternalDeliveryCompanyCriteriaEntity::class, ExternalDeliveryCompanyCriteriaCreateByAdminResponse::class,
            $externalDeliveryCompanyCriteria);
    }

    /**
     * updates External Delivery Company Criteria
     */
    public function updateExternalDeliveryCompanyCriteria(ExternalDeliveryCompanyCriteriaUpdateByAdminRequest $request, int $adminUserId): int|ExternalDeliveryCompanyCriteriaUpdateByAdminResponse|array
    {
        // First, get and set admin profile id
        $adminProfileEntity = $this->getAdminProfileEntityByAdminUserId($adminUserId);

        if ($adminProfileEntity === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;
        }

        $request->setUpdatedBy($adminProfileEntity);

        // Make sure there are no similar criteria for another company
        $company = $this->getExternalDeliveryCompanyIdByCriteriaId($request->getId());

        if ($company === ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST) {
            return ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST;
        }

        $request->setExternalDeliveryCompany($company);

        // check if there is active and similar criteria for another company
        $criteriaExist = $this->isThereSimilarCriteriaForDifferentCompany($request->getExternalDeliveryCompany()->getId(),
            $request->isSpecificDate(), $request->getIsDistance(), $request->getPayment(), $request->isFromAllStores(),
            $request->getCashLimit(), $request->getFromDistance(), $request->getToDistance(), $request->getFromDate(),
            $request->getToDate());

        if (is_array($criteriaExist)) {
            // Already there is active similar criteria for another company, so continue updating but with inactive status
            $request->setStatus(ExternalDeliveryCompanyCriteriaStatusConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_STATUS_FALSE_CONST);

            $response = [];

            foreach ($criteriaExist as $criteria) {
                $response[] = $this->autoMapping->map('array', ExternalDeliveryCompanyCriteriaAlreadyExistResponse::class,
                    $criteria);
            }

            // Now continue updating the criteria
            $externalDeliveryCompanyCriteria = $this->adminExternalDeliveryCompanyCriteriaManager->updateExternalDeliveryCompanyCriteria($request);

        } else {
            // No active and similar criteria does exist, continue updating normally
            $externalDeliveryCompanyCriteria = $this->adminExternalDeliveryCompanyCriteriaManager->updateExternalDeliveryCompanyCriteria($request);

            $response = $this->autoMapping->map(ExternalDeliveryCompanyCriteriaEntity::class, ExternalDeliveryCompanyCriteriaUpdateByAdminResponse::class,
                $externalDeliveryCompanyCriteria);
        }

        if ($externalDeliveryCompanyCriteria === ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST) {
            return ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST;
        }

        return $response;
    }

    /**
     * updates the status External Delivery Company Criteria
     */
    public function updateExternalDeliveryCompanyCriteriaStatus(ExternalDeliveryCompanyCriteriaStatusUpdateByAdminRequest $request, int $adminUserId): int|ExternalDeliveryCompanyCriteriaUpdateByAdminResponse|array
    {
        // First, get and set admin profile id
        $adminProfileEntity = $this->getAdminProfileEntityByAdminUserId($adminUserId);

        if ($adminProfileEntity === AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST) {
            return AdminProfileConstant::ADMIN_PROFILE_NOT_EXIST;
        }

        $request->setUpdatedBy($adminProfileEntity);

        if ($request->isStatus() === ExternalDeliveryCompanyCriteriaStatusConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_STATUS_TRUE_CONST) {
            // check if there is active and similar criteria for another company
            $criteriaExist = $this->isThereSimilarCriteriaForDifferentCompanyByExternalDeliveryCompanyCriteriaId($request->getId());

            if ($criteriaExist === ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST) {
                return ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST;

            } elseif (is_array($criteriaExist)) {
                $response = [];

                foreach ($criteriaExist as $criteria) {
                    $response[] = $this->autoMapping->map('array', ExternalDeliveryCompanyCriteriaAlreadyExistResponse::class,
                        $criteria);
                }

                return $response;
            }
        }

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

                // get and set branches names
                $storesBranches = $value->getFromStoresBranches();

                if ($storesBranches) {
                    if (count($storesBranches) > 0) {
                        $response[$key]->fromStoresBranches = $this->getStoreBranchesNamesByIdArray($storesBranches);
                    }
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

    /**
     * check if there is active and similar criteria for another company
     */
    public function isThereSimilarCriteriaForDifferentCompany(
        int $externalDeliveryCompanyId,
        bool $isSpecificDate,
        int $isDistance,
        int $payment,
        bool $isFromAllStores,
        ?float $cacheLimit = null,
        ?float $fromDistance = null,
        ?float $toDistance = null,
        ?DateTimeInterface $fromDate = null,
        ?DateTimeInterface $toDate = null
    ): bool|array
    {
        $criteriaArray = $this->adminExternalDeliveryCompanyCriteriaManager->getExternalDeliveryCompanyCriteriaBySpecificCriteriaAndCompany($externalDeliveryCompanyId,
        $isSpecificDate, $isDistance, $payment, $isFromAllStores, $cacheLimit);

        if (count($criteriaArray) > 0) {
            $response = [];
            // $matchedArray = [];
            $isMatched = true;

            // 1. if distance is enabled, then check if the new distance space is within the already exist one, or include it
            if ($isDistance === ExternalDeliveryCompanyCriteriaIsDistanceConstant::IS_DISTANCE_STORE_BRANCH_TO_CLIENT_DISTANCE_CONST) {
                foreach ($criteriaArray as $key => $value) {
                    // If new criteria is match with just one single existing and active criteria, then stop the loop
                    // and return true
                    if ((($fromDistance < $value->getFromDistance()) && ($toDistance <= $value->getFromDistance()))
                        || (($fromDistance >= $value->getToDistance()) && ($toDistance > $value->getToDistance()))) {
                        // no overlap between distance spaces, jump to the next criteria
                        continue;

                    } else {
                        // An overlap is exist, return the matched company which the criteria belongs to
                        $response[$key]['id'] = $value->getId();
                        $response[$key]['externalCompanyName'] = $value->getExternalDeliveryCompany()->getCompanyName();

                        return $response;
                    }
                }
                // As long as there is no overlap between the existed distance spaces among all criteria
                $isMatched = false;
            }
            // 2. check time slices from both criteria, while no overlap between the distance spaces is exist among all criteria
            if ($isSpecificDate === ExternalDeliveryCompanyCriteriaIsSpecificDateConstant::IS_SPECIFIC_DATE_TRUE_CONST) {
                foreach ($criteriaArray as $key => $value) {
                    if ((($fromDate < $value->getFromDate()) && ($toDate <= $value->getFromDate()))
                        || (($toDate >= $value->getToDate()) && ($toDate > $value->getToDate()))) {
                        // no overlap between distance spaces, jump to the next criteria
                        continue;

                    } else {
                        // An overlap is exist, return the matched company which the criteria belongs to
                        $response[$key]['id'] = $value->getId();
                        $response[$key]['externalCompanyName'] = $value->getExternalDeliveryCompany()->getCompanyName();

                        return $response;
                    }
                }
                // As long as there is no overlap between the existed time slices among all criteria
                $isMatched = false;
            }

            if ($isMatched === true) {
                foreach ($criteriaArray as $key => $value) {
                    $response[$key]['id'] = $value->getId();
                    $response[$key]['externalCompanyName'] = $value->getExternalDeliveryCompany()->getCompanyName();
                }

                return $response;
            }
        }

        return false;
    }

    public function getExternalDeliveryCompanyIdByCriteriaId(int $externalDeliveryCompanyCriteriaId): int|ExternalDeliveryCompanyEntity
    {
        $externalDeliveryCompanyCriteria = $this->adminExternalDeliveryCompanyCriteriaManager->getExternalDeliveryCompanyCriteriaById($externalDeliveryCompanyCriteriaId);

        if (! $externalDeliveryCompanyCriteria) {
            return ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST;
        }

        return $externalDeliveryCompanyCriteria->getExternalDeliveryCompany();
    }

    public function isThereSimilarCriteriaForDifferentCompanyByExternalDeliveryCompanyCriteriaId(int $externalDeliveryCompanyCriteriaId): array|bool|int
    {
        // 1 Get External Delivery Company Criteria
        $externalDeliveryCompanyCriteria = $this->adminExternalDeliveryCompanyCriteriaManager->getExternalDeliveryCompanyCriteriaById($externalDeliveryCompanyCriteriaId);

        if (! $externalDeliveryCompanyCriteria) {
            return ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST;
        }

        // 2 Convert the entity to the create request in order to check if there is similar
        return $this->isThereSimilarCriteriaForDifferentCompany($externalDeliveryCompanyCriteria->getExternalDeliveryCompany()->getId(),
            $externalDeliveryCompanyCriteria->getIsSpecificDate(), $externalDeliveryCompanyCriteria->getIsDistance(),
            $externalDeliveryCompanyCriteria->getPayment(), $externalDeliveryCompanyCriteria->getIsFromAllStores(),
            $externalDeliveryCompanyCriteria->getCashLimit(), $externalDeliveryCompanyCriteria->getFromDistance(),
            $externalDeliveryCompanyCriteria->getToDistance(), $externalDeliveryCompanyCriteria->getFromDate(),
            $externalDeliveryCompanyCriteria->getToDate());
    }
}
