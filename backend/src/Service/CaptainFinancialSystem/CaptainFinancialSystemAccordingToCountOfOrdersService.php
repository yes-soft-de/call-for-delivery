<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemAccordingToCountOfOrdersEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfOrdersManager;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfOrdersResponse;

class CaptainFinancialSystemAccordingToCountOfOrdersService
{
    private CaptainFinancialSystemAccordingToCountOfOrdersManager $captainFinancialSystemAccordingToCountOfOrdersManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemAccordingToCountOfOrdersManager $captainFinancialSystemAccordingToCountOfOrdersManager)
    {
        $this->captainFinancialSystemAccordingToCountOfOrdersManager = $captainFinancialSystemAccordingToCountOfOrdersManager;
        $this->autoMapping = $autoMapping;
    }

    public function getAllCaptainFinancialSystemAccordingToCountOfOrders(): array
    {
        $response = [];

        $items = $this->captainFinancialSystemAccordingToCountOfOrdersManager->getAllCaptainFinancialSystemAccordingToCountOfOrders();

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map(CaptainFinancialSystemAccordingToCountOfOrdersEntity::class, CaptainFinancialSystemAccordingToCountOfOrdersResponse::class, $item);
        }

        return $response;
    }
}
