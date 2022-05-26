<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemAccordingToCountOfOrdersEntity;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersManager;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateRequest;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateResponse;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingToCountOfOrdersUpdateRequest;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDeleteResponse;

class AdminCaptainFinancialSystemAccordingToCountOfOrdersService
{
    private AutoMapping $autoMapping;
    private AdminCaptainFinancialSystemAccordingToCountOfOrdersManager $adminCaptainFinancialSystemAccordingToCountOfOrdersManager;

    public function __construct(AutoMapping $autoMapping, AdminCaptainFinancialSystemAccordingToCountOfOrdersManager $adminCaptainFinancialSystemAccordingToCountOfOrdersManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminCaptainFinancialSystemAccordingToCountOfOrdersManager = $adminCaptainFinancialSystemAccordingToCountOfOrdersManager;
    }

    public function createCaptainFinancialSystemAccordingToCountOfOrders(AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateRequest $request): AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateResponse
    {
        $result = $this->adminCaptainFinancialSystemAccordingToCountOfOrdersManager->createCaptainFinancialSystemAccordingToCountOfOrders($request);

        return $this->autoMapping->map(CaptainFinancialSystemAccordingToCountOfOrdersEntity::class, AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateResponse::class, $result);
    }

    public function getAllCaptainFinancialSystemAccordingToCountOfOrders(): array
    {
        $response = [];

        $items = $this->adminCaptainFinancialSystemAccordingToCountOfOrdersManager->getAllCaptainFinancialSystemAccordingToCountOfOrders();

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map(CaptainFinancialSystemAccordingToCountOfOrdersEntity::class, AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateResponse::class, $item);
        }

        return $response;
    }
    
    public function updateCaptainFinancialSystemAccordingToCountOfOrders(AdminCaptainFinancialSystemAccordingToCountOfOrdersUpdateRequest $request): ?AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateResponse
    {
        $result = $this->adminCaptainFinancialSystemAccordingToCountOfOrdersManager->updateCaptainFinancialSystemAccordingToCountOfOrders($request);

        return $this->autoMapping->map(CaptainFinancialSystemAccordingToCountOfOrdersEntity::class, AdminCaptainFinancialSystemAccordingToCountOfOrdersCreateResponse::class, $result);
    }
    
    public function deleteCaptainFinancialSystemAccordingToCountOfHoursByAdmin($id): ?AdminCaptainFinancialSystemDeleteResponse
    {
        $result = $this->adminCaptainFinancialSystemAccordingToCountOfOrdersManager->deleteCaptainFinancialSystemAccordingToCountOfHoursByAdmin($id);

        return $this->autoMapping->map(CaptainFinancialSystemAccordingToCountOfOrdersEntity::class, AdminCaptainFinancialSystemDeleteResponse::class, $result);
    }
}
