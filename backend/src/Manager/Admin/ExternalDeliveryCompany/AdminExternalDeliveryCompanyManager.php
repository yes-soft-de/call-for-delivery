<?php

namespace App\Manager\Admin\ExternalDeliveryCompany;

use App\AutoMapping;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyResultConstant;
use App\Constant\ExternalDeliveryCompany\ExternalDeliveryCompanyStatusConstant;
use App\Entity\ExternalDeliveryCompanyEntity;
use App\Repository\ExternalDeliveryCompanyEntityRepository;
use App\Request\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyCreateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyDeleteByIdRequest;
use App\Request\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyStatusUpdateByAdminRequest;
use App\Request\Admin\ExternalDeliveryCompany\ExternalDeliveryCompanyUpdateByAdminRequest;
use Doctrine\ORM\EntityManagerInterface;

class AdminExternalDeliveryCompanyManager
{
    public function __construct(
        private AutoMapping $autoMapping,
        private EntityManagerInterface $entityManager,
        private ExternalDeliveryCompanyEntityRepository $externalDeliveryCompanyEntityRepository
    )
    {
    }

    public function createExternalDeliveryCompany(ExternalDeliveryCompanyCreateByAdminRequest $request): ExternalDeliveryCompanyEntity
    {
//        if (! ($request->getStatus())) {
//            $request->setStatus(ExternalDeliveryCompanyStatusConstant::STATUS_FALSE_CONST);
//        }

        $externalDeliveryCompanyEntity = $this->autoMapping->map(ExternalDeliveryCompanyCreateByAdminRequest::class,
            ExternalDeliveryCompanyEntity::class, $request);

        $this->entityManager->persist($externalDeliveryCompanyEntity);
        $this->entityManager->flush();

        return $externalDeliveryCompanyEntity;
    }

    public function updateExternalDeliveryCompanyStatus(ExternalDeliveryCompanyStatusUpdateByAdminRequest $request): int|ExternalDeliveryCompanyEntity
    {
        $externalDeliveryCompanyEntity = $this->externalDeliveryCompanyEntityRepository->findOneBy(['id' => $request->getId()]);

        if (! $externalDeliveryCompanyEntity) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST;
        }

        $externalDeliveryCompanyEntity = $this->autoMapping->mapToObject(ExternalDeliveryCompanyStatusUpdateByAdminRequest::class,
            ExternalDeliveryCompanyEntity::class, $request, $externalDeliveryCompanyEntity);

        $this->entityManager->flush();

        return $externalDeliveryCompanyEntity;
    }

    public function updateExternalDeliveryCompany(ExternalDeliveryCompanyUpdateByAdminRequest $request): int|ExternalDeliveryCompanyEntity
    {
        $externalDeliveryCompanyEntity = $this->externalDeliveryCompanyEntityRepository->findOneBy(['id' => $request->getId()]);

        if (! $externalDeliveryCompanyEntity) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST;
        }

        $externalDeliveryCompanyEntity = $this->autoMapping->mapToObject(ExternalDeliveryCompanyUpdateByAdminRequest::class,
            ExternalDeliveryCompanyEntity::class, $request, $externalDeliveryCompanyEntity);

        $this->entityManager->flush();

        return $externalDeliveryCompanyEntity;
    }

    public function fetchAllExternalDeliveryCompanies(): array
    {
        return $this->externalDeliveryCompanyEntityRepository->findBy([], ['id' => 'DESC']);
    }

    public function deleteExternalDeliveryCompanyById(ExternalDeliveryCompanyDeleteByIdRequest $request): int|ExternalDeliveryCompanyEntity
    {
        $externalDeliveryCompanyEntity = $this->externalDeliveryCompanyEntityRepository->findOneBy(['id' => $request->getId()]);

        if (! $externalDeliveryCompanyEntity) {
            return ExternalDeliveryCompanyResultConstant::EXTERNAL_DELIVERY_COMPANY_NOT_FOUND_CONST;
        }

        $this->entityManager->remove($externalDeliveryCompanyEntity);
        $this->entityManager->flush();

        return $externalDeliveryCompanyEntity;
    }

    public function getExternalDeliveryCompanyEntityById(int $id): ?ExternalDeliveryCompanyEntity
    {
        return $this->externalDeliveryCompanyEntityRepository->findOneBy(['id' => $id]);
    }

    public function updateExternalDeliveryCompaniesStatusToFalse(int $companyId): array
    {
        $externalDeliveryCompanyEntities = $this->externalDeliveryCompanyEntityRepository->getAllExternalDeliveryCompaniesExceptSpecificOneById($companyId);

        if (count($externalDeliveryCompanyEntities) > 0) {
            foreach ($externalDeliveryCompanyEntities as $externalDeliveryCompanyEntity) {
                $externalDeliveryCompanyEntity->setStatus(ExternalDeliveryCompanyStatusConstant::STATUS_FALSE_CONST);
                $this->entityManager->flush();
            }
        }

        return $externalDeliveryCompanyEntities;
    }
}
