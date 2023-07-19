<?php

namespace App\Service\CaptainFinancialSystem\CaptainFinancialSystemCommand;

use App\Constant\CaptainFinancialSystem\CaptainFinancialSystem;
use App\Entity\CaptainFinancialDuesEntity;
use App\Entity\CaptainFinancialSystemDetailEntity;
use App\Request\CaptainFinancialSystem\CaptainFinancialSystemDetail\CaptainFinancialSystemDetailTypeAndIdUpdateRequest;
use App\Service\CaptainFinancialSystem\CaptainFinancialDue\CaptainFinancialDueHandleService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemDetail\CaptainFinancialSystemDetailGetService;
use App\Service\CaptainFinancialSystem\CaptainFinancialSystemDetailService;

class CaptainFinancialSystemUpdateCommandService
{
    public function __construct(
        private CaptainFinancialSystemDetailGetService $captainFinancialSystemDetailGetService,
        private CaptainFinancialDueHandleService $captainFinancialDueHandleService,
        private CaptainFinancialSystemDetailService $captainFinancialSystemDetailService
    )
    {
    }

    /**
     * Get all captain financial system details except captainFinancialSystemType = 4
     */
    public function getAllCaptainFinancialSystemDetailsExceptFinancialDefaultSystem(): array
    {
        return $this->captainFinancialSystemDetailGetService->getAllCaptainFinancialSystemDetailsExceptFinancialDefaultSystem();
    }

    /**
     * Stops last active captain financial cycle
     */
    public function stopLastActiveCaptainFinancialDueByCaptainProfileId(int $captainProfileId): int|CaptainFinancialDuesEntity
    {
        return $this->captainFinancialDueHandleService->stopLastActiveCaptainFinancialDueByCaptainProfileId($captainProfileId);
    }

    public function updateCaptainFinancialSystemDetailCaptainFinancialSystemType(CaptainFinancialSystemDetailTypeAndIdUpdateRequest $request): string|CaptainFinancialSystemDetailEntity
    {
        return $this->captainFinancialSystemDetailService->updateCaptainFinancialSystemDetailCaptainFinancialSystemType($request);
    }

    /**
     * Main function
     * Updates current selected captain financial systems to the financial default system (4th one)
     */
    public function updateAllSelectedCaptainFinancialSystemToDefaultFinancialSystem(): int
    {
        // 1 Get all selected captain financial systems (except the default system - 4th one)
        $allCaptainFinancialSystemDetails = $this->getAllCaptainFinancialSystemDetailsExceptFinancialDefaultSystem();

        if (count($allCaptainFinancialSystemDetails) > 0) {
            foreach ($allCaptainFinancialSystemDetails as $captainFinancialSystemDetail) {
                // 2 End the financial cycle of the captain
                $this->stopLastActiveCaptainFinancialDueByCaptainProfileId($captainFinancialSystemDetail->getCaptain()->getId());
                // 3 Update the captain financial system detail to be subscribed with the financial default system
                $updateCaptainFinancialSystemDetailRequest = new CaptainFinancialSystemDetailTypeAndIdUpdateRequest();

                $updateCaptainFinancialSystemDetailRequest->setId($captainFinancialSystemDetail->getId());
                $updateCaptainFinancialSystemDetailRequest->setCaptainFinancialSystemType(CaptainFinancialSystem::CAPTAIN_FINANCIAL_DEFAULT_SYSTEM_CONST);
                $updateCaptainFinancialSystemDetailRequest->setCaptainFinancialSystemId(1);
                $updateCaptainFinancialSystemDetailRequest->setUpdatedBy(0);

                $this->updateCaptainFinancialSystemDetailCaptainFinancialSystemType($updateCaptainFinancialSystemDetailRequest);
            }
        }

        return CaptainFinancialSystem::ADVANCED_PAYMENT_NOT_EXIST_CONST;
    }
}
