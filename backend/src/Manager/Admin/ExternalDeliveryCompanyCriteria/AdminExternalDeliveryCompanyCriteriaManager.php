<?php

namespace App\Manager\Admin\ExternalDeliveryCompanyCriteria;

use App\AutoMapping;
use App\Constant\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaResultConstant;
use App\Entity\ExternalDeliveryCompanyCriteriaEntity;
use App\Repository\ExternalDeliveryCompanyCriteriaEntityRepository;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaCreateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaDeleteByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaStatusUpdateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompanyCriteria\ExternalDeliveryCompanyCriteriaUpdateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminExternalDeliveryCompanyCriteriaManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private ExternalDeliveryCompanyCriteriaEntityRepository $externalDeliveryCompanyCriteriaEntityRepository
    )
    {
    }

    /**
     * creates External Delivery Company Criteria
     */
    public function createExternalDeliveryCompanyCriteria(ExternalDeliveryCompanyCriteriaCreateByAdminRequest $request): ExternalDeliveryCompanyCriteriaEntity
    {
        $externalDeliveryCompanyCriteria = $this->autoMapping->map(ExternalDeliveryCompanyCriteriaCreateByAdminRequest::class,
            ExternalDeliveryCompanyCriteriaEntity::class, $request);

        $this->entityManager->persist($externalDeliveryCompanyCriteria);
        $this->entityManager->flush();

        return $externalDeliveryCompanyCriteria;
    }

    /**
     * updates External Delivery Company Criteria
     */
    public function updateExternalDeliveryCompanyCriteria(ExternalDeliveryCompanyCriteriaUpdateByAdminRequest $request): int|ExternalDeliveryCompanyCriteriaEntity
    {
        $externalDeliveryCompanyCriteria = $this->externalDeliveryCompanyCriteriaEntityRepository->findOneBy(['id' => $request->getId()]);

        if (! $externalDeliveryCompanyCriteria) {
            return ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST;
        }

        if (! $request->getStatus()) {
            $request->setStatus($externalDeliveryCompanyCriteria->getStatus());
        }

        $externalDeliveryCompanyCriteria = $this->autoMapping->mapToObject(ExternalDeliveryCompanyCriteriaUpdateByAdminRequest::class,
            ExternalDeliveryCompanyCriteriaEntity::class, $request, $externalDeliveryCompanyCriteria);

        $this->entityManager->flush();

        return $externalDeliveryCompanyCriteria;
    }

    /**
     * updates the status External Delivery Company Criteria
     */
    public function updateExternalDeliveryCompanyCriteriaStatus(ExternalDeliveryCompanyCriteriaStatusUpdateByAdminRequest $request): int|ExternalDeliveryCompanyCriteriaEntity
    {
        $externalDeliveryCompanyCriteria = $this->externalDeliveryCompanyCriteriaEntityRepository->findOneBy(['id' => $request->getId()]);

        if (!$externalDeliveryCompanyCriteria) {
            return ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST;
        }

        $externalDeliveryCompanyCriteria = $this->autoMapping->mapToObject(ExternalDeliveryCompanyCriteriaStatusUpdateByAdminRequest::class,
            ExternalDeliveryCompanyCriteriaEntity::class, $request, $externalDeliveryCompanyCriteria);

        $this->entityManager->flush();

        return $externalDeliveryCompanyCriteria;
    }

    /**
     * Fetch all External Delivery Company Criteria of a specific company
     */
    public function fetchExternalDeliveryCompanyCriteriaByExternalDeliveryCompanyId(int $externalDeliveryCompanyId): array
    {
        return $this->externalDeliveryCompanyCriteriaEntityRepository->findBy(['externalDeliveryCompany' => $externalDeliveryCompanyId],
            ['id' => 'DESC']);
    }

    /**
     * deletes External Delivery Company Criteria by id
     */
    public function deleteExternalDeliveryCompanyCriteriaById(ExternalDeliveryCompanyCriteriaDeleteByAdminRequest $request): ExternalDeliveryCompanyCriteriaEntity|int
    {
        $externalDeliveryCompanyCriteria = $this->externalDeliveryCompanyCriteriaEntityRepository->findOneBy(['id' => $request->getId()]);

        if (!$externalDeliveryCompanyCriteria) {
            return ExternalDeliveryCompanyCriteriaResultConstant::EXTERNAL_DELIVERY_COMPANY_CRITERIA_NOT_FOUND_CONST;
        }

        $this->entityManager->remove($externalDeliveryCompanyCriteria);
        $this->entityManager->flush();

        return $externalDeliveryCompanyCriteria;
    }

    /**
     * deletes External Delivery Company Criteria by external company id
     */
    public function deleteExternalDeliveryCompanyCriteriaByExternalCompanyId(int $externalDeliveryCompanyId): array
    {
        $externalDeliveryCompanyCriteriaArray = $this->externalDeliveryCompanyCriteriaEntityRepository->findBy(['externalDeliveryCompany' => $externalDeliveryCompanyId]);

        if (count($externalDeliveryCompanyCriteriaArray) > 0) {
            foreach ($externalDeliveryCompanyCriteriaArray as $externalDeliveryCompanyCriteriaEntity) {
                $this->entityManager->remove($externalDeliveryCompanyCriteriaEntity);
                $this->entityManager->flush();
            }
        }

        return $externalDeliveryCompanyCriteriaArray;
    }

    /**
     * check if there is active and similar criteria for another company
     */
    public function getExternalDeliveryCompanyCriteriaBySpecificCriteriaAndCompany(int $externalDeliveryCompanyId,
                                                                                   bool $isSpecificDate,
                                                                                   int $isDistance,
                                                                                   int $payment,
                                                                                   bool $isFromAllStores,
                                                                                   ?float $cacheLimit = null)
    {
        return $this->externalDeliveryCompanyCriteriaEntityRepository->getExternalDeliveryCompanyCriteriaBySpecificCriteriaAndCompany(
            $externalDeliveryCompanyId, $isSpecificDate, $isDistance, $payment, $isFromAllStores, $cacheLimit);
    }

    public function getExternalDeliveryCompanyCriteriaById(int $externalDeliveryCompanyCriteriaId): ?ExternalDeliveryCompanyCriteriaEntity
    {
        return $this->externalDeliveryCompanyCriteriaEntityRepository->findOneBy(['id' => $externalDeliveryCompanyCriteriaId]);
    }
}
