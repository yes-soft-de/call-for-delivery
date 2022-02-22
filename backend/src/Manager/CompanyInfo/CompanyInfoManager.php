<?php

namespace App\Manager\CompanyInfo;

use App\AutoMapping;
use App\Constant\CompanyInfo\CompanyInfoConstant;
use App\Entity\CompanyInfoEntity;
use App\Repository\CompanyInfoEntityRepository;
use App\Request\CompanyInfo\CompanyInfoCreateRequest;
use App\Request\CompanyInfo\CompanyInfoUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class CompanyInfoManager
{
    private AutoMapping $autoMapping;
    private EntityManagerInterface $entityManager;
    private CompanyInfoEntityRepository $companyInfoEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, CompanyInfoEntityRepository $companyInfoEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->companyInfoEntityRepository = $companyInfoEntityRepository;
    }

    public function create(CompanyInfoCreateRequest $request)
    {
        $companyInfoAll = $this->getCompanyInfo();

        if (! $companyInfoAll) {
            $companyInfoEntity = $this->autoMapping->map(CompanyInfoCreateRequest::class, CompanyInfoEntity::class, $request);

            $this->entityManager->persist($companyInfoEntity);
            $this->entityManager->flush();

            return $companyInfoEntity;
        }
        else {
            return CompanyInfoConstant::COMPANY_INFO_EXISTS;
        }
    }

    public function update(CompanyInfoUpdateRequest $request): string|CompanyInfoEntity
    {
        $companyInfoResult = $this->companyInfoEntityRepository->find($request->getId());

        if (! $companyInfoResult) {
            return CompanyInfoConstant::COMPANY_INFO_NOT_EXISTS;
        }

        $companyInfoResult = $this->autoMapping->mapToObject(CompanyInfoUpdateRequest::class, CompanyInfoEntity::class, $request, $companyInfoResult);

        $this->entityManager->flush();

        return $companyInfoResult;
    }

    public function getCompanyInfo(): ?array
    {
        return $this->companyInfoEntityRepository->getCompanyInfo();
    }

    public function getCompanyInfoForUser(string $requiredByUserType, string $userId): ?array
    {
        return $this->companyInfoEntityRepository->getCompanyInfoForUser($requiredByUserType, $userId);
    }
}
