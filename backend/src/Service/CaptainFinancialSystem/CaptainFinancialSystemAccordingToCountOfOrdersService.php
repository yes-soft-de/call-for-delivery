<?php

namespace App\Service\CaptainFinancialSystem;

use App\AutoMapping;
use App\Entity\CaptainFinancialSystemAccordingToCountOfOrdersEntity;
use App\Manager\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfOrdersManager;
use App\Response\CaptainFinancialSystem\CaptainFinancialSystemAccordingToCountOfOrdersResponse;

class CaptainFinancialSystemAccordingToCountOfOrdersService
{
    private CaptainFinancialSystemAccordingToCountOfOrdersManager $CaptainFinancialSystemAccordingToCountOfOrdersManager;
    private AutoMapping $autoMapping;

    public function __construct(AutoMapping $autoMapping, CaptainFinancialSystemAccordingToCountOfOrdersManager $CaptainFinancialSystemAccordingToCountOfOrdersManager)
    {
        $this->CaptainFinancialSystemAccordingToCountOfOrdersManager = $CaptainFinancialSystemAccordingToCountOfOrdersManager;
        $this->autoMapping = $autoMapping;
    }

    public function getAllCaptainFinancialSystemAccordingToCountOfOrders(): array
    {
        $response = [];

        $items = $this->CaptainFinancialSystemAccordingToCountOfOrdersManager->getAllCaptainFinancialSystemAccordingToCountOfOrders();

        foreach ($items as $item) {
            $response[] = $this->autoMapping->map(CaptainFinancialSystemAccordingToCountOfOrdersEntity::class, CaptainFinancialSystemAccordingToCountOfOrdersResponse::class, $item);
        }

        return $response;
    }
}
