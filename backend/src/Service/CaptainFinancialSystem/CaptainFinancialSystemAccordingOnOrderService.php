<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemAccordingOnOrderEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemAccordingOnOrderManager;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingOnOrderResponse;

class CaptainFinancialSystemAccordingOnOrderService
{
    private CaptainFinancialSystemAccordingOnOrderManager $captainFinancialSystemAccordingOnOrderManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemAccordingOnOrderManager $captainFinancialSystemAccordingOnOrderManager)
    {
        $this->autoMapping = $autoMapping;
        $this->captainFinancialSystemAccordingOnOrderManager = $captainFinancialSystemAccordingOnOrderManager;
    }

    public function getAllCaptainFinancialSystemAccordingOnOrder(): array
    {
        $response = [];

        $items = $this->captainFinancialSystemAccordingOnOrderManager->getAllCaptainFinancialSystemAccordingOnOrder();

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map(CaptainFinancialSystemAccordingOnOrderEntity::class, CaptainFinancialSystemAccordingOnOrderResponse::class, $item);
        }

        return $response;
    }
}
