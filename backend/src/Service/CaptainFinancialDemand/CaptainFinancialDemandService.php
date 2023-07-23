<?php

namespace App\Service\CaptainFinancialDemand;

use App\AutoMapping;
use App\Constant\Captain\CaptainConstant;
use App\Constant\CaptainFinancialDemand\CaptainFinancialDemandConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Entity\CaptainEntity;
use App\Entity\CaptainFinancialDemandEntity;
use App\Entity\CaptainFinancialDuesEntity;
use App\Manager\CaptainFinancialDemand\CaptainFinancialDemandManager;
use App\Request\CaptainFinancialDemand\CaptainFinancialDemandCreateRequest;
use App\Response\CaptainFinancialDemand\CaptainFinancialDemandCreateResponse;
use App\Service\Captain\CaptainGetService;
use App\Service\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueGetService;

class CaptainFinancialDemandService
{
    public function __construct(
        private AutoMapping $autoMapping,
        private CaptainFinancialDemandManager $captainFinancialDemandManager,
        private CaptainGetService $captainGetService,
        private CaptainFinancialDueGetService $captainFinancialDueGetService
    )
    {
    }

    public function createCaptainFinancialDemand(CaptainFinancialDemandCreateRequest $request): string|int|CaptainFinancialDemandCreateResponse
    {
        // first get captain
        $captainEntity = $this->getCaptainProfileByCaptainUserId($request->getCaptain());

        if ($captainEntity === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        // get active and not paid captain financial due
        $captainFinancialDueEntity = $this->getCurrentAndActiveCaptainFinancialDueByCaptainProfileId($captainEntity->getId());

        if ($captainFinancialDueEntity === CaptainFinancialDues::FINANCIAL_NOT_FOUND) {
            return CaptainFinancialDues::FINANCIAL_NOT_FOUND;
        }

        // check if there is not previous demand for the current financial due
        $captainFinancialDemand = $this->getCaptainFinancialDemandByCaptainFinancialDueId($captainFinancialDueEntity->getId());

        if ($captainFinancialDemand !== CaptainFinancialDemandConstant::CAPTAIN_FINANCIAL_DEMAND_NOT_EXIST_CONST) {
            return CaptainFinancialDemandConstant::CAPTAIN_FINANCIAL_DEMAND_ALREADY_EXIST_CONST;
        }

        $request->setCaptain($captainEntity);
        $request->setCaptainFinancialDueId($captainFinancialDueEntity);

        $captainFinancialDemandEntity = $this->captainFinancialDemandManager->createCaptainFinancialDemand($request);

        return $this->autoMapping->map(CaptainFinancialDemandEntity::class, CaptainFinancialDemandCreateResponse::class,
            $captainFinancialDemandEntity);
    }

    public function getCaptainProfileByCaptainUserId(int $userId): CaptainEntity|string
    {
        return $this->captainGetService->getCaptainProfileByCaptainUserId($userId);
    }

    public function getCurrentAndActiveCaptainFinancialDueByCaptainProfileId(int $captainProfileId): int|CaptainFinancialDuesEntity
    {
        return $this->captainFinancialDueGetService->getCurrentAndActiveCaptainFinancialDueByCaptainProfileId($captainProfileId);
    }

    public function getCaptainFinancialDemandByCaptainFinancialDueId(int $captainFinancialDueId): int|array
    {
        $captainFinancialDemand = $this->captainFinancialDemandManager->getCaptainFinancialDemandByCaptainFinancialDueId($captainFinancialDueId);

        if (count($captainFinancialDemand) === 0) {
            return CaptainFinancialDemandConstant::CAPTAIN_FINANCIAL_DEMAND_NOT_EXIST_CONST;
        }

        return $captainFinancialDemand;
    }
}
