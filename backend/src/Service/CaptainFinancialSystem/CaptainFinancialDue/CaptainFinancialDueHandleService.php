<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialDue;

use App\Constant\Captain\CaptainConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueResultConstant;
use App\Constant\CaptainFinancialSystem\CaptainFinancialDues;
use App\Entity\CaptainEntity;
use App\Entity\CaptainFinancialDuesEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialDuesManager;
use App\Request\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueCreateRequest;
use App\Request\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueStoppedFinancialCycleUpdateRequest;
use App\Service\Captain\CaptainGetService;
use DateTime;

/**
 * Responsible for handling captain financial due, like checking if exists and creating new one
 * by Rami
 */
class CaptainFinancialDueHandleService
{
    public function __construct(
        private CaptainGetService $captainGetService,
        private CaptainFinancialDuesManager $captainFinancialDuesManager
    )
    {
    }

    public function getCaptainProfileEntityById(int $captainProfileId): CaptainEntity|string
    {
        return $this->captainGetService->getCaptainProfileEntityById($captainProfileId);
    }

    /**
     * Get the start and end dates of the current active financial cycle of the captain
     */
    public function getCurrentAndActiveCaptainFinancialDueByCaptain(int $captainProfileId): int|CaptainFinancialDuesEntity
    {
        $captainFinancialDueArrayResult = $this->captainFinancialDuesManager->getCurrentAndActiveCaptainFinancialDueByCaptainProfileId($captainProfileId);

        if (count($captainFinancialDueArrayResult) === 0) {
            return CaptainFinancialDueResultConstant::CAPTAIN_FINANCIAL_DUE_NOT_EXIST_CONST;
        }

        return $captainFinancialDueArrayResult[0];
    }

    public function initiateAndReturnCaptainFinancialDueCreateRequest(CaptainEntity $captainEntity, float $amount, float $amountForStore,
                                                                      \DateTime $fromDate, \DateTime $toDate, int $state, int $status,
                                                                      int $statusAmountForStore = null): CaptainFinancialDueCreateRequest
    {
        $captainFinancialDueCreateRequest = new CaptainFinancialDueCreateRequest();

        $captainFinancialDueCreateRequest->setCaptain($captainEntity);
        $captainFinancialDueCreateRequest->setAmount($amount);
        $captainFinancialDueCreateRequest->setStatusAmountForStore($statusAmountForStore);
        $captainFinancialDueCreateRequest->setStatus($status);
        $captainFinancialDueCreateRequest->setStartDate($fromDate);
        $captainFinancialDueCreateRequest->setEndDate($toDate);
        $captainFinancialDueCreateRequest->setAmountForStore($amountForStore);
        $captainFinancialDueCreateRequest->setState($state);

        return $captainFinancialDueCreateRequest;
    }

    public function createCaptainFinancialDueForSpecificCaptain(int $captainProfileId, float $amount, float $amountForStore,
                                                                \DateTime $fromDate, \DateTime $toDate, int $state, int $status,
                                                                int $statusAmountForStore = null): string|CaptainFinancialDuesEntity
    {
        $captainProfile = $this->getCaptainProfileEntityById($captainProfileId);

        if ($captainProfile === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
            return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
        }

        $captainFinancialDueCreateRequest = $this->initiateAndReturnCaptainFinancialDueCreateRequest($captainProfile,
            $amount, $amountForStore, $fromDate, $toDate, $state, $status, $statusAmountForStore);

        return $this->captainFinancialDuesManager->createCaptainFinancialDue($captainFinancialDueCreateRequest);
    }

    public function getCurrentAndActiveCaptainFinancialDueStartAndEndDatesByCaptainProfileId(int $captainProfileId, \DateTime $fromDate, \DateTime $toDate): array|string
    {
        // Get current and active captain financial due
        $captainFinancialDueResult = $this->getCurrentAndActiveCaptainFinancialDueByCaptain($captainProfileId);

        if ($captainFinancialDueResult === CaptainFinancialDueResultConstant::CAPTAIN_FINANCIAL_DUE_NOT_EXIST_CONST) {
            // Create new captain financial due
            $captainFinancialCreateResult = $this->createCaptainFinancialDueForSpecificCaptain($captainProfileId,
                0.0, 0.0, $fromDate, $toDate, CaptainFinancialDues::FINANCIAL_STATE_ACTIVE,
                CaptainFinancialDues::FINANCIAL_DUES_UNPAID);

            if ($captainFinancialCreateResult === CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST) {
                return CaptainConstant::CAPTAIN_PROFILE_NOT_EXIST;
            }

            return [$captainFinancialCreateResult->getStartDate(), $captainFinancialCreateResult->getEndDate()];
        }

        return [$captainFinancialDueResult->getStartDate(), $captainFinancialDueResult->getEndDate()];
    }

    public function updateCaptainFinancialDueEndDateAndStateAndCaptainStoppedFinancialCycle(CaptainFinancialDueStoppedFinancialCycleUpdateRequest $request): ?CaptainFinancialDuesEntity
    {
        return $this->captainFinancialDuesManager->updateCaptainFinancialDueEndDateAndStateAndCaptainStoppedFinancialCycle($request);
    }

    /**
     * Stops last active captain financial cycle
     */
    public function stopLastActiveCaptainFinancialDueByCaptainProfileId(int $captainProfileId): int|CaptainFinancialDuesEntity
    {
        // 1 Get last active captain financial due
        $captainFinancialDue = $this->getCurrentAndActiveCaptainFinancialDueByCaptain($captainProfileId);

        if ($captainFinancialDue === CaptainFinancialDueResultConstant::CAPTAIN_FINANCIAL_DUE_NOT_EXIST_CONST) {
            return CaptainFinancialDueResultConstant::CAPTAIN_FINANCIAL_DUE_NOT_EXIST_CONST;
        }

        // 2 Stop the captain financial due (financial cycle)
        $updateRequest = new CaptainFinancialDueStoppedFinancialCycleUpdateRequest();

        $updateRequest->setId($captainFinancialDue->getId());
        $updateRequest->setState(CaptainFinancialDues::FINANCIAL_STATE_INACTIVE);
        $updateRequest->setEndDate(new DateTime('now'));
        $updateRequest->setCaptainStoppedFinancialCycle(CaptainFinancialDues::CAPTAIN_STOPPED_FINANCIAL_CYCLE_TRUE_CONST);

        $updatedCaptainFinancialDue = $this->updateCaptainFinancialDueEndDateAndStateAndCaptainStoppedFinancialCycle($updateRequest);

        if (! $updatedCaptainFinancialDue) {
            return CaptainFinancialDueResultConstant::CAPTAIN_FINANCIAL_DUE_NOT_EXIST_CONST;
        }

        return $updatedCaptainFinancialDue;
    }
}
