<?php

namespace App\Service\CompanyInfo;

use App\AutoMapping;
use App\Constant\CompanyInfo\CompanyInfoConstant;
use App\Entity\CompanyInfoEntity;
use App\Manager\CompanyInfo\CompanyInfoManager;
use App\Request\CompanyInfo\CompanyInfoCreateRequest;
use App\Response\CompanyInfo\CompanyInfoForUserGetResponse;
use App\Response\CompanyInfo\CompanyInfoGetResponse;

class CompanyInfoService
{
    private AutoMapping $autoMapping;
    private CompanyInfoManager $companyInfoManager;

    public function __construct(AutoMapping $autoMapping, CompanyInfoManager $companyInfoManager)
    {
        $this->autoMapping = $autoMapping;
        $this->companyInfoManager = $companyInfoManager;
    }

    public function create(CompanyInfoCreateRequest $request)
    {
        $companyInfoResult = $this->companyInfoManager->create($request);

        if ($companyInfoResult === CompanyInfoConstant::COMPANY_INFO_EXISTS) {
            return $this->getCompanyInfo();

        } else {
            return $this->autoMapping->map(CompanyInfoEntity::class, CompanyInfoGetResponse::class, $companyInfoResult);
        }
    }

    public function update($request): string|CompanyInfoGetResponse
    {
        $companyInfoResult = $this->companyInfoManager->update($request);

        if($companyInfoResult === CompanyInfoConstant::COMPANY_INFO_NOT_EXISTS) {
            return CompanyInfoConstant::COMPANY_INFO_NOT_EXISTS;
        }

        return $this->autoMapping->map(CompanyInfoEntity::class, CompanyInfoGetResponse::class, $companyInfoResult);
    }

    public function getCompanyInfo(): ?CompanyInfoGetResponse
    {
        $companyInfoResult = $this->companyInfoManager->getCompanyInfo();

        return $this->autoMapping->map('array', CompanyInfoGetResponse::class, $companyInfoResult);
    }

    public function getCompanyInfoForUser(string $requiredByUserType, string $userId): ?CompanyInfoForUserGetResponse
    {
        $companyInfoResult = $this->companyInfoManager->getCompanyInfoForUser($requiredByUserType, $userId);

        return $this->autoMapping->map('array', CompanyInfoForUserGetResponse::class, $companyInfoResult);
    }
}
