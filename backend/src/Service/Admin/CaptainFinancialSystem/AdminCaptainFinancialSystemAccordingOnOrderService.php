<?php

namespace App\Service\Admin\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemAccordingOnOrderEntity;
use App\Manager\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingOnOrderManager;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingOnOrderCreateRequest;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingOnOrderCreateResponse;
use App\Request\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemAccordingOnOrderUpdateRequest;
use App\Response\Admin\CaptainFinancialSystem\AdminCaptainFinancialSystemDeleteResponse;

class AdminCaptainFinancialSystemAccordingOnOrderService
{
    private AutoMapping $autoMapping;
    private AdminCaptainFinancialSystemAccordingOnOrderManager $adminCaptainFinancialSystemAccordingOnOrderManager;

    public function __construct(AutoMapping $autoMapping, AdminCaptainFinancialSystemAccordingOnOrderManager $adminCaptainFinancialSystemAccordingOnOrderManager)
    {
        $this->autoMapping = $autoMapping;
        $this->adminCaptainFinancialSystemAccordingOnOrderManager = $adminCaptainFinancialSystemAccordingOnOrderManager;
    }

    public function createCaptainFinancialSystemAccordingOnOrder(AdminCaptainFinancialSystemAccordingOnOrderCreateRequest $request): AdminCaptainFinancialSystemAccordingOnOrderCreateResponse
    {
        $result = $this->adminCaptainFinancialSystemAccordingOnOrderManager->createCaptainFinancialSystemAccordingOnOrder($request);

        return $this->autoMapping->map(CaptainFinancialSystemAccordingOnOrderEntity::class, AdminCaptainFinancialSystemAccordingOnOrderCreateResponse::class, $result);
    }

    public function getAllCaptainFinancialSystemAccordingOnOrder(): array
    {
        $response = [];

        $items = $this->adminCaptainFinancialSystemAccordingOnOrderManager->getAllCaptainFinancialSystemAccordingOnOrder();

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map(CaptainFinancialSystemAccordingOnOrderEntity::class, AdminCaptainFinancialSystemAccordingOnOrderCreateResponse::class, $item);
        }

        return $response;
    }
    
    public function updateCaptainFinancialSystemAccordingOnOrder(AdminCaptainFinancialSystemAccordingOnOrderUpdateRequest $request): ?AdminCaptainFinancialSystemAccordingOnOrderCreateResponse
    {
        $result = $this->adminCaptainFinancialSystemAccordingOnOrderManager->updateCaptainFinancialSystemAccordingOnOrder($request);

        return $this->autoMapping->map(CaptainFinancialSystemAccordingOnOrderEntity::class, AdminCaptainFinancialSystemAccordingOnOrderCreateResponse::class, $result);
    }
    
    public function getCaptainFinancialSystemAccordingOnOrder(): array
    {
       return $this->adminCaptainFinancialSystemAccordingOnOrderManager->getCaptainFinancialSystemAccordingOnOrder();
    }
    
    public function deleteCaptainFinancialSystemAccordingOnOrder($id): ?AdminCaptainFinancialSystemDeleteResponse
    {
        $result = $this->adminCaptainFinancialSystemAccordingOnOrderManager->deleteCaptainFinancialSystemAccordingOnOrder($id);

        return $this->autoMapping->map(CaptainFinancialSystemAccordingOnOrderEntity::class, AdminCaptainFinancialSystemDeleteResponse::class, $result);
    }
}
