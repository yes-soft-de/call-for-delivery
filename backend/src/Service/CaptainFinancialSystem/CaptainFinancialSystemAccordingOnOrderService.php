<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemAccordingOnOrderEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemAccordingOnOrderManager;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingOnOrderResponse;

class CaptainFinancialSystemAccordingOnOrderService
{
    private CaptainFinancialSystemAccordingOnOrderManager $CaptainFinancialSystemAccordingOnOrderManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemAccordingOnOrderManager $CaptainFinancialSystemAccordingOnOrderManager)
    {
        $this->autoMapping = $autoMapping;
        $this->CaptainFinancialSystemAccordingOnOrderManager = $CaptainFinancialSystemAccordingOnOrderManager;
    }

    public function getAllCaptainFinancialSystemAccordingOnOrder(): array
    {
        $response = [];

        $items = $this->CaptainFinancialSystemAccordingOnOrderManager->getAllCaptainFinancialSystemAccordingOnOrder();

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map(CaptainFinancialSystemAccordingOnOrderEntity::class, CaptainFinancialSystemAccordingOnOrderResponse::class, $item);
        }

        return $response;
    }
}
