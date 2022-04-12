<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemAccordingToCountOfHoursEntity;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursManager;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursCreateRequest;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursCreateResponse;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfHoursUpdateRequest;

class AdminCaptainFinancialSystemAccordingToCountOfHoursService
{
    private AutoMapping $autoMapping;
    private AdminCaptainFinancialSystemAccordingToCountOfHoursManager $adminCaptainFinancialSystemAccordingToCountOfHoursManager;

    public function __construct(AutoMapping $autoMapping, AdminCaptainFinancialSystemAccordingToCountOfHoursManager $adminCaptainFinancialSystemAccordingToCountOfHoursManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminCaptainFinancialSystemAccordingToCountOfHoursManager = $adminCaptainFinancialSystemAccordingToCountOfHoursManager;
    }

    public function createCaptainFinancialSystemAccordingToCountOfHours(AdminCaptainFinancialSystemAccordingToCountOfHoursCreateRequest $request): AdminCaptainFinancialSystemAccordingToCountOfHoursCreateResponse
    {
        $result = $this->adminCaptainFinancialSystemAccordingToCountOfHoursManager->createCaptainFinancialSystemAccordingToCountOfHours($request);

        return $this->autoMapping->map(CaptainFinancialSystemAccordingToCountOfHoursEntity::class, AdminCaptainFinancialSystemAccordingToCountOfHoursCreateResponse::class, $result);
    }

    public function getAllCaptainFinancialSystemAccordingToCountOfHours(): array
    {
        $response = [];

        $items = $this->adminCaptainFinancialSystemAccordingToCountOfHoursManager->getAllCaptainFinancialSystemAccordingToCountOfHours();

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map(CaptainFinancialSystemAccordingToCountOfHoursEntity::class, AdminCaptainFinancialSystemAccordingToCountOfHoursCreateResponse::class, $item);
        }

        return $response;
    }
    
    public function updateCaptainFinancialSystemAccordingToCountOfHours(AdminCaptainFinancialSystemAccordingToCountOfHoursUpdateRequest $request): ?AdminCaptainFinancialSystemAccordingToCountOfHoursCreateResponse
    {
        $result = $this->adminCaptainFinancialSystemAccordingToCountOfHoursManager->updateCaptainFinancialSystemAccordingToCountOfHours($request);

        return $this->autoMapping->map(CaptainFinancialSystemAccordingToCountOfHoursEntity::class, AdminCaptainFinancialSystemAccordingToCountOfHoursCreateResponse::class, $result);
    }
}
